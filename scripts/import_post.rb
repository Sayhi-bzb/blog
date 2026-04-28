#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "fileutils"
require "optparse"
require "pathname"
require "time"
require "yaml"

VERSION = "1.0.0"
IMAGE_EXTENSIONS = %w[.apng .avif .gif .jpeg .jpg .png .svg .webp].freeze

Options = Struct.new(:source, :build, :dry_run, :force, keyword_init: true)
PostData = Struct.new(:metadata, :content, :title, :date, :slug, :lang, :translation_key, keyword_init: true)
Validation = Struct.new(:errors, :warnings, keyword_init: true)
ImportState = Struct.new(:post_path, :post_existed, :previous_post_content, :copied_files, keyword_init: true)

def parse_options(argv)
  options = Options.new(build: true, dry_run: false, force: false)

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: ruby scripts/import_post.rb SOURCE.md [options]"
    opts.separator ""
    opts.separator "Import an Obsidian-style Markdown file into _posts and build the Jekyll site."
    opts.separator ""
    opts.separator "Options:"

    opts.on("--no-build", "Import the post without running bundle exec jekyll build.") do
      options.build = false
    end

    opts.on("--dry-run", "Print the planned output path without writing files or building.") do
      options.dry_run = true
    end

    opts.on("--force", "Overwrite an existing _posts file.") do
      options.force = true
    end

    opts.on("--version", "Print version and exit.") do
      puts VERSION
      exit 0
    end

    opts.on("-h", "--help", "Print this help message.") do
      puts opts
      exit 0
    end
  end

  parser.parse!(argv)
  options.source = argv.shift

  abort_with(parser.to_s) unless options.source
  abort_with("Unexpected arguments: #{argv.join(" ")}") unless argv.empty?

  options
rescue OptionParser::ParseError => e
  abort_with(e.message)
end

def abort_with(message)
  warn message
  exit 1
end

def abort_with_errors(errors)
  warn "Import failed validation:"
  errors.each { |error| warn "- #{error}" }
  exit 1
end

def split_front_matter(text)
  return [{}, text] unless text.start_with?("---\n")

  parts = text.split(/^---\s*$/, 3)
  return [{}, text] unless parts.length == 3 && parts[0].strip.empty?

  metadata = YAML.safe_load(parts[1], permitted_classes: [Date, Time], aliases: false) || {}
  [metadata, parts[2].sub(/\A\r?\n/, "")]
rescue Psych::SyntaxError => e
  abort_with("Invalid YAML front matter: #{e.message}")
end

def first_h1(content)
  match = content.match(/^#\s+(.+?)\s*$/)
  match && match[1].strip
end

def remove_matching_first_h1(content, title)
  lines = content.lines
  index = lines.index { |line| line.match?(/^#\s+#{Regexp.escape(title)}\s*$/) }
  return content unless index

  lines.delete_at(index)
  lines.join.sub(/\A\r?\n/, "")
end

def normalize_title(metadata, content, source)
  value = metadata["title"] || metadata[:title] || first_h1(content) || File.basename(source, ".md")
  value.to_s.strip
end

def normalize_date(metadata)
  value = metadata["date"] || metadata[:date]
  time =
    case value
    when Time then value
    when DateTime then value.to_time
    when Date then Time.local(value.year, value.month, value.day)
    when String then Time.parse(value)
    else Time.now
    end

  time.strftime("%Y-%m-%d %H:%M:%S %z")
rescue ArgumentError
  abort_with("Invalid date in front matter: #{value.inspect}")
end

def date_prefix(date_string)
  Time.parse(date_string).strftime("%Y-%m-%d")
end

def slugify(value, fallback)
  slug = value.to_s.downcase
              .gsub(/['"]/, "")
              .gsub(/[^a-z0-9]+/, "-")
              .gsub(/\A-+|-+\z/, "")
  return slug unless slug.empty?

  fallback_slug = File.basename(fallback, ".md").downcase
                       .gsub(/['"]/, "")
                       .gsub(/[^a-z0-9]+/, "-")
                       .gsub(/\A-+|-+\z/, "")
  fallback_slug.empty? ? "post" : fallback_slug
end

def normalize_slug(metadata, title, source)
  value = metadata["slug"] || metadata[:slug]
  slugify(value && !value.to_s.strip.empty? ? value : title, source)
end

def normalize_lang(metadata)
  value = metadata["lang"] || metadata[:lang] || "en"
  lang = value.to_s.strip

  return "zh-CN" if lang.downcase.start_with?("zh")
  return "en" if lang.downcase.start_with?("en")

  lang
end

def normalize_translation_key(metadata, slug)
  value = metadata["translation_key"] || metadata[:translation_key]
  key = value && value.to_s.strip
  key.nil? || key.empty? ? slug : slugify(key, slug)
end

def post_data(source)
  text = File.read(source, encoding: "UTF-8")
  abort_with("Source is not valid UTF-8: #{source}") unless text.valid_encoding?

  metadata, content = split_front_matter(text)
  title = normalize_title(metadata, content, source)
  content = remove_matching_first_h1(content, title)
  date = normalize_date(metadata)
  slug = normalize_slug(metadata, title, source)
  lang = normalize_lang(metadata)
  translation_key = normalize_translation_key(metadata, slug)

  PostData.new(metadata: metadata, content: content, title: title, date: date, slug: slug, lang: lang, translation_key: translation_key)
end

def image_path?(path)
  IMAGE_EXTENSIONS.include?(File.extname(path).downcase)
end

def external_path?(path)
  path.match?(%r{\A[a-z][a-z0-9+.-]*://}i) || path.start_with?("/", "#", "mailto:")
end

def find_attachment(path, source_dir)
  candidate = Pathname.new(path)
  return candidate if candidate.absolute? && candidate.file?

  direct = source_dir.join(path).cleanpath
  return direct if direct.file?

  matches = source_dir.find.select { |item| item.file? && item.basename.to_s == File.basename(path) }
  matches.first
end

def scan_outside_fences(content)
  in_fence = false

  content.lines.each do |line|
    if line.match?(/^\s*(```|~~~)/)
      in_fence = !in_fence
      next
    end

    yield line unless in_fence
  end
end

def validate_content(content, source_dir)
  validation = Validation.new(errors: [], warnings: [])

  scan_outside_fences(content) do |line|
    line.scan(/!\[\[([^\]\|]+)(?:\|[^\]]+)?\]\]/) do |match|
      path = match.first.strip
      if image_path?(path)
        validation.errors << "Image not found: #{path}" unless find_attachment(path, source_dir)&.file?
      else
        validation.warnings << "Unsupported Obsidian embed left unchanged: ![[#{path}]]"
      end
    end

    line.scan(/!\[([^\]]*)\]\(([^)]+)\)/) do |_alt, raw_path|
      path = raw_path.strip
      next if external_path?(path) || !image_path?(path)

      validation.errors << "Image not found: #{path}" unless find_attachment(path, source_dir)&.file?
    end

    line.scan(/(?<!!)\[\[([^\]\|]+)\|([^\]]+)\]\]|(?<!!)\[\[([^\]]+)\]\]/) do |note, alias_text, plain_note|
      label = alias_text || plain_note || note
      validation.warnings << "Obsidian internal link will become plain text: #{label.strip}"
    end
  end

  validation.errors.uniq!
  validation.warnings.uniq!
  validation
end

def validate_import(data, source, output_path, force)
  validation = validate_content(data.content, Pathname.new(source).dirname)

  validation.errors << "Title is empty." if data.title.empty?
  validation.errors << "Slug is empty." if data.slug.empty?
  validation.errors << "Slug is not safe for filenames: #{data.slug}" unless data.slug.match?(/\A[a-z0-9][a-z0-9-]*\z/)
  validation.errors << "Unsupported lang: #{data.lang}. Use en or zh-CN." unless %w[en zh-CN].include?(data.lang)
  validation.errors << "Translation key is empty." if data.translation_key.empty?
  validation.errors << "Post already exists: #{output_path}. Use --force to overwrite." if output_path.exist? && !force

  validation
end

def print_warnings(warnings)
  warnings.each { |warning| warn "Warning: #{warning}" }
end

def unique_destination(directory, basename)
  stem = File.basename(basename, ".*").gsub(/[^A-Za-z0-9._-]+/, "-").gsub(/\A-+|-+\z/, "")
  stem = "image" if stem.empty?
  ext = File.extname(basename).downcase
  destination = directory.join("#{stem}#{ext}")
  index = 2

  while destination.exist?
    destination = directory.join("#{stem}-#{index}#{ext}")
    index += 1
  end

  destination
end

def copy_image(path, source_dir, image_dir, image_url_base, dry_run, state)
  source = find_attachment(path, source_dir)
  unless source&.file?
    return path
  end

  destination = unique_destination(image_dir, source.basename.to_s)
  unless dry_run
    FileUtils.mkdir_p(image_dir)
    FileUtils.cp(source, destination)
    state.copied_files << destination
  end
  "#{image_url_base}/#{destination.basename}"
end

def rewrite_markdown_segment(segment, source_dir, image_dir, image_url_base, dry_run, state)
  rewritten = segment.gsub(/!\[\[([^\]\|]+)(?:\|[^\]]+)?\]\]/) do
    path = Regexp.last_match(1).strip
    next Regexp.last_match(0) unless image_path?(path)

    destination = copy_image(path, source_dir, image_dir, image_url_base, dry_run, state)
    "![#{File.basename(path, ".*")}](#{destination})"
  end

  rewritten.gsub!(/!\[([^\]]*)\]\(([^)]+)\)/) do
    alt = Regexp.last_match(1)
    path = Regexp.last_match(2).strip
    next Regexp.last_match(0) if external_path?(path) || !image_path?(path)

    destination = copy_image(path, source_dir, image_dir, image_url_base, dry_run, state)
    "![#{alt}](#{destination})"
  end

  rewritten.gsub(/(?<!!)\[\[([^\]\|]+)\|([^\]]+)\]\]|(?<!!)\[\[([^\]]+)\]\]/) do
    label = Regexp.last_match(2) || Regexp.last_match(3)
    label.strip
  end
end

def rewrite_outside_fences(content)
  in_fence = false

  content.lines.map do |line|
    if line.match?(/^\s*(```|~~~)/)
      in_fence = !in_fence
      line
    elsif in_fence
      line
    else
      yield line
    end
  end.join
end

def rewrite_content(content, source, slug, dry_run, state)
  source_dir = Pathname.new(source).dirname
  image_dir = Pathname.new("assets/images/posts/#{slug}")
  image_url_base = "/assets/images/posts/#{slug}"

  rewrite_outside_fences(content) do |segment|
    rewrite_markdown_segment(segment, source_dir, image_dir, image_url_base, dry_run, state)
  end
end

def jekyll_front_matter(data)
  output = {
    "title" => data.title,
    "date" => data.date,
    "lang" => data.lang
  }

  %w[slug tags katex].each do |key|
    value = data.metadata[key] || data.metadata[key.to_sym]
    output[key] = value unless value.nil? || value == ""
  end

  output["slug"] ||= data.slug
  output["translation_key"] = data.translation_key
  output.to_yaml.sub(/\A---\n/, "---\n")
end

def write_post(data, output_path, body, dry_run, state)
  final_content = "#{jekyll_front_matter(data)}---\n\n#{body.strip}\n"

  if dry_run
    puts "Would write #{output_path}"
    return
  end

  state.post_path = output_path
  state.post_existed = output_path.exist?
  state.previous_post_content = state.post_existed ? File.read(output_path, encoding: "UTF-8") : nil
  FileUtils.mkdir_p(output_path.dirname)
  File.write(output_path, final_content, encoding: "UTF-8")
  puts "Wrote #{output_path}"
end

def build_site
  puts "Running bundle exec jekyll build..."
  success = system("bundle", "exec", "jekyll", "build")
  abort_with("Jekyll build failed.") unless success
end

def rollback_import(state)
  warn "Rolling back imported files..."

  state.copied_files.reverse_each do |path|
    FileUtils.rm_f(path.to_s)
    parent = path.dirname
    FileUtils.rmdir(parent.to_s) if parent.exist? && parent.children.empty?
  end

  return unless state.post_path

  if state.post_existed
    File.write(state.post_path, state.previous_post_content, encoding: "UTF-8")
  else
    FileUtils.rm_f(state.post_path.to_s)
  end
end

options = parse_options(ARGV)
source = Pathname.new(options.source)
abort_with("Source file not found: #{source}") unless source.file?
abort_with("Source must be a Markdown file: #{source}") unless source.extname.downcase == ".md"

data = post_data(source)
post_directory = data.lang == "zh-CN" ? Pathname.new("_posts/zh") : Pathname.new("_posts/en")
output_path = post_directory.join("#{date_prefix(data.date)}-#{data.slug}.md")
validation = validate_import(data, source, output_path, options.force)

abort_with_errors(validation.errors) unless validation.errors.empty?
print_warnings(validation.warnings)

state = ImportState.new(copied_files: [])
body = rewrite_content(data.content, source, data.slug, options.dry_run, state)

begin
  write_post(data, output_path, body, options.dry_run, state)
  build_site if options.build && !options.dry_run
rescue SystemExit
  rollback_import(state) unless options.dry_run
  raise
rescue StandardError => e
  rollback_import(state) unless options.dry_run
  abort_with("#{e.class}: #{e.message}")
end
