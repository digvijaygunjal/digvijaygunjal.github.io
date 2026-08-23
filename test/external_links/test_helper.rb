# frozen_string_literal: true

# The external link check reads the built site and then the internet. It is not
# part of `rake default` and never gates a pull request — see links_test.rb for
# why — so it loads the same scaffolding the other sets do and adds nothing.
require_relative "../test_helper"
require_relative "../support/built_site"
