# frozen_string_literal: true

require_relative "../test_helper"

# The files every other rule here is derived from. These run once, not once per
# recipe: they are about the collection and the data behind it.
class SourcesTest < Minitest::Test
  def test_there_is_at_least_one_recipe_to_check
    refute_empty Site.recipes,
                 "No recipe files in _recipes/. Every other test in this suite " \
                 "is generated from that directory, so an empty one makes the " \
                 "whole suite pass without asserting anything"
  end

  def test_the_allergen_list_is_the_full_fourteen
    assert_equal Vocabulary::EU_ALLERGEN_COUNT, Site.allergens.length,
                 "_data/allergens.yml must hold the fourteen substances of Annex II " \
                 "to Regulation (EU) No 1169/2011. The layout derives each recipe's " \
                 "'free from' list by subtracting what it declares from this file, so " \
                 "an extra entry silently makes every recipe claim something new"
  end

  def test_allergen_ids_are_unique
    duplicates = Site.allergen_ids.tally.select { |_, count| count > 1 }.keys

    assert_empty duplicates,
                 "Duplicate allergen ids in _data/allergens.yml: #{duplicates.join(", ")}. " \
                 "A recipe referencing one of these would resolve to whichever came first"
  end

  def test_every_allergen_has_an_id_and_a_label
    incomplete = Site.allergens.reject do |entry|
      entry["id"].is_a?(String) && !entry["id"].empty? &&
        entry["label"].is_a?(String) && !entry["label"].empty?
    end

    assert_empty incomplete,
                 "Every entry in _data/allergens.yml needs an `id` for recipes to " \
                 "reference and a `label` for the page to print: #{incomplete.inspect}"
  end

  def test_allergen_ids_are_lowercase_slugs
    odd = Site.allergen_ids.reject { |id| id.match?(/\A[a-z][a-z0-9-]*\z/) }

    assert_empty odd,
                 "Allergen ids are referenced by recipes and read by people: " \
                 "keep them lowercase and hyphenated. Offending: #{odd.join(", ")}"
  end

  def test_the_restricted_diet_list_is_exactly_eleven
    assert_equal 11, Vocabulary::RESTRICTED_DIETS.length,
                 "schema.org's RestrictedDiet enumeration has eleven members. A twelfth " \
                 "added to this constant would let a recipe claim a diet that means " \
                 "nothing to a consumer, which is the failure this list exists to prevent"
  end

  def test_the_site_url_is_absolute
    url = Site.config["url"]

    assert_match %r{\Ahttps?://}, url.to_s,
                 "_config.yml `url` is what turns a recipe's relative image path into " \
                 "the absolute URL the JSON-LD has to carry. Without it every image in " \
                 "the structured data is unresolvable to an importer"
  end
end
