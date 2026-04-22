#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "optparse"

options = {
  author: "Feiran Zhao",
  bib: nil,
  out: "_publications"
}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby scripts/import_publications_from_bib.rb --bib PATH [--author NAME] [--out DIR]"

  opts.on("--bib PATH", "Path to the BibTeX file") { |v| options[:bib] = v }
  opts.on("--author NAME", "Author name to match") { |v| options[:author] = v }
  opts.on("--out DIR", "Output directory for publication markdown files") { |v| options[:out] = v }
end.parse!

abort("Missing required option: --bib PATH") unless options[:bib]
abort("BibTeX file not found: #{options[:bib]}") unless File.exist?(options[:bib])

def normalize_text(text)
  return "" if text.nil?

  normalized = text.dup
  replacements = {
    /\\\{?\"o\}?/ => "o",
    /\\\{?\"u\}?/ => "u",
    /\\\{?\"a\}?/ => "a",
    /\\\{?\'e\}?/ => "e",
    /\\\{?\'a\}?/ => "a",
    /\\\{?\'i\}?/ => "i",
    /\\\{?\'o\}?/ => "o",
    /\\\{?\'u\}?/ => "u",
    /\\\{?c\}?/ => "c",
    /\\\{?ss\}?/ => "ss",
    /\\[a-zA-Z]+\s*/ => "",
    /[{}]/ => "",
    /\s+/ => " "
  }
  replacements.each { |pattern, replacement| normalized.gsub!(pattern, replacement) }
  normalized.strip
end

def extract_year(raw_year)
  match = raw_year.to_s.match(/(\d{4})/)
  match ? match[1].to_i : 1900
end

def month_for_entry(fields)
  venue = [fields["journal"], fields["booktitle"]].compact.join(" ").downcase
  raw_year = fields["year"].to_s.downcase
  return "12" if venue.include?("conference") || venue.include?("cdc") || venue.include?("decision and control")
  return "06" if venue.include?("ecc") || venue.include?("european control conference")
  return "10" if raw_year.include?("accepted")

  "01"
end

def first_sentence(text)
  clean = normalize_text(text)
  clean.end_with?(".") ? clean : "#{clean}."
end

def format_author_name(name)
  clean = normalize_text(name)
  parts = clean.split(",").map(&:strip)
  return clean if parts.length < 2

  "#{parts[1]} #{parts[0]}".strip
end

def format_authors(authors)
  authors.to_s.split(/\s+and\s+/i).map { |name| format_author_name(name) }.join(", ")
end

def slugify(text)
  normalize_text(text)
    .downcase
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/^-|-$/, "")
    .slice(0, 80)
end

def parse_entries(text)
  entries = []
  i = 0

  while i < text.length
    start = text.index("@", i)
    break unless start

    brace = text.index("{", start)
    break unless brace

    depth = 0
    j = brace
    while j < text.length
      char = text[j]
      if char == "{"
        depth += 1
      elsif char == "}"
        depth -= 1
        if depth.zero?
          entries << text[start..j]
          i = j + 1
          break
        end
      end
      j += 1
    end

    break if j >= text.length
  end

  entries
end

def parse_fields(entry)
  header = entry.lines.first
  type_match = header.match(/^@(\w+)\s*\{\s*([^,]+),/i)
  return nil unless type_match

  fields = {
    "entry_type" => type_match[1].downcase,
    "key" => type_match[2].strip
  }

  entry.each_line do |line|
    match = line.match(/^\s*([a-zA-Z]+)\s*=\s*[{"](.+?)[}"],?\s*$/)
    next unless match

    fields[match[1].downcase] = match[2].strip
  end

  fields
end

def author_match?(authors, target_author)
  clean_authors = normalize_text(authors).downcase
  normalized_target = normalize_text(target_author).downcase
  given, surname = normalized_target.split(" ", 2)

  clean_authors.include?(normalized_target) ||
    clean_authors.include?("#{given} #{surname}") ||
    clean_authors.include?("#{surname}, #{given}")
end

def publication_body(fields)
  authors = format_authors(fields["author"])
  venue_name = normalize_text(fields["journal"].to_s.empty? ? fields["booktitle"] : fields["journal"])
  year_text = normalize_text(fields["year"])
  venue_parts = [venue_name]
  venue_parts << year_text unless year_text.empty?
  if !fields["volume"].to_s.empty? && !fields["number"].to_s.empty?
    venue_parts << "#{normalize_text(fields['volume'])}(#{normalize_text(fields['number'])})"
  elsif !fields["volume"].to_s.empty?
    venue_parts << normalize_text(fields["volume"])
  end
  venue_parts << "pp. #{normalize_text(fields['pages'])}" unless fields["pages"].to_s.empty?

  lines = []
  lines << "**Authors:** #{authors}"
  lines << ""
  lines << "**Venue:** #{venue_parts.join(', ')}"
  lines << ""
  lines << "**BibTeX key:** `#{fields['key']}`"
  lines << ""

  doi = normalize_text(fields["doi"])
  arxiv = normalize_text(fields["journal"]).match(/arxiv:\s*([0-9.]+)/i)&.captures&.first
  if !doi.empty?
    lines << "**DOI:** <https://doi.org/#{doi}>"
    lines << ""
  elsif arxiv
    lines << "**Preprint:** <https://arxiv.org/abs/#{arxiv}>"
    lines << ""
  end

  lines.join("\n").rstrip + "\n"
end

root = Dir.pwd
output_dir = File.expand_path(options[:out], root)
FileUtils.mkdir_p(output_dir)

Dir.glob(File.join(output_dir, "*.md")).each do |path|
  next unless File.read(path).include?("generated_by_bib_import: true")

  File.delete(path)
end

bib_text = File.read(options[:bib], encoding: "UTF-8")
entries = parse_entries(bib_text)
generated = []

entries.each do |entry|
  fields = parse_fields(entry)
  next unless fields
  next unless author_match?(fields["author"], options[:author])

  title = normalize_text(fields["title"])
  year = extract_year(fields["year"])
  month = month_for_entry(fields)
  venue = normalize_text(fields["journal"].to_s.empty? ? fields["booktitle"] : fields["journal"])
  slug = slugify(title)
  date = "#{year}-#{month}-01"
  filename = "#{date}-#{slug}.md"
  permalink = "/publication/#{slug}"
  excerpt = first_sentence("A publication by #{options[:author]} in #{venue}")

  content = <<~MD
    ---
    title: "#{title.gsub('"', '\"')}"
    collection: publications
    permalink: #{permalink}
    date: #{date}
    venue: "#{venue.gsub('"', '\"')}"
    excerpt: "#{excerpt.gsub('"', '\"')}"
    generated_by_bib_import: true
    ---

    #{publication_body(fields)}
  MD

  File.write(File.join(output_dir, filename), content)
  generated << filename
end

puts "Generated #{generated.length} publication files in #{output_dir}"
generated.sort.each { |name| puts name }
