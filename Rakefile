# frozen_string_literal: true

require "rake/testtask"

# The checks, named for what they read rather than for how fast they are.
#
# `sources` reads the recipe files as written and needs no build, so it runs in
# milliseconds and fails a typo before anything slower starts. `import_contract`
# reads what Jekyll makes of them, which is where the one rule this site has —
# every recipe page stays importable by URL — is actually defended.
namespace :test do
  desc "The recipe sources as written: front matter, allergens, durations, assets"
  Rake::TestTask.new(:sources) do |t|
    t.libs << "test"
    t.test_files = FileList["test/sources/**/*_test.rb"]
    t.warning = false
  end
end

desc "Run every check, cheapest first, stopping at the first that fails"
task default: %w[test:sources]
