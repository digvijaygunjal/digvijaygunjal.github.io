# frozen_string_literal: true

require_relative "test_helper"

# The method as an importer receives it: a list of HowToStep objects, read away
# from the page and each one in isolation from its neighbours. Rules 2, 3 and 5
# of the import contract all live here, and all three fail silently.
class StepsTest < BuiltPageTest
  rule "every_step_is_a_how_to_step_object" do |page|
    steps = page.recipe_json["recipeInstructions"]

    assert_kind_of Array, steps, "#{page.name}: recipeInstructions is a list of steps"
    bare = steps.reject { |step| step.is_a?(Hash) && step["@type"] == "HowToStep" }

    assert_empty bare,
                 "#{page.name}: a bare string in recipeInstructions carries no name and no " \
                 "anchor, so an importer gets a wall of text instead of a numbered method"
  end

  rule "every_step_carries_a_name_and_text" do |page|
    incomplete = Array(page.recipe_json["recipeInstructions"]).grep(Hash).each_with_index.filter_map do |step, index|
      "step #{index + 1}" unless step["name"].to_s.strip != "" && step["text"].to_s.strip != ""
    end

    assert_empty incomplete,
                 "#{page.name}: #{incomplete.join(", ")} is missing a name or its text. Both " \
                 "are required: the name is what an appliance app shows on its screen, the " \
                 "text is what it reads out"
  end

  rule "the_method_is_emitted_once_and_whole" do |page|
    assert_equal Array(page.recipe["steps"]).length,
                 Array(page.recipe_json["recipeInstructions"]).length,
                 "#{page.name}: the built method has a different number of steps from the " \
                 "front matter it came from"
  end

  rule "continuing_steps_restate_their_appliance_session" do |page|
    emitted = Array(page.recipe_json["recipeInstructions"])
    silent = Array(page.recipe["steps"]).each_with_index.filter_map do |step, index|
      next unless step.is_a?(Hash) && step["continues"] == true

      text = emitted.dig(index, "text").to_s
      "step #{index + 1}" unless text.include?(step["appliance"].to_s)
    end

    assert_empty silent,
                 "#{page.name}: #{silent.join(", ")} continues an appliance session that its " \
                 "own text never names. An importer reads each step alone, with no previous " \
                 "step to carry the setting over from, so the cook is left guessing which " \
                 "button is still on"
  end

  rule "every_step_url_resolves_to_an_anchor_on_the_page" do |page|
    ids = page.doc.css("[id]").map { |node| node["id"] }
    dangling = Array(page.recipe_json["recipeInstructions"]).grep(Hash).filter_map do |step|
      fragment = URI(step["url"].to_s).fragment
      step["url"] if fragment.nil? || !ids.include?(fragment)
    end

    assert_empty dangling,
                 "#{page.name}: #{dangling.inspect} points at no element on the page. A step " \
                 "URL is how an app sends a cook back to the step they were on"
  end

  rule "every_step_anchor_is_pointed_at" do |page|
    referenced = Array(page.recipe_json["recipeInstructions"]).grep(Hash).filter_map do |step|
      URI(step["url"].to_s).fragment
    end
    rendered = page.doc.css("ol.steps > li[id]").map { |node| node["id"] }

    assert_empty rendered - referenced,
                 "#{page.name}: #{(rendered - referenced).inspect} is a step anchor no step " \
                 "in the JSON-LD points at, so the page and the structured data disagree " \
                 "about how many steps there are"
  end

  rule "the_page_renders_one_list_item_per_step" do |page|
    rendered = page.doc.css("ol.steps > li[id]").map { |node| node["id"] }

    assert_equal Array(page.recipe["steps"]).length, rendered.length,
                 "#{page.name}: the visible method and the front matter disagree on the " \
                 "number of steps"
  end
end
