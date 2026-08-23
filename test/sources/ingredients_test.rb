# frozen_string_literal: true

require_relative "../test_helper"

# Ingredients are flat strings by the time they reach `recipeIngredient` and
# `supply` — quantity, unit and item on one line. The groups exist for the
# page's benefit and are flattened on the way into the JSON-LD.
class IngredientsTest < RecipeTest
  rule "ingredients_are_named_groups_of_items" do |recipe|
    skip_without(recipe, "ingredients")

    groups = recipe["ingredients"]

    assert_kind_of Array, groups, "#{recipe.name}: `ingredients` is a list of groups"
    malformed = groups.reject do |group|
      group.is_a?(Hash) && group["name"].to_s.strip != "" &&
        group["items"].is_a?(Array) && !group["items"].empty?
    end

    assert_empty malformed,
                 "#{recipe.name}: every ingredient group needs a `name` and a non-empty " \
                 "`items` list: #{malformed.inspect}"
  end

  rule "ingredient_lines_are_single_plain_strings" do |recipe|
    skip_without(recipe, "ingredients")

    items = Array(recipe["ingredients"]).flat_map { |group| Array(group["items"]) }
    offenders = items.reject do |item|
      item.is_a?(String) && item.strip != "" && !item.match?(Contract::INGREDIENT_FORBIDDEN)
    end

    assert_empty offenders,
                 "#{recipe.name}: an ingredient is one line of text — no nested structure " \
                 "and no embedded newline, because a broken line arrives at an importer as " \
                 "two ingredients: #{offenders.inspect}"
  end

  rule "ingredient_lines_are_not_padded" do |recipe|
    skip_without(recipe, "ingredients")

    items = Array(recipe["ingredients"]).flat_map { |group| Array(group["items"]) }.grep(String)
    padded = items.reject { |item| item == item.strip }

    assert_empty padded,
                 "#{recipe.name}: leading or trailing whitespace survives into the JSON-LD, " \
                 "where it shows up inside an importer's ingredient list: #{padded.inspect}"
  end

  rule "no_ingredient_is_listed_twice" do |recipe|
    skip_without(recipe, "ingredients")

    items = Array(recipe["ingredients"]).flat_map { |group| Array(group["items"]) }.grep(String)
    duplicates = items.tally.select { |_, count| count > 1 }.keys

    assert_empty duplicates,
                 "#{recipe.name}: #{duplicates.inspect} appears twice in the ingredient " \
                 "list, so an importer adds the quantity to a shopping list twice. Split " \
                 "the quantity across the steps that use it, in one line"
  end
end
