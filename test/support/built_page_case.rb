# frozen_string_literal: true

require_relative "built_site"
require_relative "contract"
require_relative "vocabulary"

# Base class for a rule that has to hold for every built recipe page. Same
# shape as RecipeSourceTest, one step later: one test per built page per rule,
# named for both.
class BuiltPageTest < Minitest::Test
  def self.rule(name, &block)
    BuiltSite.pages.each do |page|
      define_method(:"test_#{page.slug.tr("-", "_")}__#{name}") do
        instance_exec(page, &block)
      end
    end
  end

  # The strings a recipe's ingredient list flattens to — the order the JSON-LD
  # is expected to preserve.
  def source_ingredients(page)
    Array(page.recipe["ingredients"]).flat_map { |group| Array(group["items"]) }
  end
end
