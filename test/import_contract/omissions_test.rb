# frozen_string_literal: true

require_relative "test_helper"

# What must not be there. Every property here is either a duplicate of one
# already emitted, a superseded spelling of one, or a claim the site has no
# real data behind — and each is silently believed by whatever reads it.
class OmissionsTest < BuiltPageTest
  # `step` is live and not superseded; it means the same thing as
  # recipeInstructions. A consumer reading both and concatenating imports every
  # step twice, which is a broken recipe rather than an untidy one.
  DUPLICATE_METHOD = %w[step].freeze

  # Superseded spellings. Emitting one alongside its replacement is how a page
  # ends up carrying two ingredient lists that disagree.
  SUPERSEDED = %w[ingredients steps reviews awards isBasedOnUrl].freeze

  # Honest only when there is something real behind them. A rating a site
  # awards its own recipe is discarded by search engines as self-serving, and
  # the whole block can go with it.
  UNEARNED = %w[aggregateRating review].freeze

  rule "the_method_is_not_emitted_twice" do |page|
    present = DUPLICATE_METHOD.select { |key| page.recipe_json.key?(key) }

    assert_empty present,
                 "#{page.name}: `step` duplicates recipeInstructions. A consumer that reads " \
                 "both would import every step twice, which breaks the one rule this site has"
  end

  rule "no_superseded_property_is_emitted" do |page|
    present = SUPERSEDED.select { |key| page.recipe_json.key?(key) }

    assert_empty present,
                 "#{page.name}: #{present.join(", ")} — superseded spellings. Emitting one " \
                 "next to its replacement gives a consumer two answers to the same question"
  end

  rule "ratings_and_reviews_are_only_emitted_when_they_are_real" do |page|
    unearned = UNEARNED.select { |key| page.recipe_json.key?(key) }
    backed = %w[rating reviews].any? { |key| !page.recipe[key].nil? }

    assert_empty unearned, <<~WHY.chomp unless backed
      #{page.name}: #{unearned.join(", ")} is emitted with no recorded rating or review
      behind it. A recipe that rates itself is dishonest, and a search engine that spots
      one discards the whole block as a self-serving review — so the invented field costs
      the page the fields that were true
    WHY
  end
end
