# frozen_string_literal: true

require_relative "test_helper"

# Whether the vocabulary still says what this site assumes it says.
#
# Everything here fails silently in production, and more slowly than anything
# else in this repository. schema.org retires a term by pointing it at its
# replacement rather than by deleting it, so the day `cookTime` gains a
# `supersededBy` nothing breaks: the JSON-LD still parses, the page still looks
# finished, and consumers quietly stop reading the property. Nothing else here
# would ever notice.
#
# Run by `rake schema:drift`, never by `rake default` — these need a clone of
# the vocabulary, which a contributor has no reason to have.
class SchemaDriftTest < Minitest::Test
  # Every term the built pages actually use, gathered from the output rather
  # than from a list written down beside it. A hand-kept list is a second thing
  # to update, and the first thing to forget: it would still read as complete
  # while the layout emitted something it had never heard of.
  def self.emitted
    @emitted ||= begin
      properties = Set.new
      types = Set.new

      walk = lambda do |node|
        case node
        when Hash
          node.each do |key, value|
            types.merge(Array(value).grep(String)) if key == "@type"
            properties << key unless key.start_with?("@")
            walk.call(value)
          end
        when Array then node.each { |item| walk.call(item) }
        end
      end

      BuiltSite.pages.each { |page| walk.call(page.recipe_json) }
      { properties: properties.to_a.sort, types: types.to_a.sort }
    end
  end

  def release
    @release ||= SchemaRelease.latest_release
  end

  def test_no_property_this_site_emits_has_been_superseded
    # The six the layout supports but no recipe sets today are checked too.
    # They are the ones that would go stale unwatched, because nothing emits
    # them and so nothing would fail until the first recipe finally used one.
    names = self.class.emitted[:properties] + Contract::SUPPORTED_WHEN_SET

    superseded = names.uniq.filter_map do |name|
      replacement = SchemaRelease.superseded_by(name, release)
      "#{name} -> #{replacement}" if replacement
    end

    assert_empty superseded, <<~WHY.chomp
      Release #{release} supersedes properties this site emits: #{superseded.join(", ")}.
      A superseded property still parses and still renders, so nothing here breaks —
      consumers simply stop reading it, and the recipe quietly claims less than the
      page says. Emit the replacement instead, and update the table in CLAUDE.md
      in the same change
    WHY
  end

  def test_every_property_this_site_emits_is_a_real_term
    names = self.class.emitted[:properties] + Contract::SUPPORTED_WHEN_SET
    unknown = names.uniq.reject { |name| SchemaRelease.term(name, release) }

    assert_empty unknown, <<~WHY.chomp
      Release #{release} has no such property: #{unknown.join(", ")}. An invented
      property is worse than an absent one — a strict JSON-LD processor drops it and
      a lenient one believes it, so the page reads as though it carried the claim
    WHY
  end

  def test_every_type_this_site_emits_is_a_real_class
    unknown = self.class.emitted[:types].reject { |name| SchemaRelease.term(name, release) }

    assert_empty unknown, <<~WHY.chomp
      Release #{release} has no such type: #{unknown.join(", ")}. A node typed with a
      class the vocabulary does not define carries no meaning at all, however well
      formed its keys are
    WHY
  end

  def test_the_nutrition_property_list_is_unchanged
    published = SchemaRelease.properties_of("NutritionInformation", release)

    assert_equal Vocabulary::NUTRITION_PROPERTIES.sort, published, <<~WHY.chomp
      NutritionInformation's properties have changed in release #{release}. Every
      recipe here states all twelve, and the checks assert all twelve are present —
      so a property added upstream means every recipe is now incomplete, and one
      removed means every recipe emits something dead. Update
      Vocabulary::NUTRITION_PROPERTIES, the layout, and every recipe together
    WHY
  end

  def test_every_diet_value_is_still_a_restricted_diet
    published = SchemaRelease.enumeration_members("RestrictedDiet", release)

    assert_equal Vocabulary::RESTRICTED_DIETS.sort, published, <<~WHY.chomp
      RestrictedDiet's members have changed in release #{release}. A value outside the
      enumeration is silently meaningless in suitableForDiet: the consumer ignores a
      term it does not know, so the recipe claims less than the page says it does.
      Update Vocabulary::RESTRICTED_DIETS, and check what each recipe claims
    WHY
  end

  # Not one of the three questions above, but the reason they can be asked at
  # all. The lists in Vocabulary and the tables in CLAUDE.md both carry "checked
  # against release 30.0" as a claim about a moment in time. When a newer release
  # lands the checks above have already re-verified the substance against it —
  # what is left is a recorded number that is now wrong, and nothing else in the
  # repository would ever say so.
  def test_the_release_the_constants_were_checked_against_is_still_current
    assert_equal Vocabulary::CHECKED_RELEASE, release, <<~WHY.chomp
      schema.org has published release #{release}; this repository records
      #{Vocabulary::CHECKED_RELEASE}. The other checks in this file have already run
      against #{release}, so if they passed, the substance is fine and this is
      bookkeeping: set Vocabulary::CHECKED_RELEASE to #{release} and update the
      "checked against release" lines in CLAUDE.md. If they failed, fix those first
    WHY
  end
end
