# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/plain_language"

# The words a recipe puts in front of a cook.
#
# Every rule here is applied again, later, to the built page in
# test/import_contract/plain_language_test.rb, because the home page and the
# layout carry prose of their own that no recipe can be blamed for. This set
# runs first because it is the one that can name the file to open and the field
# to edit, and it needs no build to do it.
#
# Only the fields a visitor reads are checked. An ingredient line is data, a
# keyword is data, and the comments in the front matter are for whoever edits
# the recipe next.
class VoiceTest < RecipeSourceTest
  # Field, and what a failure should call it. Nested notes are gathered by hand
  # rather than by walking the whole structure, so that a rule about prose is
  # never applied to a quantity.
  def prose(recipe)
    passages = []

    %w[description disambiguating_description notes image_alt image_caption].each do |key|
      passages << [key, recipe[key]] if recipe[key].is_a?(String)
    end

    passages << ["nutrition.note", recipe["nutrition"]["note"]] if recipe["nutrition"].is_a?(Hash)

    allergens = recipe["allergens"]
    if allergens.is_a?(Hash)
      passages << ["allergens.note", allergens["note"]]
      %w[present may_contain].each do |list|
        Array(allergens[list]).grep(Hash).each do |entry|
          passages << ["allergens.#{list}[#{entry["id"]}].note", entry["note"]]
        end
      end
    end

    Array(recipe["steps"]).grep(Hash).each_with_index do |step, index|
      passages << ["step #{index + 1} name", step["name"]]
      passages << ["step #{index + 1} text", step["text"]]
    end

    passages.select { |_where, text| text.is_a?(String) && !text.strip.empty? }
  end

  rule "sentences_stay_short_enough_to_follow" do |recipe|
    skip_without_front_matter(recipe)

    offenders = prose(recipe).flat_map do |where, text|
      PlainLanguage.long_sentences(text).map do |sentence|
        "#{where} (#{PlainLanguage.reading_length(sentence)} words): #{sentence}"
      end
    end

    assert_empty offenders,
                 "#{recipe.name}: sentences over #{PlainLanguage::MAX_SENTENCE_WORDS} words. " \
                 "Someone is reading this with one hand free and a hot pan in front of them. " \
                 "Split it into two sentences, one idea each — #{offenders.join(" | ")}"
  end

  rule "prose_carries_no_dashes" do |recipe|
    skip_without_front_matter(recipe)

    offenders = prose(recipe).reject { |_where, text| PlainLanguage.dashes(text).empty? }

    assert_empty offenders.map { |where, text| "#{where}: #{text}" },
                 "#{recipe.name}: a dash in the middle of a sentence. It is the clearest " \
                 "sign of machine-written prose there is, and a full stop, a comma, a colon " \
                 "or brackets always reads more plainly. Hyphenated words are fine"
  end

  rule "prose_uses_everyday_words" do |recipe|
    skip_without_front_matter(recipe)

    offenders = prose(recipe).flat_map do |where, text|
      (PlainLanguage.slop(text) + PlainLanguage.jargon(text)).map { |term| "#{where}: #{term}" }
    end

    assert_empty offenders,
                 "#{recipe.name}: words a cook has no reason to know, or words that turn up " \
                 "in machine-written text far more often than in anyone's kitchen — " \
                 "#{offenders.join("; ")}"
  end

  rule "prose_says_what_a_thing_is_not_what_it_is_not" do |recipe|
    skip_without_front_matter(recipe)

    parallelisms = prose(recipe).flat_map do |where, text|
      PlainLanguage.negative_parallelisms(text).map { |hit| "#{where}: #{hit}" }
    end

    assert_empty parallelisms,
                 "#{recipe.name}: \"not just X, but Y\" says the same thing twice and " \
                 "instructs nobody. Say what to do — #{parallelisms.join("; ")}"
  end

  rule "one_construction_does_not_carry_the_whole_page" do |recipe|
    skip_without_front_matter(recipe)

    used = prose(recipe).sum { |_where, text| PlainLanguage.contrasts(text).length }

    assert_operator used, :<=, PlainLanguage::MAX_CONTRASTS,
                    "#{recipe.name}: \"rather than\" and \"instead of\" #{used} times. Each " \
                    "one pairs a fact with something it is not, and a page of them reads as " \
                    "one voice arguing with itself. Keep the ones correcting a real " \
                    "expectation; state the rest plainly"
  end
end
