# frozen_string_literal: true

require_relative "../test_helper"

# Whether the front matter was read at all, and whether it carries the keys the
# layout and the JSON-LD cannot do without.
class FrontMatterTest < RecipeSourceTest
  rule "is_readable_front_matter" do |recipe|
    assert recipe.front_matter?,
           "#{recipe.name} has no front matter Jekyll will read. The usual cause is a " \
           "missing closing `---`: the file still builds, and Jekyll auto-titles the " \
           "page from the filename, so it renders a plausible page out of no data at all"
  end

  rule "declares_every_required_key" do |recipe|
    skip_without_front_matter(recipe)

    missing = Contract::REQUIRED_KEYS.reject do |key|
      value = recipe[key]
      !value.nil? && value != "" && value != [] && value != {}
    end

    assert_empty missing,
                 "#{recipe.name} is missing required front matter: #{missing.join(", ")}. " \
                 "Each of these is read by the layout and emitted into the Recipe JSON-LD"
  end

  rule "is_dated" do |recipe|
    skip_without_front_matter(recipe)

    assert_kind_of Date, recipe["date"],
                   "#{recipe.name}: `date` must be a plain YYYY-MM-DD date — it becomes " \
                   "datePublished, dateCreated and copyrightYear"
  end

  rule "is_not_modified_before_it_was_published" do |recipe|
    skip_without(recipe, "updated")

    assert_kind_of Date, recipe["updated"],
                   "#{recipe.name}: `updated` must be a plain YYYY-MM-DD date"
    assert_operator recipe["updated"], :>=, recipe["date"],
                    "#{recipe.name}: `updated` (dateModified) is earlier than `date` " \
                    "(datePublished)"
  end

  rule "keywords_are_a_list_of_plain_strings" do |recipe|
    skip_without(recipe, "keywords")

    keywords = recipe["keywords"]

    assert_kind_of Array, keywords,
                   "#{recipe.name}: `keywords` is a list in front matter; the layout joins " \
                   "it into the single string schema.org expects"
    assert_empty keywords.reject { |word| word.is_a?(String) && !word.strip.empty? },
                 "#{recipe.name}: every keyword is a non-empty string"
  end

  rule "keywords_contain_no_commas" do |recipe|
    skip_without(recipe, "keywords")

    offenders = Array(recipe["keywords"]).grep(String).select { |word| word.include?(",") }

    assert_empty offenders,
                 "#{recipe.name}: the layout joins keywords with ', ', so a comma inside " \
                 "one splits it into two on the way to a consumer: #{offenders.join(" | ")}"
  end
end
