# Security policy

This is a static site. There is no server we run, no database, no login, no
form that accepts input, and no request to any third party — icons are inlined
SVG and there are no CDN scripts, webfonts or stylesheets. GitHub Pages serves
files that GitHub built from this repository.

That makes the attack surface small, and this document is short because of it
rather than in spite of it.

## Reporting

**Please do not open a public issue.** A public issue discloses the problem
before it can be fixed.

Use GitHub's private report form instead:

**<https://github.com/digvijaygunjal/digvijaygunjal.github.io/security/advisories/new>**

It is visible only to the maintainers of this repository. It is also reachable
from the **Security** tab, under *Advisories → Report a vulnerability*, and it
is linked from the new-issue page so it is hard to miss.

Useful in a report: the URL or file, what an attacker could do, and how to
reproduce it. A proof of concept is welcome but not required.

## What we will do

Two people maintain this in their own time, so no response time is promised
here — an invented service level would be worse than an honest silence.

What you can expect: an acknowledgement when one of us next picks up the
repository, a decision on whether it is in scope, and — if it is — a fix and a
note in the advisory saying what changed. If you would like credit, say so and
you will get it.

## In scope

- The built site at <https://digvijaygunjal.github.io> — anything served from
  it that can harm a visitor. Injected script in a page, a redirect somewhere
  unintended, a supply-chain problem reaching the built output.
- The contents of this repository. Most usefully: a committed secret, or a
  recipe photograph that still carries EXIF GPS coordinates. Both are handled
  as security reports even though neither is a vulnerability in the usual
  sense, because both disclose something that cannot be undone by deleting the
  file — git keeps every version.
- The build: `_config.yml`, the layouts, and the gem dependencies pinned by
  `Gemfile.lock`.

## Not in scope

- **There is no backend, no user data and no authentication.** Reports about
  authentication bypass, SQL injection, session handling or account takeover do
  not apply, because none of those things exists here.
- Vulnerabilities in GitHub Pages itself, or in GitHub. Report those to
  <https://bounty.github.com>.
- Missing security headers on GitHub Pages. We do not control the response
  headers Pages sends, and a static page with no cookies, no forms and no
  scripts of consequence is not made safe or unsafe by them.
- Findings from an automated scanner pasted without a reachable path to harm.

## Dependencies

The gem tree is pinned by `Gemfile.lock`, and Dependabot security updates are
enabled for the repository. A known vulnerability in a pinned gem does not
generally need a report — it will already have opened one — but a note is
welcome if it looks like it has been missed.

## Code of conduct reports

The [Code of Conduct](CODE_OF_CONDUCT.md) uses the same private form, for the
same reason: it is the only private channel this project has. Put "code of
conduct" in the title so it is not read as a vulnerability report.
