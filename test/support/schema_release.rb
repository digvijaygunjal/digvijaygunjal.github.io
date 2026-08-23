# frozen_string_literal: true

require "json"

require_relative "site"

# The schema.org vocabulary, read from a clone of the repository it is published
# from rather than from the website.
#
# That is not a preference. A sandboxed session or a corporate proxy can be
# blocked from schema.org, and an unreachable specification is exactly what
# tempts someone into guessing at a property name — which is how an invented
# property ends up in the JSON-LD, dropped by a strict processor and believed by
# a lenient one. GitHub is usually reachable when the website is not, and
# `data/releases/<version>/schemaorg-current-https.jsonld` is the same source
# the website is published from.
module SchemaRelease
  class Unavailable < StandardError; end

  # Where the clone is expected. The workflow checks it out beside the site;
  # locally, point SCHEMAORG_CLONE at wherever you cloned it.
  def self.clone_path
    ENV["SCHEMAORG_CLONE"] || File.join(Site::ROOT, "schemaorg")
  end

  def self.available?
    Dir.exist?(File.join(clone_path, "data", "releases"))
  end

  # Release directories sort by version, not by string: without this, 9.0 wins
  # over 30.0 and the check quietly verifies a vocabulary five years stale.
  def self.releases
    dir = File.join(clone_path, "data", "releases")
    raise Unavailable, "no schema.org clone at #{clone_path}" unless Dir.exist?(dir)

    Dir.children(dir)
       .select { |name| name.match?(/\A\d+(?:\.\d+)*\z/) }
       .sort_by { |name| name.split(".").map(&:to_i) }
  end

  def self.latest_release
    releases.last or raise Unavailable, "the clone at #{clone_path} holds no releases"
  end

  # Every term in the release, indexed by its bare label. The file names terms
  # `schema:recipeIngredient`; everything this repository writes down is the
  # bare `recipeIngredient`, so the prefix is stripped once, here.
  def self.terms(release = latest_release)
    @terms ||= {}
    @terms[release] ||= begin
      path = File.join(clone_path, "data", "releases", release, "schemaorg-current-https.jsonld")
      raise Unavailable, "no vocabulary file at #{path}" unless File.file?(path)

      JSON.parse(File.read(path, encoding: Site::ENCODING))
          .fetch("@graph")
          .each_with_object({}) { |term, index| index[term["@id"].to_s.delete_prefix("schema:")] = term }
    end
  end

  def self.term(name, release = latest_release)
    terms(release)[name.to_s]
  end

  # The release file writes a single reference as an object and several as an
  # array of objects. `Array()` cannot be used to even the two out: given a Hash
  # it returns the key/value pairs, so a lone reference silently becomes
  # ["@id", "schema:episode"] and every read of it fails or, worse, does not.
  def self.refs(value)
    (value.is_a?(Array) ? value : [value]).compact.map { |ref| ref["@id"].to_s.delete_prefix("schema:") }
  end
  private_class_method :refs

  # schema.org retires a term by pointing it at its replacement rather than by
  # deleting it, so a superseded property keeps validating structurally while
  # consumers stop reading it. This is the only signal that happened.
  def self.superseded_by(name, release = latest_release)
    refs(term(name, release)&.dig("schema:supersededBy")).first
  end

  # Members of an enumeration are typed with the enumeration itself, so
  # RestrictedDiet's members are the terms whose @type is schema:RestrictedDiet.
  def self.enumeration_members(enumeration, release = latest_release)
    terms(release).values.select { |term|
      Array(term["@type"]).include?("schema:#{enumeration}")
    }.map { |term| term["rdfs:label"].to_s }.sort
  end

  # The properties a class is the domain of. schema.org spells this
  # `domainIncludes` and allows several, so a property may appear under more
  # than one class.
  def self.properties_of(klass, release = latest_release)
    terms(release).values.select { |term|
      refs(term["schema:domainIncludes"]).include?(klass)
    }.map { |term| term["rdfs:label"].to_s }.sort
  end
end
