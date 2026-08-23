# frozen_string_literal: true

require_relative "site"
require_relative "image_file"

# Base class for a rule that has to hold for every committed image, generating
# one test per file per rule so a failure names the file and the rule.
#
# These are cheap enough to sit with the source checks, and they are here for a
# reason the other rules are not: git keeps every version of a binary forever.
# A photo committed at 8 MB, or with the coordinates of the kitchen it was
# taken in, cannot be taken back by deleting it later — the only fix is
# rewriting history, which breaks every clone that already exists.
class AssetTest < Minitest::Test
  def self.rule(name, &block)
    Site.image_files.each do |path|
      slug = File.basename(path).gsub(/[^a-zA-Z0-9]+/, "_")
      define_method(:"test_#{slug}__#{name}") do
        instance_exec(ImageFile.new(path), &block)
      end
    end
  end
end
