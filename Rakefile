# frozen_string_literal: true

require "rake/testtask"

BROWSER_DIR = File.join(__dir__, "test", "browser")

# One command, and the one CI is to invoke as well (#18). If CI kept a list of
# steps of its own, "passes locally" and "passes in CI" would drift apart, and
# the drift is only ever discovered on a red pull request.
#
# The sets are named for what they read rather than for how fast they are, and
# they run cheapest first: `sources` reads the recipe files as written and
# needs no build, so a typo fails in under a second instead of after a browser
# has started. `import_contract` builds the site and reads what Jekyll made of
# them — the one rule this site has, that every recipe page stays importable by
# URL, is defended there. `browser` opens the built site in Chromium, which is
# the only place a question about what a page *fetches* or what a script
# *renders* can be answered.
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
    install_browser_toolchain

    # Built here rather than left to Playwright: the specs read the list of
    # pages off _site before the browser starts.
    sh "bundle exec jekyll build"
    sh "npm test --prefix #{BROWSER_DIR}"
  end
end

desc "Run every check, cheapest first, stopping at the first that fails"
task default: %w[test:sources test:import_contract test:browser]

# Installed on demand so that a clean clone needs one command and not three.
# Nothing here touches the site's own dependencies: Node lives entirely under
# test/browser, and the two sets before this one never load it.
def install_browser_toolchain
  return if File.directory?(File.join(BROWSER_DIR, "node_modules"))

  unless system("npm --version", out: File::NULL, err: File::NULL)
    abort <<~NO_NODE
      The browser checks need Node, which is not on PATH.

      Install Node, or run the two Ruby sets on their own:

        bundle exec rake test:sources test:import_contract

      They cover everything except what only a browser can see — whether an
      image really loaded, what the page fetches, and whether the filters and
      the copy-link button behave. CI runs all three regardless.
    NO_NODE
  end

  puts "Installing the browser toolchain (once) into test/browser and the Playwright cache..."
  sh "npm ci --prefix #{BROWSER_DIR}"
  sh "npm run setup --prefix #{BROWSER_DIR}"
end
