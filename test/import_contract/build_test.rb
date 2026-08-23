# frozen_string_literal: true

require_relative "test_helper"

# The build itself, and the pages it is supposed to have produced. These run
# once rather than per page: a build that warned, or a recipe that produced no
# page at all, is one fact about the whole run.
class BuildTest < Minitest::Test
  def test_the_build_succeeds
    assert BuiltSite.build_succeeded?,
           "`jekyll build` failed:\n\n#{BuiltSite.build_log}"
  end

  def test_the_build_prints_no_liquid_warnings
    warnings = BuiltSite.build_log.lines.grep(/liquid (warning|syntax error)/i)

    assert_empty warnings.map(&:strip),
                 "Liquid warnings do not fail a build — they render nothing where output " \
                 "was expected, which is how a mistyped front-matter key costs a page a " \
                 "whole section in silence"
  end

  def test_the_build_prints_no_errors
    errors = BuiltSite.build_log.lines.grep(/^\s*(Error|Warning):/i)

    assert_empty errors.map(&:strip), "the build log should be clean"
  end

  def test_every_recipe_produced_a_page
    assert_empty BuiltSite.unbuilt_recipes.map(&:name),
                 "these recipes built no page, so every other rule here would have " \
                 "silently skipped them"
  end

  def test_the_index_links_to_every_recipe
    linked = BuiltSite.index_doc.css("a[href]").map { |a| a["href"] }
    missing = BuiltSite.pages.reject do |page|
      linked.any? { |href| href.chomp("/").end_with?("/recipes/#{page.slug}") }
    end

    assert_empty missing.map(&:slug),
                 "the index is the only path to a recipe from the site root; a recipe " \
                 "missing from it is reachable only by someone who already has the URL"
  end

  def test_the_sitemap_lists_every_recipe
    refute_nil BuiltSite.sitemap, "sitemap.xml is missing from the build"
    missing = BuiltSite.pages.reject { |page| BuiltSite.sitemap.include?(page.url) }

    assert_empty missing.map(&:slug),
                 "a recipe absent from sitemap.xml is a recipe a search engine has no " \
                 "reason to fetch"
  end
end
