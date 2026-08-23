# frozen_string_literal: true

# A markdown file, read for two things: the headings other documents can point
# at, and the links it points with.
#
# Anchors are the one kind of cross-reference that breaks in total silence.
# Rename a heading and every link to it still resolves — to the top of the
# page. Nothing errors, nothing 404s, and the reader lands somewhere plausible
# and slightly wrong.
class MarkdownDoc
  ROOT = File.expand_path("../..", __dir__)

  # A markdown link whose target is not an absolute URL and not a mailto:.
  LINK = /\[(?:[^\]]*)\]\(([^)\s]+)(?:\s+"[^"]*")?\)/
  ABSOLUTE = %r{\A(?:[a-z][a-z0-9+.-]*:|//|\#\z)}i
  FENCE = /\A\s*(?:```|~~~)/

  Link = Struct.new(:doc, :line, :target) do
    def file
      target.split("#", 2).first.to_s
    end

    def anchor
      target.split("#", 2)[1]
    end

    def anchor?
      !anchor.nil? && anchor != ""
    end

    def where
      "#{doc.name}:#{line}"
    end
  end

  attr_reader :path

  def self.all
    Dir[File.join(ROOT, "*.md"), File.join(ROOT, ".github", "**", "*.md")].sort.map { |path| new(path) }
  end

  def initialize(path)
    @path = path
  end

  def name
    path.sub("#{ROOT}/", "")
  end

  def source
    @source ||= File.read(path, encoding: "UTF-8")
  end

  # The slugs GitHub gives this document's headings, in order.
  #
  # Headings inside a fenced code block are not headings — several files here
  # open a fence and then a shell comment, and counting those as headings would
  # invent anchors that do not exist.
  def slugs
    @slugs ||= begin
      seen = Hash.new(0)
      outside_fences do |line|
        next unless line.match?(/\A\#{1,6}\s+\S/)

        slug = slugify(line.sub(/\A\#+\s+/, "").strip)
        next if slug.empty?

        count = seen[slug]
        seen[slug] += 1
        count.zero? ? slug : "#{slug}-#{count}"
      end.compact
    end
  end

  def links
    @links ||= begin
      found = []
      number = 0
      outside_fences do |line|
        number += 1
        line.scan(LINK) do |(target)|
          found << Link.new(self, number, target) unless target.match?(ABSOLUTE)
        end
        nil
      end
      found
    end
  end

  # GitHub's rule: lowercase, drop anything that is not a letter, digit, space,
  # hyphen or underscore, then replace runs of spaces with hyphens. Markdown
  # formatting inside a heading is removed first, since it is not rendered.
  def slugify(heading)
    heading
      .gsub(/`([^`]*)`/, '\1')
      .gsub(/\[([^\]]*)\]\([^)]*\)/, '\1')
      .gsub(/[*_]{1,3}([^*_]*)[*_]{1,3}/, '\1')
      .downcase
      .gsub(/[^\p{Word}\- ]/u, "")
      .tr(" ", "-")
  end

  private

  # Yields each line that is not inside a fenced code block, collecting
  # whatever the block returns. Line numbers stay true to the file: fenced
  # lines are yielded as blanks rather than skipped.
  def outside_fences
    fenced = false
    source.lines.map do |line|
      if line.match?(FENCE)
        fenced = !fenced
        next yield("")
      end

      yield(fenced ? "" : line)
    end
  end
end
