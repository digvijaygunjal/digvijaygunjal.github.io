# frozen_string_literal: true

# Vocabularies this repository does not own.
#
# Everything here is a fact about a published standard, not a choice this site
# made, so each constant carries the authority it came from and what to re-read
# when that authority publishes again. A value invented into one of these lists
# is worse than a missing one: a consumer silently ignores a term it does not
# know, so the recipe simply claims less than the page says it does.
module Vocabulary
  # The eleven members of schema.org's RestrictedDiet enumeration, checked
  # against release 30.0 of the vocabulary
  # (data/releases/30.0/schemaorg-current-https.jsonld in schemaorg/schemaorg).
  # Anything outside this set is silently meaningless in `suitableForDiet`.
  RESTRICTED_DIETS = %w[
    DiabeticDiet
    GlutenFreeDiet
    HalalDiet
    HinduDiet
    KosherDiet
    LowCalorieDiet
    LowFatDiet
    LowLactoseDiet
    LowSaltDiet
    VeganDiet
    VegetarianDiet
  ].freeze

  # The twelve properties of schema.org's NutritionInformation, same release.
  NUTRITION_PROPERTIES = %w[
    calories
    carbohydrateContent
    cholesterolContent
    fatContent
    fiberContent
    proteinContent
    saturatedFatContent
    servingSize
    sodiumContent
    sugarContent
    transFatContent
    unsaturatedFatContent
  ].freeze

  # Annex II to Regulation (EU) No 1169/2011 names fourteen substances. The
  # count is asserted rather than assumed because the layout derives each
  # recipe's "free from" list by subtraction: if the data file grows a
  # fifteenth entry, every recipe silently starts claiming something new.
  EU_ALLERGEN_COUNT = 14

  # ISO 4217 alphabetic codes, List One as maintained by SIX Interbank Clearing
  # on behalf of ISO. Includes the fund codes and the X-codes, which are part
  # of the same list. Re-read the published list when a currency is redenominated
  # — that is the only thing that changes this constant.
  ISO_4217_CODES = %w[
    AED AFN ALL AMD ANG AOA ARS AUD AWG AZN
    BAM BBD BDT BGN BHD BIF BMD BND BOB BOV BRL BSD BTN BWP BYN BZD
    CAD CDF CHE CHF CHW CLF CLP CNY COP COU CRC CUP CVE CZK
    DJF DKK DOP DZD EGP ERN ETB EUR FJD FKP
    GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HTG HUF
    IDR ILS INR IQD IRR ISK JMD JOD JPY
    KES KGS KHR KMF KPW KRW KWD KYD KZT
    LAK LBP LKR LRD LSL LYD
    MAD MDL MGA MKD MMK MNT MOP MRU MUR MVR MWK MXN MXV MYR MZN
    NAD NGN NIO NOK NPR NZD OMR
    PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF
    SAR SBD SCR SDG SEK SGD SHP SLE SOS SRD SSP STN SVC SYP SZL
    THB TJS TMT TND TOP TRY TTD TWD TZS
    UAH UGX USD USN UYI UYU UYW UZS
    VED VES VND VUV WST
    XAF XAG XAU XBA XBB XBC XBD XCD XCG XDR XOF XPD XPF XPT XSU XTS XUA XXX
    YER ZAR ZMW ZWG
  ].freeze

  # ISO 8601 duration, restricted to the parts a cooking time can honestly use.
  # Years and months are deliberately excluded: their length depends on when
  # they start, so `P1M` cannot be added to anything. Weeks are excluded
  # because ISO 8601 does not allow them alongside other components.
  DURATION = /\AP(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+(?:\.\d+)?)S)?)?\z/

  # Seconds, or nil when the string is not a duration this site accepts. A bare
  # "P" or "PT" carries no components and is rejected with the rest.
  def self.duration_seconds(value)
    return nil unless value.is_a?(String)

    match = DURATION.match(value)
    return nil if match.nil? || match.captures.compact.empty?

    days, hours, minutes, seconds = match.captures.map { |part| part.to_f }
    ((days * 86_400) + (hours * 3_600) + (minutes * 60) + seconds).round
  end
end
