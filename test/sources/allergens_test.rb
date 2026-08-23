# frozen_string_literal: true

require_relative "../test_helper"

# "Can I eat this" is asked before the ingredient list is read. The layout
# derives the "free from" list by subtracting what a recipe declares from the
# fourteen, so an id that does not resolve does not merely fail to appear under
# "Contains" — it moves that allergen into "Free from".
class AllergensTest < RecipeSourceTest
  LISTS = %w[present may_contain].freeze

  rule "declares_allergens_in_the_expected_shape" do |recipe|
    skip_without_front_matter(recipe)

    allergens = recipe["allergens"]

    assert_kind_of Hash, allergens,
                   "#{recipe.name}: `allergens` is a mapping with `present:` and " \
                   "`may_contain:` lists. Note the key is `present`, not `contains` — " \
                   "`contains` is a Liquid operator and cannot be read from front matter"
    LISTS.each do |list|
      next if allergens[list].nil?

      assert_kind_of Array, allergens[list],
                     "#{recipe.name}: `allergens.#{list}` is a list of entries carrying an `id`"
    end
  end

  rule "allergen_ids_resolve" do |recipe|
    skip_without(recipe, "allergens")

    declared = LISTS.flat_map { |list| Array(recipe["allergens"][list]) }
    unresolved = declared.reject { |entry| Site.allergen_ids.include?(entry.is_a?(Hash) ? entry["id"] : entry) }

    assert_empty unresolved,
                 "#{recipe.name}: these allergen entries do not resolve against " \
                 "_data/allergens.yml: #{unresolved.inspect}. An unresolved id is not a " \
                 "no-op — the layout subtracts what resolves, so the allergen ends up " \
                 "listed under 'Free from'"
  end

  rule "no_allergen_is_both_present_and_possible" do |recipe|
    skip_without(recipe, "allergens")

    ids = LISTS.to_h do |list|
      [list, Array(recipe["allergens"][list]).map { |entry| entry.is_a?(Hash) ? entry["id"] : entry }]
    end
    both = ids["present"] & ids["may_contain"]

    assert_empty both,
                 "#{recipe.name}: #{both.join(", ")} appears in both `present` and " \
                 "`may_contain`. The two lists and the derived 'free from' list have to " \
                 "partition the fourteen, and a reader cannot act on both answers"
  end

  rule "no_allergen_is_declared_twice_in_one_list" do |recipe|
    skip_without(recipe, "allergens")

    LISTS.each do |list|
      ids = Array(recipe["allergens"][list]).map { |entry| entry.is_a?(Hash) ? entry["id"] : entry }
      duplicates = ids.tally.select { |_, count| count > 1 }.keys

      assert_empty duplicates,
                   "#{recipe.name}: `allergens.#{list}` lists #{duplicates.join(", ")} twice, " \
                   "which prints the same allergen twice with two different notes"
    end
  end
end
