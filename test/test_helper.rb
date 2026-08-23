# frozen_string_literal: true

# Entry point for the whole suite.
#
# Nothing in here — or anywhere below test/ — knows about a particular recipe.
# The tests iterate over whatever `_recipes/` holds, so adding a recipe adds its
# assertions and deleting one takes them away. A test that named a recipe, or
# asserted one of its values, would pass for the wrong reason the moment that
# recipe changed.

# Read everything as UTF-8. A Ruby process started without LANG set — the
# normal state of affairs in CI — defaults to a US-ASCII external encoding, and
# the first em dash in a recipe then raises. html-proofer swallows that raise
# inside its async workers and reports no failures, so the check passes without
# having read a single file.
Encoding.default_external = Encoding::UTF_8

require "minitest/autorun"

require_relative "support/vocabulary"
require_relative "support/contract"
require_relative "support/site"
require_relative "support/recipe_source_case"
