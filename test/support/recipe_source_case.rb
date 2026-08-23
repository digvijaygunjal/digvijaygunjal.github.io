# frozen_string_literal: true

require_relative "site"
require_relative "contract"
require_relative "vocabulary"

# Base class for a rule that has to hold for every recipe.
#
# `rule` generates one test method per recipe, so a failure names the file and
# the rule before any message is read — `test_gajar_halwa__durations_add_up`
# rather than a single "front matter invalid" covering the whole collection.
# Two recipes breaking two different rules are two failures, not one.
class RecipeTest < Minitest::Test
  def self.rule(name, &block)
    Site.recipes.each do |recipe|
      define_method(:"test_#{recipe.slug.tr("-", "_")}__#{name}") do
        instance_exec(recipe, &block)
      end
    end
  end

  # Every rule below assumes front matter was read. When it was not, that is
  # its own failure in front_matter_test.rb, and repeating it in each of the
  # other rules would bury the one message that explains the rest.
  def skip_without_front_matter(recipe)
    skip "#{recipe.name} has no readable front matter" unless recipe.front_matter?
  end

  # Rules that only apply when a recipe uses an optional field.
  def skip_without(recipe, key)
    skip_without_front_matter(recipe)
    skip "#{recipe.name} does not set `#{key}`" if recipe[key].nil?
  end
end
