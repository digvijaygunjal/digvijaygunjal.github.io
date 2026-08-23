# frozen_string_literal: true

require "yaml"
require "date"
require "jekyll"

# Reads the sources the site is built from — `_recipes/`, `_data/` and
# `_config.yml` — without running Jekyll. The source checks assert against these;
# the import-contract checks assert against what Jekyll makes of them.
module Site
  ROOT = File.expand_path("../..", __dir__)

  RECIPES_DIR = File.join(ROOT, "_recipes")
  IMAGES_DIR  = File.join(ROOT, "assets", "images")
  DATA_DIR    = File.join(ROOT, "_data")
  CONFIG_FILE = File.join(ROOT, "_config.yml")

  # Jekyll's own front-matter regexp, used deliberately rather than splitting a
  # file on `---`. It requires the closing terminator, so a file that has lost
  # one is rejected here. A naive split still yields valid YAML from that same
  # broken file, which is why the bug this suite most needs to catch is the one
  # a hand-rolled parser walks straight past.
  FRONT_MATTER = Jekyll::Document::YAML_FRONT_MATTER_REGEXP

  # Files are read as UTF-8 explicitly. A Ruby process started without LANG set
  # — which is the normal state of affairs in CI — defaults to a US-ASCII
  # external encoding, and reading a recipe then raises before a single
  # assertion runs.
  ENCODING = "UTF-8"

  # One recipe source file, parsed but not interpreted.
  #
  # `front_matter` is nil, not empty, when the file does not match the
  # front-matter regexp at all; the two cases fail differently and a reader of
  # the failure needs to be able to tell them apart.
  Recipe = Struct.new(:path, :source, :front_matter, :body) do
    # What a failure message calls this recipe: the path a contributor can open.
    def name
      File.join("_recipes", File.basename(path))
    end

    # What a generated test method is named after.
    def slug
      File.basename(path, ".md")
    end

    def front_matter?
      !front_matter.nil?
    end

    # Front matter with the terminator missing still leaves a Hash-shaped
    # nothing behind; `fetch` on it would raise rather than assert.
    def [](key)
      (front_matter || {})[key]
    end
  end

  class << self
    def recipe_paths
      Dir[File.join(RECIPES_DIR, "*.md")].sort
    end

    def recipes
      @recipes ||= recipe_paths.map { |path| read_recipe(path) }
    end

    # Every committed image, whatever it is for. Git keeps each version of a
    # binary forever, so these are checked before they land rather than after.
    def image_files
      Dir[File.join(IMAGES_DIR, "**", "*")].select { |path| File.file?(path) }.sort
    end

    # Every image path the recipes point at, hero and per-step, as written.
    def referenced_images
      recipes.flat_map do |recipe|
        Array(recipe["image"]) + Array(recipe["steps"]).grep(Hash).filter_map { |step| step["image"] }
      end.uniq
    end

    def allergens
      @allergens ||= YAML.safe_load_file(File.join(DATA_DIR, "allergens.yml"))
    end

    def allergen_ids
      allergens.map { |entry| entry["id"] }
    end

    def config
      @config ||= YAML.safe_load_file(CONFIG_FILE, permitted_classes: [Date], aliases: true)
    end

    # True when the path a recipe writes — always site-absolute, always
    # `/assets/...` — points at a file that is actually committed.
    def asset?(path)
      return false unless path.is_a?(String) && path.start_with?("/")

      File.file?(File.join(ROOT, path.delete_prefix("/")))
    end

    # Every string anywhere in a nested structure, so a rule about prose can be
    # applied to front matter without knowing its shape.
    def strings_in(value, &block)
      case value
      when String then block.call(value)
      when Array  then value.each { |item| strings_in(item, &block) }
      when Hash   then value.each_value { |item| strings_in(item, &block) }
      end
    end

    private

    def read_recipe(path)
      source = File.read(path, encoding: ENCODING)
      match = source.match(FRONT_MATTER)

      return Recipe.new(path, source, nil, source) if match.nil?

      front = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true)
      Recipe.new(path, source, front.is_a?(Hash) ? front : nil, match.post_match)
    end
  end
end
