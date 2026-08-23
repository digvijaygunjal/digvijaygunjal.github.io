# frozen_string_literal: true

require "rake/testtask"

# The test pyramid, tier by tier. Tier 1 needs no build and runs in
# milliseconds; the slower tiers are added by their own issues and hang off the
# same `default` task, so one command stays the whole story.
namespace :test do
  desc "Tier 1 — data and front matter, straight from the sources, no build"
  Rake::TestTask.new(:tier1) do |t|
    t.libs << "test"
    t.test_files = FileList["test/tier1/**/*_test.rb"]
    t.warning = false
  end
end

desc "Run every tier, fastest first, stopping at the first that fails"
task default: %w[test:tier1]
