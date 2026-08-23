# frozen_string_literal: true

# The rules this repository chose for itself, in one place.
#
# Where Vocabulary holds facts about published standards, everything here is a
# decision recorded in README.md and CLAUDE.md. A key spelled differently from
# these lists is not an error anywhere else in the stack: the layout reads the
# name it expects, finds nothing, and renders nothing, which is exactly the
# failure mode these lists exist to make loud.
module Contract
  # Front matter without which the page, the JSON-LD, or both, lose something a
  # consumer needs. Kept in step with README.md's front-matter reference.
  REQUIRED_KEYS = %w[
    title
    description
    date
    image
    image_alt
    yield
    category
    cuisine
    cooking_method
    ingredients
    steps
    diets
    allergens
    nutrition
    estimated_cost
    prep_time
    cook_time
    total_time
  ].freeze

  # Nutrition as a recipe spells it, mapped to the schema.org property each one
  # becomes. `note` is the one key here that is not a schema property.
  NUTRITION_KEYS = {
    "serving_size"             => "servingSize",
    "calories"                 => "calories",
    "protein_content"          => "proteinContent",
    "fat_content"              => "fatContent",
    "saturated_fat_content"    => "saturatedFatContent",
    "unsaturated_fat_content"  => "unsaturatedFatContent",
    "trans_fat_content"        => "transFatContent",
    "cholesterol_content"      => "cholesterolContent",
    "carbohydrate_content"     => "carbohydrateContent",
    "sugar_content"            => "sugarContent",
    "fiber_content"            => "fiberContent",
    "sodium_content"           => "sodiumContent"
  }.freeze

  NUTRITION_OPTIONAL_KEYS = %w[note].freeze

  # A mass or volume with its unit attached. A bare number is ambiguous to an
  # importer, which has no way to guess grams from milligrams.
  NUTRITION_MASS = /\A\d+(?:\.\d+)?\s?(?:g|mg|ml)\z/

  # Energy, which schema.org expects as a number with an energy unit.
  NUTRITION_ENERGY = /\A\d+(?:\.\d+)?\s?(?:kcal|calories)\z/

  # Everything the recipe layout reads from a step. A key outside this set is
  # dropped in silence, so a typo costs a step its appliance or its duration
  # while the page still renders and still looks finished.
  STEP_KEYS = %w[name text appliance setting duration continues image image_alt].freeze

  STEP_REQUIRED_KEYS = %w[name text].freeze

  # An HTML tag opening in text that is supposed to be prose. Recipes are data:
  # anything the layout cannot express is added to the layout, so that every
  # recipe gains it, rather than written into one recipe as markup.
  HTML_TAG = %r{<\s*/?\s*[a-zA-Z][a-zA-Z0-9]*(?:\s|/?>)}

  # An ingredient line is one string carrying quantity, unit and item, because
  # that is what `recipeIngredient` and `supply` are: flat strings. A line
  # broken in two arrives at an importer as two ingredients.
  INGREDIENT_FORBIDDEN = /\n/
end
