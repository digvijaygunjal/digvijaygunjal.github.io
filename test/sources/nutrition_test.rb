# frozen_string_literal: true

require_relative "../test_helper"

# The nutrition panel is per serving, and every key maps onto a property of
# schema.org's NutritionInformation. A key spelled differently is not an error
# anywhere — the layout reads the name it expects, finds nothing, and prints
# nothing, leaving a panel that looks complete and is not.
class NutritionTest < RecipeSourceTest
  rule "nutrition_carries_all_twelve_properties" do |recipe|
    skip_without(recipe, "nutrition")

    missing = Contract::NUTRITION_KEYS.keys.reject do |key|
      recipe["nutrition"][key].to_s.strip != ""
    end

    assert_empty missing,
                 "#{recipe.name}: nutrition is missing #{missing.join(", ")}. All twelve " \
                 "NutritionInformation properties are emitted, and a partial panel invites " \
                 "a reader to assume the absent ones are zero"
  end

  rule "nutrition_has_no_unknown_keys" do |recipe|
    skip_without(recipe, "nutrition")

    known = Contract::NUTRITION_KEYS.keys + Contract::NUTRITION_OPTIONAL_KEYS
    unknown = recipe["nutrition"].keys - known

    assert_empty unknown,
                 "#{recipe.name}: nutrition carries #{unknown.join(", ")}, which the layout " \
                 "does not read. A misspelt key is dropped in silence rather than failing"
  end

  rule "nutrition_states_a_serving_size" do |recipe|
    skip_without(recipe, "nutrition")

    serving = recipe["nutrition"]["serving_size"].to_s

    refute_empty serving.strip,
                 "#{recipe.name}: the figures are per serving, so `serving_size` has to say " \
                 "what a serving is — as a weight, since a quarter of a pot is not a measure"
    assert_match(/\d/, serving,
                 "#{recipe.name}: `serving_size` is #{serving.inspect}, which states no " \
                 "quantity. Give the weight, not just the fraction of the pot")
  end

  rule "nutrition_values_carry_their_units" do |recipe|
    skip_without(recipe, "nutrition")

    nutrition = recipe["nutrition"]
    malformed = Contract::NUTRITION_KEYS.keys.reject do |key|
      value = nutrition[key].to_s.strip
      case key
      when "serving_size" then true
      when "calories"     then value.match?(Contract::NUTRITION_ENERGY)
      else                     value.match?(Contract::NUTRITION_MASS)
      end
    end

    assert_empty malformed,
                 "#{recipe.name}: #{malformed.join(", ")} must carry a unit — '13 g', " \
                 "'190 mg', '520 kcal'. A bare number reaches an importer with no way to " \
                 "tell grams from milligrams"
  end
end
