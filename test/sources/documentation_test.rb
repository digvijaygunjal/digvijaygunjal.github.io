# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/markdown_doc"

# The documents link into each other by anchor — README.md#the-import-contract,
# #step-fields, #images — and CLAUDE.md requires all three to stay in
# agreement, so the number of these links only grows.
#
# A renamed heading does not break such a link loudly. The browser lands at the
# top of the file, the reader assumes that is where they were sent, and the
# sentence that was meant to justify the rule is never read.
class DocumentationTest < Minitest::Test
  DOCS = MarkdownDoc.all

  def test_there_are_documents_to_check
    refute_empty DOCS, "no markdown files found, so every rule below would pass vacuously"
  end

  def test_every_document_has_headings_to_link_to
    empty = DOCS.reject { |doc| doc.slugs.any? }.map(&:name)

    # A file with no headings is fine in itself; what it would mean here is
    # that the heading parser stopped working, which would make every anchor
    # rule below pass for the wrong reason.
    assert_operator DOCS.length - empty.length, :>, 1,
                    "fewer than two documents have any headings at all, which is a broken " \
                    "parser rather than a documentation style"
  end

  DOCS.each do |doc|
    define_method(:"test_#{doc.name.gsub(/[^a-zA-Z0-9]+/, "_")}__links_to_files_that_exist") do
      missing = doc.links.reject { |link| link.file.empty? }.reject do |link|
        File.exist?(File.expand_path(link.file, File.dirname(doc.path)))
      end

      assert_empty missing.map { |link| "#{link.where} -> #{link.target}" },
                   "#{doc.name} links to a file that is not there. A relative link to a " \
                   "moved file 404s for a reader on GitHub and silently resolves to nothing " \
                   "for anyone reading the repository locally"
    end

    define_method(:"test_#{doc.name.gsub(/[^a-zA-Z0-9]+/, "_")}__anchors_resolve") do
      dangling = doc.links.select(&:anchor?).reject do |link|
        target = if link.file.empty?
                   doc
                 else
                   DOCS.find { |other| other.path == File.expand_path(link.file, File.dirname(doc.path)) }
                 end
        target && target.slugs.include?(link.anchor)
      end

      assert_empty dangling.map { |link| "#{link.where} -> #{link.target}" },
                   "#{doc.name} points at a heading that does not exist. Markdown anchors do " \
                   "not error: the reader is sent to the top of the file instead, and never " \
                   "learns they missed the paragraph the link was for"
    end
  end
end
