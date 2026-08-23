# frozen_string_literal: true

require_relative "../test_helper"

# An image path that points at nothing is invisible on the page — a broken
# image still reports itself complete to a browser — and unresolvable in the
# JSON-LD, where `image` is the one field consumers treat as required.
class ImagesTest < RecipeSourceTest
  rule "hero_images_are_site_absolute_paths" do |recipe|
    skip_without(recipe, "image")

    paths = Array(recipe["image"])
    offenders = paths.reject { |path| path.is_a?(String) && path.start_with?("/") }

    assert_empty offenders,
                 "#{recipe.name}: write image paths from the site root — /assets/images/... " \
                 "The layout makes them absolute for the JSON-LD and relative for the " \
                 "<img> tag, and it can only do that from a rooted path: #{offenders.inspect}"
  end

  rule "hero_images_exist_on_disk" do |recipe|
    skip_without(recipe, "image")

    missing = Array(recipe["image"]).reject { |path| Site.asset?(path) }

    assert_empty missing,
                 "#{recipe.name}: #{missing.join(", ")} is not committed. The page renders " \
                 "an empty frame and the structured data carries a URL that 404s"
  end

  rule "step_images_exist_on_disk" do |recipe|
    skip_without(recipe, "steps")

    missing = Array(recipe["steps"]).grep(Hash).each_with_index.filter_map do |step, index|
      next if step["image"].nil?

      "step #{index + 1}: #{step["image"]}" unless Site.asset?(step["image"])
    end

    assert_empty missing,
                 "#{recipe.name}: #{missing.join("; ")} — a step image is emitted into its " \
                 "HowToStep, so a missing file breaks the import as well as the page"
  end

  rule "every_image_is_described" do |recipe|
    skip_without(recipe, "image")

    refute_empty recipe["image_alt"].to_s.strip,
                 "#{recipe.name}: `image_alt` is what a screen reader announces, and the " \
                 "only description of the photo anyone gets if it fails to load"
  end
end
