# frozen_string_literal: true

require "html-proofer"

require_relative "test_helper"

# html-proofer over the whole output, once. It is the cheapest way to catch the
# things a per-page assertion would otherwise have to be written for one at a
# time: an internal link that goes nowhere, an <img> pointing at a file that was
# renamed, an image with no alt text.
#
# External links are deliberately not checked. Whether a manufacturer's product
# page is up today is not a fact about this repository, and a suite that fails
# because someone else's site is down is a suite people learn to ignore.
class OutputTest < Minitest::Test
  def proofer
    @proofer ||= begin
      BuiltSite.build_succeeded?
      runner = HTMLProofer.check_directory(
        BuiltSite::DESTINATION,
        disable_external: true,
        checks: %w[Links Images Scripts],
        enforce_https: false,
        log_level: :error
      )
      begin
        runner.run
      rescue StandardError # nothing to report here; the failures are on the runner
        nil
      end
      runner
    end
  end

  def test_the_built_site_has_no_broken_links_or_undescribed_images
    failures = proofer.failed_checks.map do |failure|
      "#{failure.path}#{failure.line ? ":#{failure.line}" : ""} — #{failure.description}"
    end

    assert_empty failures,
                 "html-proofer found #{failures.length} problem(s) in the built site"
  end

  # A proofer that read nothing reports nothing, and reads exactly like a clean
  # run. It happens for real: with a US-ASCII default encoding the first em dash
  # in a recipe raises inside html-proofer's async workers, the exception is
  # swallowed, and the check passes having parsed no files at all.
  def test_html_proofer_actually_read_the_site
    on_disk = Dir.glob(File.join(BuiltSite::DESTINATION, "**", "*.html")).length

    assert_operator on_disk, :>, 0, "the build produced no HTML at all"
    assert_equal on_disk, proofer.files.length,
                 "html-proofer scanned #{proofer.files.length} of #{on_disk} built pages"
    refute_empty proofer.internal_urls,
                 "html-proofer found no internal links anywhere in the site, which means it " \
                 "parsed nothing rather than that the site has none"
  end
end
