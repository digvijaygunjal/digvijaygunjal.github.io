# frozen_string_literal: true

require_relative "../test_helper"

# A recipe is data. Anything the layout cannot express is added to the layout,
# so every recipe gains it — markup written into one recipe is markup the next
# recipe does not get, and it lands unescaped in the JSON-LD as well as on the
# page.
class MarkupTest < RecipeTest
  rule "front_matter_carries_no_raw_html" do |recipe|
    skip_without_front_matter(recipe)

    offenders = []
    Site.strings_in(recipe.front_matter) do |string|
      offenders << string if string.match?(Contract::HTML_TAG)
    end

    assert_empty offenders,
                 "#{recipe.name}: raw HTML in front matter — #{offenders.inspect}. It reaches " \
                 "the JSON-LD as literal text, where a consumer has no reason to strip it"
  end

  rule "the_body_carries_no_raw_html" do |recipe|
    body = recipe.body.to_s

    refute_match Contract::HTML_TAG, body,
                 "#{recipe.name}: raw HTML after the front matter. If the layout cannot " \
                 "express what the recipe needs, extend the layout so every recipe gains it"
  end
end
