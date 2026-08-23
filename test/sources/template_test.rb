# frozen_string_literal: true

require_relative "../test_helper"

# The template a new recipe starts from.
#
# It is not generated from anything, so it goes stale in silence: a field added
# to the contract simply never appears in it, and the next contributor to use it
# meets a failing check about a key they were never told existed.
#
# Not a RecipeSourceTest, because the template deliberately is not a recipe —
# `Site.recipes` globs `*.md` and this file ends `.md.example`, which is part of
# how it stays out of the build.
class TemplateTest < Minitest::Test
  PATH = File.join(Site::ROOT, "_recipes", "_TEMPLATE.md.example")

  # The fields README calls derived: they describe the dish rather than
  # transcribe it, so they are the ones that must arrive empty. A template that
  # shipped real figures would hand every new recipe another dish's nutrition,
  # which is the exact failure the template exists to prevent.
  DERIVED = %w[nutrition estimated_cost diets alternate_names disambiguating_description].freeze

  def front_matter
    @front_matter ||= begin
      match = File.read(PATH, encoding: Site::ENCODING).match(Site::FRONT_MATTER)

      refute_nil match,
                 "_TEMPLATE.md.example has no front matter Jekyll would recognise. The usual " \
                 "cause is a missing closing `---`, which is also the bug the template's own " \
                 "last comment warns about"

      YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true)
    end
  end

  def test_the_template_offers_every_key_a_recipe_must_have
    missing = Contract::REQUIRED_KEYS - front_matter.keys

    assert_empty missing,
                 "_TEMPLATE.md.example is missing #{missing.join(", ")}. Someone starting from " \
                 "it would meet a failing check about a key the template never mentioned"
  end

  def test_the_template_offers_every_nutrition_key
    missing = Contract::NUTRITION_KEYS.keys - (front_matter["nutrition"] || {}).keys

    assert_empty missing,
                 "_TEMPLATE.md.example's nutrition block is missing #{missing.join(", ")}. All " \
                 "twelve are required, so an absent one is a check failure waiting for whoever " \
                 "uses this next"
  end

  def test_the_derived_fields_are_left_empty
    filled = DERIVED.select { |key| any_value?(front_matter[key]) }

    assert_empty filled,
                 "_TEMPLATE.md.example has values in #{filled.join(", ")}. Those five describe " \
                 "the dish rather than transcribe it, and the whole point of the template is " \
                 "that they start empty: a number copied from another recipe is believed " \
                 "precisely because it is present"
  end

  # A value counts as filled only if some string in it has content. `currency:
  # EUR` and a `schema:` key with nothing after it are scaffolding, not data —
  # so the check looks for prose, not for structure.
  def any_value?(value)
    found = false
    Site.strings_in(value) { |string| found ||= string.strip.length > 3 }
    found
  end
end
