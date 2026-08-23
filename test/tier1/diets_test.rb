# frozen_string_literal: true

require_relative "../test_helper"

# A diet claim is emitted as `suitableForDiet`. A value outside schema.org's
# RestrictedDiet enumeration is not rejected by anything downstream — it is
# ignored, so the page makes a promise the structured data never carries.
class DietsTest < RecipeTest
  rule "diets_carry_a_label_and_a_schema_value" do |recipe|
    skip_without(recipe, "diets")

    diets = recipe["diets"]

    assert_kind_of Array, diets, "#{recipe.name}: `diets` is a list"
    incomplete = diets.reject do |diet|
      diet.is_a?(Hash) && diet["label"].to_s.strip != "" && diet["schema"].to_s.strip != ""
    end

    assert_empty incomplete,
                 "#{recipe.name}: every diet needs the `label` the page prints and the " \
                 "`schema` value emitted as suitableForDiet, so the two cannot disagree: " \
                 "#{incomplete.inspect}"
  end

  rule "diets_are_restricted_diet_members" do |recipe|
    skip_without(recipe, "diets")

    invalid = Array(recipe["diets"]).filter_map { |diet| diet["schema"] if diet.is_a?(Hash) }
                                    .reject { |value| Vocabulary::RESTRICTED_DIETS.include?(value) }

    assert_empty invalid,
                 "#{recipe.name}: #{invalid.join(", ")} is not a member of schema.org's " \
                 "RestrictedDiet. Valid values are #{Vocabulary::RESTRICTED_DIETS.join(", ")}"
  end

  rule "no_diet_is_claimed_twice" do |recipe|
    skip_without(recipe, "diets")

    values = Array(recipe["diets"]).filter_map { |diet| diet["schema"] if diet.is_a?(Hash) }
    duplicates = values.tally.select { |_, count| count > 1 }.keys

    assert_empty duplicates,
                 "#{recipe.name}: #{duplicates.join(", ")} is claimed twice, which emits a " \
                 "repeated value in suitableForDiet"
  end
end
