# frozen_string_literal: true

require "json"
require "uri"
require "open3"
require "nokogiri"

require_relative "site"

# The site as Jekyll actually renders it.
#
# `jekyll build`, never `jekyll serve`: serve rewrites `site.url` to localhost,
# so a wrongly-absolute URL resolves anyway and the bug hides. That is the most
# misleading failure mode in this repository, and it is a one-word difference.
#
# The build runs once per process, the first time anything asks for a page.
module BuiltSite
  DESTINATION = File.join(Site::ROOT, "_site")

  # A rendered recipe page, paired with the source file it came from so a
  # failure can name the file a contributor has to edit.
  Page = Struct.new(:slug, :path, :recipe) do
    def name
      File.join("_site", "recipes", slug, "index.html")
    end

    def html
      @html ||= File.read(path, encoding: Site::ENCODING)
    end

    def doc
      @doc ||= Nokogiri::HTML5(html)
    end

    def url
      File.join(Site.config["url"].to_s, "/recipes/#{slug}/")
    end

    # Every JSON-LD block on the page, parsed. jekyll-seo-tag emits its own
    # BlogPosting block, so there is always more than one.
    def json_ld_blocks
      @json_ld_blocks ||= doc.css('script[type="application/ld+json"]').map do |script|
        JSON.parse(script.text)
      rescue JSON::ParserError => e
        { "@type" => "__unparseable__", "error" => e.message }
      end
    end

    def unparseable_blocks
      json_ld_blocks.select { |block| block["@type"] == "__unparseable__" }
    end

    # Selected by @type, never by index. The Recipe block is the second one
    # today, and that is an implementation detail of another plugin.
    def recipe_blocks
      json_ld_blocks.select { |block| Array(block["@type"]).include?("Recipe") }
    end

    def recipe_json
      recipe_blocks.first || {}
    end
  end

  class << self
    def build_log
      build!
      @build_log
    end

    def pages
      build!
      @pages ||= Site.recipes.filter_map do |recipe|
        path = File.join(DESTINATION, "recipes", recipe.slug, "index.html")
        Page.new(recipe.slug, path, recipe) if File.file?(path)
      end
    end

    # Every recipe that has no built page at all. Kept separate from `pages`
    # so a missing page is one loud failure rather than a silently shorter run.
    def unbuilt_recipes
      build!
      Site.recipes.reject { |recipe| File.file?(File.join(DESTINATION, "recipes", recipe.slug, "index.html")) }
    end

    def index_doc
      build!
      @index_doc ||= Nokogiri::HTML5(File.read(File.join(DESTINATION, "index.html"), encoding: Site::ENCODING))
    end

    def sitemap
      build!
      @sitemap ||= begin
        path = File.join(DESTINATION, "sitemap.xml")
        File.file?(path) ? File.read(path, encoding: Site::ENCODING) : nil
      end
    end

    def build_succeeded?
      build!
      @build_status.success?
    end

    private

    # Shelled out rather than driven through the Jekyll API, because one of the
    # assertions is about what the build prints. A warning Liquid raises does
    # not fail the build and does not raise — it goes to the log, and whatever
    # was meant to render there renders as nothing.
    def build!
      return if defined?(@build_log)

      Bundler.with_unbundled_env do
        @build_log, @build_status = Open3.capture2e(
          "bundle", "exec", "jekyll", "build", "--destination", DESTINATION,
          chdir: Site::ROOT
        )
      end
    end
  end
end
