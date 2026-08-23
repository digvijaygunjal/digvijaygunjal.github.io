# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/asset_case"

# Asset hygiene. Simple checks, worth automating anyway, because unlike every
# other rule in this suite these fail *permanently*: a bad binary stays in the
# history of every clone that has ever been made.
class AssetsTest < AssetTest
  # Roughly what a 1600 px wide photo weighs once it has been recompressed for
  # the web. Anything much past this is a phone photo that skipped that step.
  MAX_BYTES = 500 * 1024

  # The hero crops to 4:3 and index thumbnails to 1:1, and no layout here uses
  # more than about 1600 px. Beyond this the extra pixels are bytes every
  # visitor downloads and nobody sees.
  MAX_WIDTH = 2000

  rule "is_a_format_the_checks_understand" do |image|
    refute_equal :unknown, image.format,
                 "#{image.name}: this checker cannot read #{File.extname(image.path)} files, so " \
                 "it can say nothing about their size, dimensions or metadata. Teach " \
                 "test/support/image_file.rb the format before committing one"
  end

  rule "is_small_enough_to_commit" do |image|
    assert_operator image.bytes, :<=, MAX_BYTES,
                    "#{image.name} is #{(image.bytes / 1024.0).round} KB, over the " \
                    "#{MAX_BYTES / 1024} KB limit. Resize to about 1600 px wide and " \
                    "recompress. This one cannot be fixed after the fact: the blob stays in " \
                    "the history of every clone even if the file is deleted later"
  end

  rule "is_not_wider_than_any_layout_uses" do |image|
    skip "#{image.name} is a format with no fixed pixel size" if image.format == :svg
    width = image.width

    refute_nil width, "#{image.name}: could not read the image dimensions"
    assert_operator width, :<=, MAX_WIDTH,
                    "#{image.name} is #{width} px wide, over the #{MAX_WIDTH} px limit. " \
                    "Nothing on the site renders it larger than about 1600 px, so the rest " \
                    "is bytes every visitor downloads and nobody sees"
  end

  rule "carries_no_camera_metadata" do |image|
    refute image.exif?,
           "#{image.name} still carries its EXIF block#{image.gps? ? ", including GPS coordinates" : ""}. " \
           "This repository is public, and a phone photo records where it was taken — " \
           "which for a recipe photo is somebody's kitchen. Strip the metadata while " \
           "resizing; once the file is pushed, deleting it does not remove it from history"
  end
end

# Orphans are housekeeping rather than a hazard, so this is one test over the
# whole directory rather than one per file.
class OrphanedImagesTest < Minitest::Test
  def test_every_recipe_image_is_used_by_a_recipe
    referenced = Site.referenced_images.map { |path| File.basename(path) }
    on_disk = Site.image_files
                  .select { |path| File.dirname(path).end_with?("images/recipes") }
                  .map { |path| File.basename(path) }

    assert_empty on_disk - referenced,
                 "these images are in assets/images/recipes/ but no recipe points at them, " \
                 "which is usually what a rename leaves behind. Deleting them does not shrink " \
                 "the clone — the blobs are already in history — but it does stop the next " \
                 "person wondering which photo is the current one"
  end
end
