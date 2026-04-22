# Personal Academic Homepage

This repository contains a personal academic website scaffold inspired by
[`academicpages`](https://github.com/academicpages/academicpages.github.io),
but simplified so it is easier to customize and maintain.

## Included pages

- Home / About
- Publications
- Talks
- Teaching
- CV

## Main files to edit

- `_config.yml`: your name, institution, links, email, site URL
- `_data/navigation.yml`: top navigation bar
- `_pages/about.md`: homepage content
- `_pages/cv.md`: CV page
- `_publications/`: one Markdown file per paper
- `_talks/`: one Markdown file per talk
- `_teaching/`: one Markdown file per course or activity

## GitHub Pages setup

1. Rename the repo to `yourusername.github.io` if you want to host at the root domain.
2. Update `url` and `repository` in `_config.yml`.
3. Push to GitHub.
4. In GitHub repo settings, enable GitHub Pages.

## Local preview

After installing Ruby and Bundler:

```bash
bundle install
bundle exec jekyll serve
```

