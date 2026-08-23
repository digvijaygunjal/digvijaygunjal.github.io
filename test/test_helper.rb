# frozen_string_literal: true

# Entry point for the whole suite.
#
# Nothing in here — or anywhere below test/ — knows about a particular recipe.
# The tests iterate over whatever `_recipes/` holds, so adding a recipe adds its
# assertions and deleting one takes them away. A test that named a recipe, or
# asserted one of its values, would pass for the wrong reason the moment that
# recipe changed.

require "minitest/autorun"

require_relative "support/vocabulary"
require_relative "support/contract"
require_relative "support/site"
require_relative "support/recipe_source_case"
