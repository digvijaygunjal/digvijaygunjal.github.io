# frozen_string_literal: true

require_relative "test_helper"

# The block the whole site exists to emit. Everything here fails silently in
# production: a page with broken structured data looks exactly like a page with
# working structured data until someone tries to import it.
class StructuredDataTest < BuiltPageTest
  rule "every_json_ld_block_parses" do |page|
    broken = page.unparseable_blocks.map { |block| block["error"] }

    assert_empty broken,
                 "#{page.name}: a JSON-LD block does not parse, so a consumer discards it " \
                 "whole. A Liquid slip that leaves a trailing comma does exactly this and " \
                 "changes nothing visible on the page"
  end

  rule "emits_exactly_one_recipe_object" do |page|
    assert_equal 1, page.recipe_blocks.length,
                 "#{page.name} carries #{page.recipe_blocks.length} schema.org/Recipe " \
                 "objects. There must be one. Note jekyll-seo-tag emits its own BlogPosting " \
                 "block, so blocks are selected by @type and never by position"
  end

  rule "the_recipe_is_identified_by_a_fragment_of_its_page" do |page|
    assert_equal "#{page.url}#recipe", page.recipe_json["@id"],
                 "#{page.name}: the Recipe's @id is a fragment of the page URL, so it cannot " \
                 "collide with the WebPage @id in mainEntityOfPage — two nodes sharing one " \
                 "@id are one node to a consumer"
  end

  rule "the_recipe_id_does_not_collide_with_the_page_id" do |page|
    web_page = page.recipe_json["mainEntityOfPage"] || {}

    refute_equal page.recipe_json["@id"], web_page["@id"],
                 "#{page.name}: the Recipe and the WebPage carry the same @id"
  end

  rule "the_recipe_declares_the_schema_org_context" do |page|
    assert_equal "https://schema.org", page.recipe_json["@context"],
                 "#{page.name}: without @context the keys are not schema.org terms at all"
  end

  rule "carries_a_date_published" do |page|
    refute_nil page.recipe_json["datePublished"],
               "#{page.name} has no datePublished. This is the cheapest possible proof the " \
               "front matter was read at all: a recipe that has lost its closing `---` still " \
               "builds a page titled from its filename, with no dates, diets, allergens or " \
               "times in it, and nothing else catches that"
  end

  rule "date_published_is_the_date_the_recipe_states" do |page|
    assert_equal page.recipe["date"].to_s, page.recipe_json["datePublished"].to_s,
                 "#{page.name}: datePublished does not match the source `date`"
  end

  rule "carries_what_consumers_require" do |page|
    %w[name image description].each do |key|
      refute_empty Array(page.recipe_json[key]).reject { |v| v.to_s.strip.empty? },
                   "#{page.name}: `#{key}` is required by every consumer of a Recipe. " \
                   "Without it an importer has nothing to show for the recipe at all"
    end
  end

  rule "diets_are_emitted_as_schema_org_urls" do |page|
    values = Array(page.recipe_json["suitableForDiet"])
    invalid = values.reject do |value|
      value.to_s.start_with?("https://schema.org/") &&
        Vocabulary::RESTRICTED_DIETS.include?(value.to_s.delete_prefix("https://schema.org/"))
    end

    assert_empty invalid,
                 "#{page.name}: suitableForDiet takes full schema.org URLs of RestrictedDiet " \
                 "members; #{invalid.inspect} is neither"
  end

  rule "nutrition_is_emitted_in_full" do |page|
    nutrition = page.recipe_json["nutrition"] || {}
    missing = Vocabulary::NUTRITION_PROPERTIES.reject { |key| nutrition[key].to_s.strip != "" }

    assert_equal "NutritionInformation", nutrition["@type"],
                 "#{page.name}: nutrition must be typed, or its keys mean nothing"
    assert_empty missing,
                 "#{page.name}: nutrition is missing #{missing.join(", ")} in the built " \
                 "output, though the front matter may well carry it — that gap is a layout bug"
  end
end
