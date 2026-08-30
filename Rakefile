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
  desc "The recipe sources as written: front matter, allergens, durations, assets, plain words"
  Rake::TestTask.new(:sources) do |t|
    t.libs << "test"
    t.test_files = FileList["test/sources/**/*_test.rb"]
    t.warning = false
  end

  desc "The built _site: JSON-LD shape, step anchors, allergen arithmetic, links, plain words"
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

# Not part of the default task: this reads a clone of the schema.org vocabulary,
# which a contributor has no reason to have, and which is the point — the
# website is not always reachable from a sandbox or from behind a proxy, and an
# unreachable specification is what tempts someone into guessing at a property
# name. Run on a schedule by .github/workflows/schema-drift.yml.
namespace :schema do
  desc "Whether schema.org still says what this site assumes it says (needs SCHEMAORG_CLONE)"
  Rake::TestTask.new(:drift) do |t|
    t.libs << "test"
    t.test_files = FileList["test/schema_drift/**/*_test.rb"]
    t.warning = false
  end

  # Guarding here rather than inside the checks: a missing clone means the run
  # verified nothing, and a set of checks that skip themselves when their input
  # is absent reports green for exactly the reason it should report red.
  task :drift => :verify_schemaorg_clone

  task :verify_schemaorg_clone do
    require_relative "test/support/schema_release"

    next if SchemaRelease.available?

    abort <<~NO_CLONE
      No schema.org clone found at #{SchemaRelease.clone_path}.

      Clone it, or point SCHEMAORG_CLONE at an existing clone:

        git clone --depth 1 --filter=blob:none --no-checkout \\
          https://github.com/schemaorg/schemaorg schemaorg
        git -C schemaorg sparse-checkout init --no-cone
        git -C schemaorg sparse-checkout set \\
          '/data/releases/*/schemaorg-current-https.jsonld'
        git -C schemaorg checkout

      The narrow pattern matters: checking out all of data/releases is 2 GB of
      history this check never opens, against 43 MB for the release files alone.

      Read the vocabulary from the clone rather than from schema.org: the
      website is not always reachable from a sandbox or from behind a proxy,
      and the release file is the source the website is published from.
    NO_CLONE
  end
end

# Not part of the default task either, and for a different reason from
# schema:drift: this one reads the internet. Rate limits, transient 503s and
# hosts that block CI ranges all produce failures that have nothing to do with
# the change under review, and a red check a contributor cannot fix teaches
# everyone to ignore red checks. Internal links stay in test:import_contract,
# where they are fast and deterministic. Run weekly by
# .github/workflows/external-links.yml.
namespace :links do
  desc "Whether the links pointing away from this site still resolve (reads the internet)"
  Rake::TestTask.new(:external) do |t|
    t.libs << "test"
    t.test_files = FileList["test/external_links/**/*_test.rb"]
    t.warning = false
  end
end
