---
title: Moong Dal Amti
date: 2026-09-17
description: A thin, hot Satara-style moong dal amti. A fresh coconut, garlic and chilli watan goes in on Sauté, then the dal pressure cooks in the same pot.
eyebrow: Instant Pot · Maharashtrian · Vegan
alternate_names:
  - Mugachi amti
  - Mugachya dalichi amti
  - Maharashtrian moong dal curry
disambiguating_description: >-
  A savoury, hot dal from western Maharashtra, built on kanda lasun masala and
  a fresh coconut and garlic watan. It is not varan, the plain dal cooked with
  only turmeric and salt. It carries no jaggery or kokum, so it is not the
  sweet and sour Gujarati dal either.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# The fat is oil and there is no ghee, curd or butter anywhere in the pot, so
# VeganDiet holds. GlutenFreeDiet is deliberately absent: the asafoetida the
# cook adds is usually cut with wheat flour, and kanda lasun masala is a bought
# blend that often carries asafoetida of its own. Neither can be promised from
# here — see the allergen notes below.
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
# Three of the four entries here hang on the kanda lasun masala, which is a
# bought blend whose composition differs between makers and between packs.
# That is why sesame and peanut are "may contain" and not "present": no
# declaration that would hold for every packet can be written from here.
allergens:
  present:
    - id: mustard
      note: >-
        1 tsp of mustard seeds in the tadka. They are the first thing into the
        oil, so they cannot be left out.
  may_contain:
    - id: gluten
      note: >-
        Through the asafoetida, which is usually cut with wheat flour. Kanda
        lasun masala often carries asafoetida too. Check both tins if that
        matters.
    - id: sesame
      note: >-
        Kanda lasun masala is a bought blend, and many brands list sesame.
        Read the packet you have.
    - id: peanuts
      note: >-
        Some kanda lasun masala blends carry peanut. Nothing else here does.
        Read the packet.
  note: >-
    Dry coconut is in the watan and cannot be picked out. EU rules do not
    count coconut as a tree nut, and US labelling does. The masala is a bought
    blend, and a maker can change what goes into it.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/moong-dal-amti.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished moong
  dal amti, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 4 servings
prep_time: PT10M
cook_time: PT40M
total_time: PT50M
prep_time_display: 10 min
cook_time_display: 40 min
total_time_display: 50 min

# Ingredient cost for the whole pot at German supermarket and Indian-grocery
# prices, rounded up. The kanda lasun masala and the garam masala are counted
# at the few teaspoons this uses, not at the price of the packet. An estimate,
# not a receipt.
estimated_cost:
  currency: EUR
  value: "3.00"
keywords:
  - instant pot
  - pressure cooker
  - moong dal amti
  - mugachi amti
  - maharashtrian
  - kanda lasun masala
  - one pot
  - vegan
  - dal
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Small frying pan
  - Mortar and pestle, or a small grinder
  - Wooden spoon
  - Ladle

ingredients:
  - name: Watan
    items:
      - 2 tbsp grated dry coconut
      - 4 garlic cloves
      - 10 g ginger
      - 2 green chillies
  - name: Tadka
    items:
      - 2 tbsp oil
      - 1 tsp mustard seeds
      - 1 tsp cumin seeds
      - 2 pinches asafoetida
      - 10 curry leaves
  - name: Base
    items:
      - 1 medium onion, finely chopped
      - 1 medium tomato, chopped
      - 1.5 tsp salt
      - 2 tsp kanda lasun masala
      - 1 tsp garam masala
      - 1/2 tsp turmeric powder
  - name: Dal
    items:
      - 200 g split yellow moong dal, washed and drained
      - 660 ml water, divided
  - name: To finish
    items:
      - 2 tbsp fresh coriander, chopped

steps:
  - name: Roast the dry coconut
    text: >-
      Dry-roast 2 tbsp grated dry coconut in a small pan over a low flame.
      Stir until it turns golden and smells toasted. Tip it onto a plate to
      cool.

  - name: Pound the watan
    text: >-
      Pound or grind the cooled coconut with 4 garlic cloves, 10 g ginger and
      2 green chillies. Keep it coarse. This paste is the watan, the fresh
      masala the amti is built on.

  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High. Wait 2 to 3 minutes, until the
      display reads Hot, then add 2 tbsp oil to the inner pot.

  - name: Bloom the mustard seeds
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      reduce the level to Medium and add 1 tsp mustard seeds. Wait for them to
      pop before anything else goes in.

  - name: Add the cumin, hing and curry leaves
    appliance: Sauté
    setting: Medium
    duration: 15 sec
    continues: true
    text: >-
      add 1 tsp cumin seeds, 2 pinches asafoetida and 10 curry leaves. Stir
      for 10 seconds. Cumin and asafoetida scorch in seconds on a high
      setting, so keep the level at Medium.

  - name: Soften the onion
    appliance: Sauté
    setting: Medium
    duration: 3 min
    continues: true
    text: >-
      add 1 medium onion, finely chopped. Cook until it turns soft and just
      starts to colour at the edges.

  - name: Fry the watan
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      stir in the coconut, garlic and chilli paste. Fry for a minute, until
      the raw garlic smell is gone.

  - name: Cook the tomato
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      add 1 medium tomato, chopped, and 1.5 tsp salt. Cook until the tomato
      softens and starts to break down.

  - name: Toss in the ground spices
    appliance: Sauté
    setting: Low
    duration: 15 sec
    continues: true
    text: >-
      reduce the level to Low. Add 2 tsp kanda lasun masala, 1 tsp garam
      masala and 1/2 tsp turmeric powder. Toss for 15 seconds. Ground spices
      burn fast on a dry hot base.

  - name: Deglaze the base
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      pour in 60 ml of the water. Scrape the base with a wooden spoon until
      nothing is stuck. This one minute is what keeps the Burn sensor quiet.

  - name: Add the dal and the rest of the water
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      add 200 g split yellow moong dal, washed and drained. Pour in the
      remaining 600 ml water and stir well. Press Cancel to turn off Sauté.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 8 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      8 minutes. The pot is already hot, so it takes about 8 to 10 minutes to
      come up to pressure.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 10 min
    text: >-
      Leave the pot undisturbed for a 10 minute natural pressure release. Then
      turn the valve to Venting and wait for the float valve to drop.

  - name: Stir and serve
    text: >-
      Open the lid away from you. Stir hard with a ladle so the dal breaks
      down into a smooth, pourable gravy. Scatter 2 tbsp chopped fresh
      coriander over the top and serve hot.

# Estimated from the ingredient weights above and divided by four, not
# measured in a lab. Keys map one-to-one onto schema.org NutritionInformation;
# `note` is the only key here that is not a schema property.
nutrition:
  serving_size: About 270 g, a quarter of the pot
  calories: 300 kcal
  protein_content: 13 g
  fat_content: 11 g
  saturated_fat_content: 3 g
  unsaturated_fat_content: 8 g
  trans_fat_content: 0 g
  cholesterol_content: 0 mg
  carbohydrate_content: 38 g
  sugar_content: 2 g
  fiber_content: 10 g
  sodium_content: 950 mg
  note: >-
    Estimated from the ingredient weights and divided by four, not measured in
    a lab. Nearly all the sodium is the 1.5 tsp of salt. Use 1 tsp and season
    at the table if you are watching it. The oil and the dry coconut carry
    most of the fat.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It preheats faster and
  runs hotter on Sauté than a Duo. Eight minutes is longer than split moong
  dal needs to be tender. That is on purpose. An amti is meant to be thin and
  pourable, and the extra minutes are what make the dal collapse on its own.
  For a thicker dal, drop the pressure cook to 6 minutes. The Burn sensor
  reads the base of the pot, so the deglazing step matters more than it looks.
  Tomato and kanda lasun masala both stick, and 60 ml of water with a proper
  scrape clears them. Swapping the dal changes the timing. Whole green moong
  needs about 18 to 20 minutes from dry, sprouted moong about 8. Neither has
  been timed on this cooker, so treat those as a starting point. Leftovers
  thicken in the fridge overnight. Loosen with hot water on Sauté Low and
  check the salt again.
---
