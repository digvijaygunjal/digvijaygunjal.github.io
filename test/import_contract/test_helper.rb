# frozen_string_literal: true

# The import-contract checks add the built site to what the source checks
# already load. Requiring this file is what triggers `jekyll build`, once per
# process, before any page is asked for.
require_relative "../test_helper"
require_relative "../support/built_site"
require_relative "../support/built_page_case"
