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
# minitest is pinned to the 5.x that Ruby 3.3.4 itself ships as a bundled gem;
# the suite gains nothing from a major-version jump.
group :test do
  gem "minitest", "~> 5.20"
  gem "rake", "~> 13.1"
end
