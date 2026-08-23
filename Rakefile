# frozen_string_literal: true

require "rake/testtask"

# The checks, named for what they read rather than for how fast they are.
#
# `sources` reads the recipe files as written and needs no build, so it runs in
# milliseconds and fails a typo before anything slower starts.
# `import_contract` runs `jekyll build` once and reads what Jekyll made of
# them, which is where the one rule this site has — every recipe page stays
# importable by URL — is actually defended. `browser` opens the built site in
# Chromium, and is the only place a question about what a page *fetches* or
# what a script *renders* can be answered.
namespace :test do
  desc "The recipe sources as written: front matter, allergens, durations, assets"
  Rake::TestTask.new(:sources) do |t|
    t.libs << "test"
    t.test_files = FileList["test/sources/**/*_test.rb"]
    t.warning = false
  end

  desc "The built _site: JSON-LD shape, step anchors, allergen arithmetic, links"
  Rake::TestTask.new(:import_contract) do |t|
    t.libs << "test"
    t.test_files = FileList["test/import_contract/**/*_test.rb"]
    t.warning = false
  end

  desc "The site in Chromium: layout, images that load, filters, no third-party requests"
  task :browser do
    browser_dir = File.join(__dir__, "test", "browser")

    unless File.directory?(File.join(browser_dir, "node_modules"))
      abort <<~MISSING
        The browser checks need their own toolchain, which is not installed:

          npm install --prefix test/browser
          npx --prefix test/browser playwright install chromium

        Everything else in this suite is Ruby and needs none of it.
      MISSING
    end

    # Built here rather than left to Playwright: the specs read the list of
    # pages off _site before the browser starts.
    sh "bundle exec jekyll build"
    sh "npm test --prefix #{browser_dir}"
  end
end

desc "Run every check that needs no extra toolchain, cheapest first"
task default: %w[test:sources test:import_contract]
