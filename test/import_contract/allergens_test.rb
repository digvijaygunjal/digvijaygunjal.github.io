# frozen_string_literal: true

require_relative "test_helper"

# schema.org has no allergen property and Google's recipe rich result consumes
# none, so allergens reach a reader through the visible page — which is also
# what an AI-assisted importer reads. That makes the rendered lists the only
# place this can be checked, and the arithmetic is the thing worth checking:
# the layout derives "free from" by subtraction, so a declaration that fails to
# resolve does not go missing, it changes sides.
class AllergensTest < BuiltPageTest
  def section(page)
    page.doc.at_css("section.allergens")
  end

  # The labels under one of the two declared headings.
  def declared(page, heading)
    head = page.doc.at_css("p.allergen-head-#{heading}")
    return [] if head.nil?

    list = head.next_element
    return [] unless list && list.matches?("ul.allergen-list")

    list.css("li > b").map { |node| node.text.strip }
  end

  def free_from(page)
    page.doc.css("details.allergen-free li").map do |item|
      item.css("span.allergen-us").each(&:remove)
      item.text.strip
    end
  end

  def ids_for(labels)
    by_label = Site.allergens.to_h { |entry| [entry["label"], entry["id"]] }
    labels.map { |label| by_label[label] }
  end

  rule "the_page_shows_an_allergen_panel" do |page|
    refute_nil section(page),
               "#{page.name}: no allergen panel. 'Can I eat this' is asked before the " \
               "ingredient list is read, and the panel is the only answer on the page"
  end

  rule "every_rendered_allergen_is_one_of_the_fourteen" do |page|
    labels = declared(page, "in") + declared(page, "may") + free_from(page)
    unknown = labels.zip(ids_for(labels)).select { |_, id| id.nil? }.map(&:first)

    assert_empty unknown,
                 "#{page.name}: #{unknown.inspect} is printed on the page but is not a label " \
                 "in _data/allergens.yml, so the page and the data file have drifted apart"
  end

  rule "the_three_lists_account_for_all_fourteen" do |page|
    ids = %w[in may].flat_map { |heading| ids_for(declared(page, heading)) } + ids_for(free_from(page))

    assert_equal Site.allergen_ids.sort, ids.compact.sort,
                 "#{page.name}: contains + may contain + free from must be exactly the " \
                 "fourteen, once each. Anything else means the subtraction the layout does " \
                 "has lost or duplicated an allergen — and the direction that fails silently " \
                 "is the one that moves an allergen into 'free from'"
  end

  rule "no_allergen_appears_in_two_lists" do |page|
    contains = ids_for(declared(page, "in"))
    may = ids_for(declared(page, "may"))
    free = ids_for(free_from(page))
    overlaps = (contains & may) + (contains & free) + (may & free)

    assert_empty overlaps.compact,
                 "#{page.name}: #{overlaps.compact.join(", ")} is in two lists at once, so " \
                 "the page gives two answers to the one question it exists to answer"
  end

  rule "the_rendered_lists_are_what_the_recipe_declared" do |page|
    { "in" => "present", "may" => "may_contain" }.each do |heading, key|
      source = Array((page.recipe["allergens"] || {})[key]).map { |entry| entry["id"] }

      assert_equal source, ids_for(declared(page, heading)),
                   "#{page.name}: the '#{key}' list in the front matter and the one on the " \
                   "page differ. An id that does not resolve is dropped from the visible " \
                   "list in silence and then subtracted into 'free from'"
    end
  end
end
