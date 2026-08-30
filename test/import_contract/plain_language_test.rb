# frozen_string_literal: true

require_relative "test_helper"
require_relative "../support/plain_language"

# The same house rules as test/sources/voice_test.rb, one step later: applied to
# the words that actually reach a page.
#
# This set exists because a recipe is not the only thing that writes on this
# site. The home page carries the whole explanation of how to import a recipe,
# and the layout supplies the allergen paragraph, the headings and the labels
# that every recipe page inherits. None of that is in a recipe file, so no
# check over the sources can ever see it, and it is exactly the copy that
# drifts back towards jargon: it is written once and then read as furniture.
#
# A block with no sentence in it is data, not prose — an ingredient line, a
# nutrition figure, a piece of equipment. Prose is what a reader reads in
# sentences, so that is what is measured, and nothing has to be kept in step
# with a list of class names that a redesign would quietly invalidate.
class PlainLanguageTest < Minitest::Test
  BLOCKS = "main p, main li, main dd, main dt, main summary, main figcaption, main h1, main h2, main h3"

  # Two things inside a step are labels rather than sentences: the appliance
  # badge above it and the step's own name. They are dropped before measuring,
  # because a reader meets them as separate lines and only the instruction
  # underneath is read as a sentence.
  #
  # What is deliberately kept is the "With the pot still on Sauté, " that the
  # layout puts in front of a continuing step. That is part of the sentence on
  # the page, it is six words a recipe file never sees, and this is the only
  # check in the suite positioned to notice that it pushes a step over.
  #
  # The two class names are the layout's own. If either is renamed, the label
  # is measured as part of the instruction and these rules fail loudly, which
  # is the direction a coupling like this should break in.
  def self.reader_facing(doc)
    doc.css(BLOCKS).filter_map do |node|
      step = node.matches?(".steps li")
      node = node.dup
      node.css(".setting").each(&:remove)
      node.css("strong").first&.remove if step

      text = node.text.gsub(/\s+/, " ").strip
      text if text.include?(".") && PlainLanguage.words_in(text) > 5
    end.uniq
  end

  # One method per page per rule, the same shape as the rest of the suite: the
  # home page and every recipe, so a new recipe brings its own assertions and a
  # failure names the page to open.
  def self.rule(name, &block)
    define_method(:"test_index__#{name}") do
      instance_exec("the home page", PlainLanguageTest.reader_facing(BuiltSite.index_doc), &block)
    end

    BuiltSite.pages.each do |page|
      define_method(:"test_#{page.slug.tr("-", "_")}__#{name}") do
        instance_exec(page.name, PlainLanguageTest.reader_facing(page.doc), &block)
      end
    end
  end

  rule "sentences_stay_short_enough_to_follow" do |where, passages|
    offenders = passages.flat_map do |text|
      PlainLanguage.long_sentences(text).map { |s| "(#{PlainLanguage.reading_length(s)} words) #{s}" }
    end

    assert_empty offenders,
                 "#{where}: sentences over #{PlainLanguage::MAX_SENTENCE_WORDS} words. Plain " \
                 "English puts a sentence at 15 to 20 and never past 25, and this one is read " \
                 "in a kitchen. One idea per sentence — #{offenders.join(" | ")}"
  end

  rule "prose_carries_no_dashes" do |where, passages|
    offenders = passages.reject { |text| PlainLanguage.dashes(text).empty? }

    assert_empty offenders,
                 "#{where}: a dash in the middle of a sentence, which is the clearest sign of " \
                 "machine-written prose there is. A full stop, a comma, a colon or brackets " \
                 "reads more plainly every time"
  end

  rule "prose_uses_everyday_words" do |where, passages|
    offenders = passages.flat_map { |text| PlainLanguage.slop(text) + PlainLanguage.jargon(text) }.uniq

    assert_empty offenders,
                 "#{where}: words that belong in this repository's own documents rather than " \
                 "in front of a cook, or words that turn up in machine-written text far more " \
                 "often than in anyone's kitchen — #{offenders.join("; ")}"
  end

  rule "prose_says_what_a_thing_is_not_what_it_is_not" do |where, passages|
    offenders = passages.flat_map { |text| PlainLanguage.negative_parallelisms(text) }

    assert_empty offenders,
                 "#{where}: \"not just X, but Y\" says the same thing twice and tells the " \
                 "reader nothing to do — #{offenders.join("; ")}"
  end

  rule "one_construction_does_not_carry_the_whole_page" do |where, passages|
    used = passages.sum { |text| PlainLanguage.contrasts(text).length }

    assert_operator used, :<=, PlainLanguage::MAX_CONTRASTS,
                    "#{where}: \"rather than\" and \"instead of\" #{used} times. A page where " \
                    "every fact arrives paired with the thing it is not reads as one voice " \
                    "arguing with itself"
  end
end
