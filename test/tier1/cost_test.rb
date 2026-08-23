# frozen_string_literal: true

require_relative "../test_helper"

# `estimated_cost` becomes a MonetaryAmount, whose currency has to be an ISO
# 4217 code rather than a symbol or a name.
class CostTest < RecipeTest
  rule "cost_currency_is_an_iso_4217_code" do |recipe|
    skip_without(recipe, "estimated_cost")

    currency = recipe["estimated_cost"]["currency"]

    assert_includes Vocabulary::ISO_4217_CODES, currency,
                    "#{recipe.name}: `estimated_cost.currency` is #{currency.inspect}. " \
                    "schema.org's MonetaryAmount takes an ISO 4217 code — EUR, GBP, USD — " \
                    "not a symbol and not a name"
  end

  rule "cost_value_is_a_positive_number" do |recipe|
    skip_without(recipe, "estimated_cost")

    value = recipe["estimated_cost"]["value"]

    assert_match(/\A\d+(?:\.\d+)?\z/, value.to_s,
                 "#{recipe.name}: `estimated_cost.value` is #{value.inspect}. Quote it as a " \
                 "plain decimal string — '3.50' — so YAML does not round the trailing zero " \
                 "away, and keep the currency out of it")
    assert_operator value.to_f, :>, 0,
                    "#{recipe.name}: `estimated_cost.value` is the ingredient cost for the " \
                    "whole pot, so it cannot be zero"
  end
end
