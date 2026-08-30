# frozen_string_literal: true

# The house rules for prose a visitor reads, in the form a check can apply.
#
# Where Contract holds decisions about the data a page emits, everything here
# is a decision about the words on it. The site is read by someone standing in
# a kitchen with one hand free, so a sentence that has to be read twice has
# already failed, however accurate it is.
#
# The rules come from three places, and none of them is a preference of ours:
#
#   * Plain English, as the UK government and the US Plain Writing Act define
#     it: one idea per sentence, about 15 to 20 words and never more than 25,
#     everyday words, say who does what.
#     https://www.gov.uk/guidance/style-guide/writing-for-gov-uk
#     https://www.plainlanguage.gov/guidelines/
#   * Wikipedia:Signs of AI writing, the field guide WikiProject AI Cleanup
#     built from thousands of machine-written articles. The tells it lists are
#     what "sounds like a chatbot wrote it" actually means: puffery words,
#     "not just X, but Y", strings of em dashes, commentary about the writing
#     instead of the subject.
#     https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing
#   * The banned-vocabulary list from no-slop, which turns that guide into a
#     word list with plain replacements.
#     https://github.com/Byk3y/no-slop
#
# Prose the reader never sees is out of scope. Code comments, the three
# markdown documents and the front-matter comments explain decisions to people
# who are reading the repository, and they are allowed to take as long as they
# need.
module PlainLanguage
  # Plain English puts a sentence at about 15 to 20 words and never over 25.
  # The cap is the ceiling, not the target.
  MAX_SENTENCE_WORDS = 25

  # Em and en dashes. A dash in the middle of a sentence is the most reliable
  # sign of AI prose there is, and it is nearly always a full stop, a comma, a
  # colon or a pair of brackets doing a job it does better. Hyphens are
  # untouched: "one-pot" and "gluten-free" are words.
  DASHES = /[—–]/

  # Sentence shapes the AI-writing guide names. Each one says the same thing
  # twice, once in the negative, and reads as emphasis rather than instruction.
  NEGATIVE_PARALLELISMS = [
    /\bnot just\b[^.]{0,60}\bbut\b/i,
    /\bnot only\b[^.]{0,60}\bbut\b/i,
    /\bit(?:'s| is) not\b[^.]{0,60},\s*it(?:'s| is)\b/i,
    /\bisn't (?:just|only)\b/i
  ].freeze

  # "Rather than" is a fair way to correct an expectation the reader really has.
  # It is also this site's oldest tic: the home page and two recipes each used
  # it four or more times, until every fact arrived paired with the thing it was
  # not. Twice a page is enough for the honest uses.
  MAX_CONTRASTS = 2
  CONTRASTS = /\brather than\b|\binstead of\b/i

  # Words that are overrepresented in machine-written text, with what to write
  # instead. Trimmed to the ones that could plausibly turn up on a recipe site:
  # a list nobody could trip over teaches nothing.
  SLOP_WORDS = {
    "delve" => "look at",
    "tapestry" => "cut it",
    "pivotal" => "important",
    "vibrant" => "say what it looks like",
    "meticulous" => "careful",
    "meticulously" => "carefully",
    "testament" => "proof",
    "underscores" => "shows",
    "intricate" => "complicated",
    "interplay" => "how the two work together",
    "garner" => "get",
    "bolster" => "strengthen",
    "foster" => "encourage",
    "showcase" => "show",
    "showcases" => "shows",
    "enduring" => "lasting",
    "crucial" => "important",
    "renowned" => "well known",
    "groundbreaking" => "new",
    "profound" => "big",
    "multifaceted" => "varied",
    "leverage" => "use",
    "utilise" => "use",
    "utilize" => "use",
    "facilitate" => "help",
    "encompasses" => "covers",
    "spearhead" => "lead",
    "harness" => "use",
    "elevate" => "improve",
    "streamline" => "simplify",
    "seamless" => "smooth",
    "seamlessly" => "smoothly",
    "holistic" => "whole",
    "synergy" => "cut it",
    "paradigm" => "approach",
    "myriad" => "many",
    "plethora" => "plenty of",
    "realm" => "area"
  }.freeze

  # Phrases that announce a sentence instead of writing it, or that praise the
  # subject instead of describing it.
  SLOP_PHRASES = {
    "worth noting" => "just say the thing",
    "worth knowing" => "just say the thing",
    "it should be noted" => "just say the thing",
    "let's explore" => "just say the thing",
    "at the heart of" => "in",
    "plays a crucial role" => "say what it does",
    "paving the way" => "say what happens next",
    "a testament to" => "proof of",
    "serves as a" => "is a",
    "stands as a" => "is a",
    "in today's" => "cut it",
    "deep dive" => "look at"
  }.freeze

  # Words that describe how this site is built, not how the food is cooked. All
  # of them are correct, and all of them belong in the repository's own
  # documents, where the reader has signed up for them. A cook has not.
  #
  # Cooking and appliance terms are not jargon here and are deliberately absent
  # from this list: Sauté, natural release, float valve, deglaze and tadka are
  # the words the job is done with. Explain one at first use if it is unusual;
  # do not replace it with something vaguer.
  SITE_JARGON = {
    "json-ld" => "say what the reader gets, not the format it is in",
    "schema.org" => "\"a copy of the recipe that apps can read\"",
    "structured data" => "\"a copy of the recipe that apps can read\"",
    "machine-readable" => "\"apps can read it\"",
    "metadata" => "say which fields",
    "front matter" => "\"the fields at the top of the file\"",
    "progressive enhancement" => "say what happens without the script",
    "parser" => "\"an app that reads the page\"",
    "canonical" => "\"the main address of the page\"",
    "annex ii" => "\"the EU allergen list\"",
    "osmosis" => "\"it pulls the water out\""
  }.freeze

  # One sentence, as a reader meets it. Splitting on a full stop followed by a
  # space keeps "2.5 tbsp" and "0.5 tsp" whole, which is the only decimal shape
  # a recipe uses. Semicolons are deliberately not breaks: a clause bolted on
  # with a semicolon is part of the sentence a reader has to hold in their
  # head, and counting it separately would excuse exactly the sentence this cap
  # exists to break up.
  def self.sentences(text)
    text.to_s.gsub(/\s+/, " ").strip.split(/(?<=[.!?])\s+/).reject { |s| s.strip.empty? }
  end

  # How long a sentence reads, which is not the same as how many words it has.
  #
  # A step lists what goes into the pot, and that list is one instruction
  # however many things are in it: "add 1 tsp cumin seeds, 1 tsp mustard seeds,
  # 2 pinches asafoetida and 4 whole cloves" is no harder to follow than adding
  # one of them. So the parts carrying a quantity collapse to the longest of
  # them, and every other part of the sentence is counted in full. A sentence
  # with fewer than three such parts is not a list, and is counted as written.
  def self.reading_length(sentence)
    parts = sentence.split(/,\s*/)
    listed, prose = parts.partition { |part| part.match?(/\d/) }

    return words_in(sentence) if listed.length < 3

    prose.sum { |part| words_in(part) } + listed.map { |part| words_in(part) }.max
  end

  def self.words_in(text)
    text.to_s.split(/\s+/).count { |word| word.match?(/[[:alnum:]]/) }
  end

  def self.long_sentences(text)
    sentences(text).select { |sentence| reading_length(sentence) > MAX_SENTENCE_WORDS }
  end

  def self.dashes(text)
    text.to_s.scan(DASHES)
  end

  def self.slop(text)
    haystack = text.to_s.downcase

    words = SLOP_WORDS.keys.select { |word| haystack.match?(/\b#{Regexp.escape(word)}\b/) }
    phrases = SLOP_PHRASES.keys.select { |phrase| haystack.include?(phrase) }

    (words + phrases).map { |term| "#{term} (try: #{SLOP_WORDS[term] || SLOP_PHRASES[term]})" }
  end

  def self.jargon(text)
    haystack = text.to_s.downcase

    SITE_JARGON.filter_map do |term, replacement|
      "#{term} (try: #{replacement})" if haystack.include?(term)
    end
  end

  def self.negative_parallelisms(text)
    NEGATIVE_PARALLELISMS.filter_map { |pattern| text.to_s[pattern] }
  end

  def self.contrasts(text)
    text.to_s.scan(CONTRASTS)
  end
end
