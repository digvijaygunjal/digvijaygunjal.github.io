# frozen_string_literal: true

# The drift checks read two things and compare them: the built site, for what
# this repository actually emits, and a clone of schemaorg/schemaorg, for what
# the vocabulary currently says. They are not part of `rake default` — they need
# a clone that a contributor has no reason to have — so they load the same
# scaffolding the other sets do and add the release reader to it.
require_relative "../test_helper"
require_relative "../support/built_site"
require_relative "../support/schema_release"
