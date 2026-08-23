# frozen_string_literal: true

require_relative "../test_helper"

# Times are the field an importer trusts most and a reader checks least. A
# duration that does not parse is dropped in silence by a consumer; one that
# parses but does not add up is worse, because it is believed.
class DurationsTest < RecipeTest
  TIME_KEYS = %w[prep_time cook_time total_time].freeze

  TIME_KEYS.each do |key|
    rule "#{key}_is_an_iso_8601_duration" do |recipe|
      skip_without_front_matter(recipe)

      assert Vocabulary.duration_seconds(recipe[key]),
             "#{recipe.name}: `#{key}` is #{recipe[key].inspect}, which is not an ISO 8601 " \
             "duration. Write it as PT45M, PT1H30M or PT1H — that is the literal string " \
             "emitted into the JSON-LD, and a consumer that cannot parse it drops the time"
    end
  end

  rule "durations_add_up" do |recipe|
    skip_without_front_matter(recipe)

    prep, cook, total = TIME_KEYS.map { |key| Vocabulary.duration_seconds(recipe[key]) }
    skip "#{recipe.name} has a duration that does not parse" if [prep, cook, total].any?(&:nil?)

    assert_equal total, prep + cook,
                 "#{recipe.name}: prep_time + cook_time must equal total_time. " \
                 "#{recipe["prep_time"]} + #{recipe["cook_time"]} is " \
                 "#{prep + cook} seconds, but total_time says #{total}"
  end
end
