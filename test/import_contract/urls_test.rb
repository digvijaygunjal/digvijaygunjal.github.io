# frozen_string_literal: true

require_relative "test_helper"

# Rule 1 of the import contract: images are absolute in the JSON-LD and
# relative in the markup. An importer fetches the structured data away from the
# page, so a relative path there resolves against nothing.
class UrlsTest < BuiltPageTest
  ABSOLUTE = %r{\Ahttps?://}

  rule "json_ld_image_urls_are_absolute" do |page|
    urls = [page.recipe_json["image"], page.recipe_json["thumbnailUrl"]].flatten.compact
    urls += Array(page.recipe_json["recipeInstructions"]).filter_map { |step| step["image"] if step.is_a?(Hash) }
    relative = urls.reject { |url| url.to_s.match?(ABSOLUTE) }

    refute_empty urls, "#{page.name}: the JSON-LD carries no image at all"
    assert_empty relative,
                 "#{page.name}: #{relative.inspect} is relative. An importer reads the " \
                 "JSON-LD away from the page, so it has no base to resolve against"
  end

  rule "json_ld_urls_point_at_the_published_site" do |page|
    site_url = Site.config["url"].to_s
    urls = [page.recipe_json["url"], page.recipe_json["@id"], page.recipe_json["image"]].flatten.compact
    foreign = urls.reject { |url| url.to_s.start_with?(site_url) }

    assert_empty foreign,
                 "#{page.name}: #{foreign.inspect} does not start with #{site_url}. This is " \
                 "what a build made with `jekyll serve` looks like — serve rewrites site.url " \
                 "to localhost, and every wrongly-absolute URL then resolves anyway"
  end

  rule "page_image_tags_stay_relative" do |page|
    absolute = page.doc.css("img[src]").map { |img| img["src"] }.select { |src| src.match?(ABSOLUTE) }

    assert_empty absolute,
                 "#{page.name}: #{absolute.inspect} is absolute in the markup. Relative " \
                 "keeps the page working on a preview build and off the published domain"
  end

  rule "every_image_tag_is_described" do |page|
    undescribed = page.doc.css("img").reject { |img| img["alt"] }.map { |img| img["src"] }

    assert_empty undescribed,
                 "#{page.name}: #{undescribed.inspect} has no alt attribute, so a screen " \
                 "reader announces the filename or nothing"
  end
end
