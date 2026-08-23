#!/bin/bash
#
# Installs the gems, so a session's first command can be `bundle exec rake`.
#
# A web session starts from a fresh clone with nothing installed, so without
# this its first few minutes go on setup before it can build or test anything.
# Front-loading that here means the suite — which is what a session wants most
# often — is ready when the session is.
#
# Deliberately gems only. The browser checks need Node and a Chromium download,
# which is by far the slowest thing in this repository; the Rakefile installs
# that toolchain on demand the first time `rake test:browser` asks for it, and
# paying for it at the start of every session that never runs a browser check
# would cost more than it saves.
set -euo pipefail

# Local sessions have a working tree the contributor already set up, and running
# bundler on every session start would be latency for nothing. This is for the
# ephemeral remote container.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

# The same two commands README and CONTRIBUTING tell a human to run, in the same
# order, so a session and a contributor end up with the same tree. `path` writes
# to .bundle/config, which is gitignored, so this leaves nothing behind.
bundle config set path 'vendor/bundle'
bundle install
