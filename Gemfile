source "https://rubygems.org"

gem "github-pages", group: :jekyll_plugins

group :jekyll_plugins do
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
end

gem "webrick", "~> 1.8"

# The test suite. Decided in issue #21: Ruby for tiers 1 and 2, so a
# contributor who can already build the site installs nothing new.
#
# minitest tracked the 5.x that Ruby 3.3.4 ships as a bundled gem (5.20.0), on
# the theory that matching it kept the toolchain conceptually smaller. That
# alignment was only ever cosmetic: Bundler installs whatever this file names
# into vendor/bundle and never uses Ruby's bundled copy, so the pin bought
# nothing at 6.x that it did not also cost at 5.x. Dependabot proposed 6.0 in
# PR #70; both Ruby tiers pass on it unchanged, and the suite touches none of
# the assertions 6.0 changed (assert_same with nil, assert_raises argument
# types, refute_predicate). 6.x adds drb and prism as transitive dependencies.
group :test do
  gem "minitest", "~> 6.0"
  gem "rake", "~> 13.1"

  # Tier 2, against the built _site: nokogiri parses the pages, html-proofer
  # walks the whole output for broken internal links, missing images and
  # missing alt text.
  gem "nokogiri"
  gem "html-proofer", "~> 5.0"
end
