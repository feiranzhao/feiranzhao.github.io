#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "optparse"
require "set"
require "uri"

options = {
  orcid: ENV.fetch("ORCID_ID", "0000-0003-3142-2903"),
  cv_path: "_data/cv.yml",
  write: false
}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby scripts/sync_publications.rb [--write] [--orcid ORCID_ID]"
  opts.on("--write", "Append missing ORCID works to _data/cv.yml") { options[:write] = true }
  opts.on("--orcid ORCID_ID", "ORCID iD to query") { |value| options[:orcid] = value }
  opts.on("--cv PATH", "Path to cv.yml") { |value| options[:cv_path] = value }
end.parse!

def fetch_json(url)
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"
  request["User-Agent"] = "feiranzhao.github.io publication sync"
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
    http.request(request)
  end
  raise "GET #{url} failed with #{response.code}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def normalize_title(title)
  title.to_s.downcase.gsub(/[^a-z0-9]+/, " ").strip
end

def value_at(hash, *path)
  path.reduce(hash) { |memo, key| memo.is_a?(Hash) ? memo[key] : nil }
end

def external_ids(work)
  Array(value_at(work, "external-ids", "external-id"))
end

def external_id(work, type)
  external_ids(work).find { |item| item["external-id-type"].to_s.downcase == type }&.dig("external-id-value")
end

def publication_url(work)
  if (doi = external_id(work, "doi"))
    "https://doi.org/#{doi}"
  elsif (arxiv = external_id(work, "arxiv"))
    "https://arxiv.org/abs/#{arxiv}"
  else
    value_at(work, "url", "value")
  end
end

def publication_category(type)
  case type
  when "journal-article"
    "journal"
  when "conference-paper", "conference-abstract", "conference-poster"
    "conference"
  else
    "preprints"
  end
end

def yaml_quote(value)
  value.to_s.gsub("\\", "\\\\\\").gsub('"', '\"')
end

def publication_block(item)
  lines = []
  lines << %(    - year: "#{yaml_quote(item[:year])}")
  lines << %(      title: "#{yaml_quote(item[:title])}")
  lines << %(      url: "#{yaml_quote(item[:url])}") if item[:url] && !item[:url].empty?
  lines << %(      authors: "#{yaml_quote(item[:authors])}")
  lines << %(      venue: "#{yaml_quote(item[:venue])}")
  lines.join("\n") + "\n"
end

def existing_titles(cv_text)
  in_publications = false
  titles = Set.new
  cv_text.each_line do |line|
    in_publications = true if line.match?(/^publications:\s*$/)
    next unless in_publications

    match = line.match(/^\s+title:\s+"?(.*?)"?\s*$/)
    titles << normalize_title(match[1]) if match
  end
  titles
end

def insert_blocks(cv_text, additions)
  result = cv_text.dup
  %w[preprints journal conference].each do |category|
    blocks = additions.fetch(category, [])
    next if blocks.empty?

    section = /^  #{Regexp.escape(category)}:\s*$/
    lines = result.lines
    index = lines.find_index { |line| line.match?(section) }
    raise "Could not find publications.#{category} in _data/cv.yml" unless index

    insertion = blocks.map { |item| publication_block(item) }.join
    lines.insert(index + 1, insertion)
    result = lines.join
  end
  result
end

works_url = "https://pub.orcid.org/v3.0/#{options[:orcid]}/works"
works = fetch_json(works_url)
cv_text = File.read(options[:cv_path], encoding: "UTF-8")
known_titles = existing_titles(cv_text)

additions = Hash.new { |hash, key| hash[key] = [] }

Array(works["group"]).each do |group|
  summary = Array(group["work-summary"]).first
  next unless summary

  put_code = summary["put-code"]
  detail = fetch_json("https://pub.orcid.org/v3.0/#{options[:orcid]}/work/#{put_code}")
  title = value_at(detail, "title", "title", "value")
  next if title.nil? || title.strip.empty?
  next if known_titles.include?(normalize_title(title))

  contributors = Array(value_at(detail, "contributors", "contributor"))
  authors = contributors.map { |item| value_at(item, "credit-name", "value") }.compact
  year = value_at(detail, "publication-date", "year", "value") || "forthcoming"
  venue = value_at(detail, "journal-title", "value")
  venue = "Preprint" if venue.nil? || venue.empty?

  item = {
    year: year,
    title: title,
    url: publication_url(detail),
    authors: authors.empty? ? "Feiran Zhao" : authors.join(", "),
    venue: venue
  }
  additions[publication_category(detail["type"])] << item
end

total = additions.values.sum(&:length)
if total.zero?
  puts "No new ORCID works found for #{options[:orcid]}."
  exit 0
end

additions.each do |category, items|
  items.sort_by! { |item| item[:year].to_s }.reverse!
  puts "#{category}:"
  items.each { |item| puts "  - #{item[:year]}: #{item[:title]}" }
end

if options[:write]
  File.write(options[:cv_path], insert_blocks(cv_text, additions), mode: "w", encoding: "UTF-8")
  puts "Updated #{options[:cv_path]} with #{total} new publication(s)."
else
  puts "Dry run only. Re-run with --write to update #{options[:cv_path]}."
end
