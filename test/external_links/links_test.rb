# frozen_string_literal: true

require "html-proofer"

require_relative "test_helper"

# The links that point away from this site.
#
# Deliberately not part of `rake default`, and deliberately not on a pull
# request. Whether a manufacturer's product page is up this minute is not a fact
# about this repository, and a red check a contributor cannot fix teaches
# everyone to ignore red checks. Internal links stay in tier 2, where they are
# fast and deterministic.
#
# Weekly and advisory, it is worth having: it keeps the appliance product URL,
# the Amazon link and the maintainers' profiles in `_config.yml` honest. Those
# are exactly the links that rot unnoticed, because nobody clicks their own
# footer.
class ExternalLinksTest < Minitest::Test
  # Codes that mean "a robot asked", not "this link is dead".
  #
  # Instagram, LinkedIn and X serve 403 — and X has been known to serve 999 — to
  # any client that is not a browser, whatever the URL. Amazon does the same
  # under load. Reporting those every week would make this check's output
  # something nobody opens, which costs more than the coverage is worth.
  #
  # Real link rot does not look like this. A page that has gone away answers
  # 404 or 410, and a host that has gone away fails to resolve or to connect —
  # none of which is on this list, and all of which still fail here.
  DECLINED_BY_ROBOT_POLICY = [403, 429, 503, 999].freeze

  def proofer
    @proofer ||= begin
      BuiltSite.build_succeeded?
      runner = HTMLProofer.check_directory(
        BuiltSite::DESTINATION,
        disable_external: false,
        checks: %w[Links],
        # A link that is merely http:// is a judgement call about someone else's
        # site, not a broken link, and this check is only about reachability.
        enforce_https: false,
        # An anchor on someone else's page is theirs to rename, and they will,
        # without it meaning the link stopped working.
        check_external_hash: false,
        ignore_status_codes: DECLINED_BY_ROBOT_POLICY,
        # Politeness, and self-interest: fifty parallel requests is how a host
        # decides this is worth rate-limiting.
        hydra: { max_concurrency: 5 },
        typhoeus: { followlocation: true, connecttimeout: 15, timeout: 45 },
        log_level: :error
      )
      begin
        runner.run
      # SystemExit, not just StandardError: html-proofer reports a failure by
      # calling exit(1), which is not a StandardError and would otherwise take
      # the whole run down before minitest could say which link was broken.
      rescue SystemExit, StandardError # the failures are on the runner
        nil
      end
      runner
    end
  end

  def test_every_link_that_points_away_from_this_site_still_resolves
    failures = proofer.failed_checks.map do |failure|
      "#{failure.path}#{failure.line ? ":#{failure.line}" : ""} — #{failure.description}"
    end

    assert_empty failures,
                 "#{failures.length} outbound link(s) did not resolve:\n#{failures.join("\n")}"
  end

  # The same trap as in tier 2, and worse here: a run that reached no host at
  # all reports exactly like a run where every link was fine. Behind a proxy
  # that refuses CONNECT, that is the likely outcome.
  def test_the_check_actually_looked_at_some_external_links
    refute_empty proofer.external_urls,
                 "no outbound links were found in the built site at all, which means this " \
                 "check parsed nothing rather than that every link is healthy"
  end
end
