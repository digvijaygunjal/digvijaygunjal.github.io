# frozen_string_literal: true

require_relative "../test_helper"

# Every step becomes a HowToStep, read by an importer away from the page and in
# isolation from its neighbours. That is why a step that continues an appliance
# session has to restate it, and why the layout prepends that context — which
# in turn is why the text of such a step starts mid-sentence.
class StepsTest < RecipeSourceTest
  rule "steps_are_a_non_empty_list_of_mappings" do |recipe|
    skip_without(recipe, "steps")

    steps = recipe["steps"]

    assert_kind_of Array, steps, "#{recipe.name}: `steps` is a list"
    refute_empty steps, "#{recipe.name}: a recipe with no steps is not a recipe"
    assert_empty steps.reject { |step| step.is_a?(Hash) },
                 "#{recipe.name}: every step is a mapping, never a bare string — a bare " \
                 "string cannot carry the name and the appliance context a HowToStep needs"
  end

  rule "every_step_has_a_name_and_text" do |recipe|
    skip_without(recipe, "steps")

    incomplete = Array(recipe["steps"]).each_with_index.reject do |step, _index|
      step.is_a?(Hash) && Contract::STEP_REQUIRED_KEYS.all? { |key| step[key].to_s.strip != "" }
    end

    assert_empty incomplete.map { |_step, index| "step #{index + 1}" },
                 "#{recipe.name}: every step needs both `name` and `text`. The name is the " \
                 "HowToStep's name and the anchor a reader is sent to; the text is the " \
                 "instruction"
  end

  rule "steps_use_only_keys_the_layout_reads" do |recipe|
    skip_without(recipe, "steps")

    unknown = Array(recipe["steps"]).grep(Hash).each_with_index.filter_map do |step, index|
      extra = step.keys - Contract::STEP_KEYS
      "step #{index + 1}: #{extra.join(", ")}" unless extra.empty?
    end

    assert_empty unknown,
                 "#{recipe.name}: these step keys are not read by the layout, so they are " \
                 "dropped in silence while the page still looks finished — #{unknown.join("; ")}. " \
                 "Known keys: #{Contract::STEP_KEYS.join(", ")}"
  end

  rule "continuing_steps_read_as_a_continuation" do |recipe|
    skip_without(recipe, "steps")

    capitalised = Array(recipe["steps"]).grep(Hash).each_with_index.filter_map do |step, index|
      next unless step["continues"] == true

      first = step["text"].to_s.strip[0]
      "step #{index + 1}" if first && first == first.upcase && first.match?(/[[:alpha:]]/)
    end

    assert_empty capitalised,
                 "#{recipe.name}: #{capitalised.join(", ")} sets `continues: true`, so the " \
                 "layout prepends 'With the pot still on <appliance>, ' — the text has to " \
                 "start lowercase and mid-sentence or the rendered instruction reads wrong"
  end

  rule "continuing_steps_name_the_session_they_continue" do |recipe|
    skip_without(recipe, "steps")

    unnamed = Array(recipe["steps"]).grep(Hash).each_with_index.filter_map do |step, index|
      "step #{index + 1}" if step["continues"] == true && step["appliance"].to_s.strip == ""
    end

    assert_empty unnamed,
                 "#{recipe.name}: #{unnamed.join(", ")} continues a session without naming " \
                 "the appliance, so the layout renders 'With the pot still on , '. An " \
                 "importer reads each step in isolation and has no previous step to borrow"
  end

  rule "settings_and_durations_belong_to_an_appliance" do |recipe|
    skip_without(recipe, "steps")

    orphaned = Array(recipe["steps"]).grep(Hash).each_with_index.filter_map do |step, index|
      next if step["appliance"].to_s.strip != ""

      extra = %w[setting duration].select { |key| step[key].to_s.strip != "" }
      "step #{index + 1}: #{extra.join(" and ")}" unless extra.empty?
    end

    assert_empty orphaned,
                 "#{recipe.name}: #{orphaned.join("; ")} — the layout prints the setting and " \
                 "the duration only as part of the appliance line, so without `appliance` " \
                 "they never reach the page"
  end
end
