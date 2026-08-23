# frozen_string_literal: true

require_relative "test_helper"

# Fields the layout derives from other fields. Each pair is emitted twice by
# construction, so the only way they can disagree is a layout change — and a
# consumer reading the wrong half of a disagreeing pair has no way to tell.
class EqualitiesTest < BuiltPageTest
  rule "supply_matches_the_ingredient_list_exactly" do |page|
    supply = Array(page.recipe_json["supply"]).map { |item| item.is_a?(Hash) ? item["name"] : item }

    assert_equal Array(page.recipe_json["recipeIngredient"]), supply,
                 "#{page.name}: `supply` and `recipeIngredient` are the same list in the " \
                 "same order. They are emitted twice on purpose, and a consumer that reads " \
                 "both must not find two different shopping lists"
  end

  rule "the_ingredient_list_is_the_one_the_recipe_wrote" do |page|
    assert_equal source_ingredients(page), Array(page.recipe_json["recipeIngredient"]),
                 "#{page.name}: the flattened ingredient groups and the emitted " \
                 "recipeIngredient differ"
  end

  rule "yield_is_emitted_under_both_names" do |page|
    assert_equal page.recipe_json["recipeYield"], page.recipe_json["yield"],
                 "#{page.name}: `yield` comes from HowTo and `recipeYield` from Recipe. Both " \
                 "are emitted, and they have to say the same thing"
  end

  rule "time_required_matches_total_time" do |page|
    assert_equal page.recipe_json["totalTime"], page.recipe_json["timeRequired"],
                 "#{page.name}: `timeRequired` is CreativeWork's spelling of `totalTime`"
  end

  rule "perform_time_is_present" do |page|
    refute_nil page.recipe_json["performTime"],
               "#{page.name}: `performTime` is what an app counts down while the pot is " \
               "actually cooking, as distinct from the prep before it"
  end

  rule "the_emitted_durations_add_up" do |page|
    prep, cook, total = %w[prepTime cookTime totalTime].map do |key|
      Vocabulary.duration_seconds(page.recipe_json[key])
    end

    refute_nil total, "#{page.name}: totalTime is not a duration a consumer can parse"
    assert_equal total, prep.to_i + cook.to_i,
                 "#{page.name}: prepTime + cookTime must equal totalTime in the built output, " \
                 "not only in the front matter"
  end

  rule "copyright_year_is_a_number" do |page|
    year = page.recipe_json["copyrightYear"]

    assert_kind_of Integer, year,
                   "#{page.name}: copyrightYear is #{year.inspect}. schema.org's range is " \
                   "Number, so it is emitted unquoted; a string is a type error a lenient " \
                   "consumer keeps and a strict one drops"
    assert_equal page.recipe["date"].year, year,
                 "#{page.name}: copyrightYear is not the year the recipe was published"
  end

  rule "keywords_are_one_string" do |page|
    keywords = page.recipe_json["keywords"]

    assert_kind_of String, keywords,
                   "#{page.name}: `keywords` is Text on schema.org — the list in front matter " \
                   "is joined with ', ' on the way out. An array is a type error"
  end

  rule "the_recipe_url_is_the_page_it_is_on" do |page|
    assert_equal page.url, page.recipe_json["url"],
                 "#{page.name}: the Recipe's url is the page a reader would paste into an app"
  end
end
