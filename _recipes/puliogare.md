---
title: Puliogare
date: 2026-09-05
description: Temple-style tamarind rice in a pressure cooker. The tadka, the puliogare powder and the rice all go in on Sauté, then the pot is sealed and pressure cooked.
eyebrow: Instant Pot · One pot · Vegan
alternate_names:
  - Puliyodarai
  - Puliyogare
  - Tamarind rice
  - Chitranna
disambiguating_description: >-
  A tangy, tamarind-based rice built on a peanut and curry leaf tadka, with a
  bought puliogare masala bloomed in the oil. It is not lemon rice, which has
  no tamarind and is sharper and lighter. It is not the sweeter,
  coconut-based versions of chitranna served in some South Indian homes.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# GlutenFreeDiet is not claimed, but the reason is narrower than it looks. The
# powder's published ingredient list carries no cereal, and the maltodextrin on
# the current export pack is named as corn, so the powder is probably not the
# risk. The asafoetida the cook adds separately is, because commercial hing is
# usually cut with wheat flour. Checked against the MTR packet and against the
# declarations Dookan and Spice Village publish; formulations differ between
# packs, so this stays a "may contain" rather than a promise.
#
# HinduDiet is this site's beef-free marker, a fact about composition rather
# than a claim about who should eat it — see CLAUDE.md.
diets:
  - label: Vegan
    schema: VeganDiet
  - label: Vegetarian
    schema: VegetarianDiet
  - label: Dairy-free
    schema: LowLactoseDiet
  - label: Beef-free
    schema: HinduDiet

# Declared against the fourteen of EU 1169/2011 Annex II, listed in
# _data/allergens.yml; the layout derives the "free from" list from the rest.
# Ids only — the wording lives in the data file so no two recipes phrase the
# same allergen differently.
#
# Peanut, sesame and mustard are all in the MTR powder itself, which its label
# declares. That is why none of the three can be left out of this dish.
allergens:
  present:
    - id: peanuts
      note: >-
        50 g of raw peanuts in the tadka, and the powder is 12% peanut on its
        own. Leaving the peanuts out does not make this safe for a peanut
        allergy.
    - id: mustard
      note: >-
        1 tsp of mustard seeds in the tadka. The powder lists mustard as well,
        so this one cannot be left out.
    - id: sesame
      note: >-
        Sesame oil is the cooking fat, and the powder lists sesame as well.
        Swapping the oil for sunflower does not take the sesame out.
  may_contain:
    - id: gluten
      note: >-
        Only through the asafoetida you add yourself. Most asafoetida sold in
        shops is a blend cut with wheat flour. The powder's own label lists no
        cereal, and names its maltodextrin as corn. Labels change, so check
        your tin.
  note: >-
    Three of the fourteen are in the powder itself, so they cannot be cooked
    around. The powder also carries coconut. EU rules do not count that as a
    tree nut, but US labelling does. The powder is a bought blend, and a maker
    can change what goes into it. Check your own tin.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/puliogare.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished
  puliogare, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 3 servings
prep_time: PT5M
cook_time: PT35M
total_time: PT40M
prep_time_display: 5 min
cook_time_display: 35 min
total_time_display: 40 min

# Ingredient cost for the whole pot at German supermarket and Indian-grocery
# prices, rounded up. This uses 60 g out of a 200 g packet. An estimate, not a
# receipt.
estimated_cost:
  currency: EUR
  value: "3.00"
keywords:
  - instant pot
  - pressure cooker
  - tamarind rice
  - puliyodarai
  - one pot
  - vegan
  - basmati rice
tools:
  - Instant Pot Pro Max 6 qt WiFi
  - Wooden spoon
  - Flat spatula

ingredients:
  - name: Tadka
    items:
      - 3 tbsp sesame oil
      - 1 tsp mustard seeds
      - 1/2 tsp cumin seeds
      - 2 pinches asafoetida
      - 50 g raw peanuts
      - 10 curry leaves
  - name: Masala
    items:
      - 60 g puliogare powder, about 4 tbsp, such as MTR brand
  - name: Rice
    items:
      - 280 g basmati rice, washed and drained
      - 360 ml water

steps:
  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High. Wait 2 to 3 minutes, until the
      display reads Hot, then add 3 tbsp sesame oil to the inner pot.

  - name: Bloom the tadka
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      reduce the level to Medium and add 1 tsp mustard seeds, 1/2 tsp cumin
      seeds, 2 pinches asafoetida and 50 g raw peanuts. Stir until the mustard
      seeds pop and the peanuts turn a light gold.

  - name: Add the curry leaves
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      add 10 curry leaves. Stir for 30 seconds until they crisp up.

  - name: Stir in the puliogare powder
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      reduce the level to Low and add 60 g puliogare powder. Stir constantly
      for a minute, until it coats the peanuts and smells toasted. Do this on
      Low. The powder carries jaggery and tamarind, and both catch on a hot
      base within seconds.

  - name: Toast the rice
    appliance: Sauté
    setting: Low
    duration: 90 sec
    continues: true
    text: >-
      add 280 g washed and drained basmati rice. Fold gently to coat every
      grain, taking care not to break them. Drained rice sticks to a hot base
      within seconds, and that is the most common cause of a Burn warning
      here.

  - name: Add the water and scrape the base
    appliance: Sauté
    setting: Low
    duration: 2 min
    continues: true
    text: >-
      pour in 360 ml water. Scrape the base of the pot with a wooden spoon for
      a full two minutes. Nothing should be stuck when you stop. This is the
      step that decides whether you get a Burn warning, and the powder on the
      base makes it matter more here. Level the rice under the water, then
      press Cancel.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 5 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      5 minutes. The pot is already hot, so it takes about 6 to 9 minutes to
      come up to pressure first.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 10 min
    text: >-
      Leave the pot completely undisturbed for a 10 minute natural pressure
      release. Then turn the valve to Venting and wait for the float valve to
      drop before opening.

  - name: Fluff and serve
    text: >-
      Open the lid away from you. Fold the rice from the bottom up with a flat
      spatula so the masala reaches every layer. Let it sit uncovered for 5
      minutes, then taste and serve warm.

# Estimated from the ingredient weights above and from the powder's declared
# percentages, divided by three. Keys map one-to-one onto schema.org
# NutritionInformation; `note` is the only key here that is not a schema
# property.
nutrition:
  serving_size: About 260 g, a third of the pot
  calories: 610 kcal
  protein_content: 14 g
  fat_content: 27 g
  saturated_fat_content: 5 g
  unsaturated_fat_content: 22 g
  trans_fat_content: 0 g
  cholesterol_content: 0 mg
  carbohydrate_content: 84 g
  sugar_content: 6 g
  fiber_content: 5 g
  sodium_content: 890 mg
  note: >-
    Estimated from the ingredient weights and the powder's own nutrition
    panel, not measured in a lab. The panel gives 11 g of salt per 100 g,
    which is where all the sodium here comes from. There is no added salt in
    the pot. The sesame oil, the peanuts and the coconut in the powder carry
    most of the fat.

notes: >-
  Timings are for a 6 qt Instant Pot Pro Max WiFi (1200 W). Everything stays
  in one pot from the tadka to the table, with no washing in between. The
  powder goes in on Sauté, which is what the MTR packet itself tells you to
  do. Blooming a puliogare masala in oil is the traditional method, and it
  tastes deeper than powder stirred through at the end. Two things to watch.
  The powder carries jaggery and tamarind, so it can catch on the base.
  Scrape the pot properly at the water step and the Burn sensor stays quiet.
  Tamarind also makes the water acidic, and acid slows the rice down. If the
  grains come out firm, add 3 tbsp of hot water, put the lid back on and wait
  5 minutes. There is no added salt here. The powder is about 11% salt, so
  60 g brings roughly 6 g of it into the pot. Taste before you reach for the
  salt tin. The peanuts and curry leaves
  soften under pressure and come out chewy. Traditional puliogare has them
  crisp. Fry a spare tablespoon of peanuts in a small pan and scatter them
  over at the end if you want the crunch. Hold back 1 tbsp of the powder and
  fold it in after cooking for a fresher, sharper tang.
---
