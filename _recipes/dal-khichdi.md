---
title: Moong Dal Khichdi
date: 2026-11-04
description: A soft, porridge-like khichdi of basmati rice and split yellow moong dal. A cumin and ghee tadka goes in on Sauté, then everything pressure cooks in the same pot.
eyebrow: Instant Pot · One pot · Comfort food
alternate_names:
  - Dal khichdi
  - Moong dal khichadi
  - Khichri
disambiguating_description: >-
  A loose, spoonable porridge of rice and split yellow moong dal in equal
  weights, cooked soft with turmeric and a cumin tadka. It is not masala
  khichdi or vaghareli khichdi, which add whole spices and vegetables and stay
  grainy. It is not pongal either, which seasons the same pair with black
  pepper and curry leaves.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# Vegan and Dairy-free are absent: ghee goes in twice, in the tadka and over
# the top. GlutenFreeDiet is absent too, because commercial asafoetida is
# usually cut with wheat flour; the same reasoning keeps the masala rice off
# it. Leave out the asafoetida, or use a certified gluten-free one, and the
# claim would hold. That depends on the tin the cook buys, so it stays off.
#
# HinduDiet is this site's beef-free marker, a fact about composition rather
# than a claim about who should eat it — see CLAUDE.md.
diets:
  - label: Vegetarian
    schema: VegetarianDiet
  - label: Beef-free
    schema: HinduDiet

# Declared against the fourteen of EU 1169/2011 Annex II, listed in
# _data/allergens.yml; the layout derives the "free from" list from the rest.
# Ids only — the wording lives in the data file so no two recipes phrase the
# same allergen differently.
allergens:
  present:
    - id: milk
      note: >-
        2 tbsp of ghee in all, half in the tadka and half over the top. Use a
        neutral oil for both and the pot has no milk in it.
  may_contain:
    - id: gluten
      note: >-
        Only through the asafoetida, which is usually cut with wheat flour.
        Leave it out, or buy a tin labelled gluten-free.
  note: >-
    Jarred ginger-garlic paste can carry preservatives. Read the label, or
    grate fresh ginger and garlic.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/dal-khichdi.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished moong
  dal khichdi, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

# The source this was adapted from said 25 minutes of cooking. Counted step by
# step on this cooker it is longer: about 6 min of Sauté, 10 to 12 min for a
# litre of liquid to come up to pressure, 6 min under pressure and a 15 min
# natural release. 40 min is the honest figure.
yield: 4 servings
prep_time: PT10M
cook_time: PT40M
total_time: PT50M
prep_time_display: 10 min
cook_time_display: 40 min
total_time_display: 50 min

# Ingredient cost for the whole pot at German supermarket and Indian-grocery
# prices, rounded up. Spices are counted at the pinches used, not the packet.
# An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "2.50"
keywords:
  - instant pot
  - pressure cooker
  - khichdi
  - moong dal khichdi
  - dal khichdi
  - comfort food
  - one pot
  - vegetarian
  - contains milk
  - may contain gluten
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Fine-mesh strainer
  - Wooden spoon
  - Ladle

ingredients:
  - name: Rice and dal
    items:
      - 100 g basmati rice, or sona masoori
      - 100 g split yellow moong dal
      - 960 ml water, or 840 ml for a thicker khichdi
  - name: Tadka
    items:
      - 1 tbsp ghee, or a neutral oil
      - 1 tsp cumin seeds
      - 1 pinch asafoetida
  - name: Base
    items:
      - 1 tsp ginger-garlic paste, or 5 g fresh ginger and 1 garlic clove, grated
      - 1 green chilli, slit lengthwise, optional
      - 1 medium tomato, about 120 g, chopped
      - 1/2 tsp turmeric powder
      - 1 tsp salt
  - name: To finish
    items:
      - 1 tbsp ghee, melted
      - 2 tbsp fresh coriander, chopped

steps:
  - name: Rinse the rice and dal
    text: >-
      Put 100 g basmati rice and 100 g split yellow moong dal together in a
      fine-mesh strainer. Rinse under cold water two or three times, until the
      water runs clear. Leave to drain.

  - name: Preheat the pot
    appliance: Sauté
    setting: Medium
    duration: 2 min
    text: >-
      Set the Instant Pot to Sauté on Medium. Wait for the display to read Hot,
      then add 1 tbsp ghee to the inner pot and let it melt.

  - name: Bloom the cumin and hing
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      add 1 tsp cumin seeds and 1 pinch asafoetida. Stir until the seeds
      crackle, a few seconds only. Asafoetida scorches fast, so keep the level
      at Medium.

  - name: Fry the ginger, garlic and chilli
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      stir in 1 tsp ginger-garlic paste and the slit green chilli. Fry for 30
      seconds, until the raw garlic smell is gone.

  - name: Soften the tomato
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      add 1 medium tomato, chopped, with 1/2 tsp turmeric powder and 1 tsp
      salt. Cook until the tomato begins to soften and break down.

  - name: Deglaze, then add the rice and dal
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      pour in 960 ml water. Scrape the base with a wooden spoon until nothing
      is stuck, then stir in the drained rice and dal. Press Cancel to turn off
      Sauté.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 6 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      6 minutes. A litre of liquid takes 10 to 12 minutes to come up to
      pressure first.

  - name: Natural release
    appliance: Natural Release
    duration: 15 min
    text: >-
      Leave the pot alone until the float valve drops on its own, about 15
      minutes. Do not vent it early. Starchy rice and dal foam under pressure
      and spray out through the valve.

  - name: Stir, loosen and serve
    text: >-
      Open the lid away from you and stir well. Whisk in a splash of hot water
      if it is thicker than you like. Drizzle over 1 tbsp melted ghee, scatter
      2 tbsp chopped coriander and serve hot.

# Estimated from the ingredient weights above and divided by four, not
# measured in a lab. Working: 100 g raw basmati (about 350 kcal), 100 g raw
# split moong (about 350 kcal), 28 g ghee (about 250 kcal, 17.5 g saturated,
# 72 mg cholesterol), 120 g tomato and the spices (about 45 kcal). Total about
# 1000 kcal and 1250 g cooked. 1 tsp salt is about 6 g, or 2300 mg sodium.
# Keys map one-to-one onto schema.org NutritionInformation; `note` is the only
# key here that is not a schema property.
nutrition:
  serving_size: About 310 g, a quarter of the pot
  calories: 250 kcal
  protein_content: 8 g
  fat_content: 8 g
  saturated_fat_content: 4.5 g
  unsaturated_fat_content: 3 g
  trans_fat_content: 0.3 g
  cholesterol_content: 18 mg
  carbohydrate_content: 36 g
  sugar_content: 2 g
  fiber_content: 3 g
  sodium_content: 590 mg
  note: >-
    Estimated from the ingredient weights and divided by four, not measured in
    a lab. The 2 tbsp of ghee carry nearly all the fat and all the
    cholesterol. Skip the drizzle on top and both fall by half. Nearly all the
    sodium is the salt.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It heats up faster
  and runs hotter on Sauté than a Duo. Give the tadka half a minute longer on
  a Duo or a Lux. The time under pressure is the same on any electric
  cooker. Water decides the texture. 960 ml gives a loose porridge that
  settles as it stands. 840 ml gives a thick khichdi you eat with a spoon. It
  thickens a lot as it cools, so loosen leftovers with hot water on Sauté Low.
  For a plain khichdi for someone who is unwell, or for a small child, leave
  out the tomato, chilli and ginger-garlic paste. Cook the rice and dal with
  the turmeric, salt, water and a little ghee. For a vegetable khichdi, stir
  in about 80 g of diced carrot, peas and potato before sealing the lid. The
  time does not change. Serve it with plain yoghurt or raita, a little lime
  pickle and a roasted papad.
---
