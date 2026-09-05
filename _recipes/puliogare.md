---
title: Puliogare
date: 2026-09-05
description: Temple-style tamarind rice in a pressure cooker. Plain basmati cooks under pressure for 5 minutes. A peanut and curry leaf tadka and a store-bought puliogare powder are then folded in off the heat.
eyebrow: Instant Pot · One pot · Vegan
alternate_names:
  - Puliyodarai
  - Puliyogare
  - Tamarind rice
  - Chitranna
disambiguating_description: >-
  A tangy, tamarind-based rice finished with a peanut and curry leaf tadka
  after the rice is cooked. It is not lemon rice, which has no tamarind and is
  sharper and lighter. It is not the sweeter, coconut-based versions of
  chitranna served in some South Indian homes.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# GlutenFreeDiet is not claimed: commercial asafoetida is usually cut with
# wheat flour, and the packaged puliogare powder can carry the same filler or
# its own asafoetida. See the allergen note, not a guess either way.
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
allergens:
  present:
    - id: peanuts
      note: 50 g of raw peanuts, cooked into the rice rather than scattered on top, so they cannot be picked out.
    - id: mustard
      note: 1 tsp of mustard seeds in the tadka.
    - id: sesame
      note: >-
        Sesame (gingelly) oil is the cooking fat throughout, not a garnish.
        Swap it for a neutral oil such as sunflower to leave it out; the
        flavour will be less traditional but the dish still works.
  may_contain:
    - id: gluten
      note: >-
        Through the asafoetida in the tadka and, separately, through the
        puliogare powder itself. Most asafoetida sold in shops is a blend cut
        with wheat flour. A packaged puliogare masala can carry either
        asafoetida or its own flour filler, so check both tins if this
        matters.
  note: >-
    The peanuts and the sesame oil are both in the pot from the start and
    cannot be worked around without changing the recipe. The puliogare powder
    is a bought blend, so its exact composition, and whether it is cut with
    gluten, depends on the brand in your cupboard.

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
cook_time: PT30M
total_time: PT35M
prep_time_display: 5 min
cook_time_display: 30 min
total_time_display: 35 min

# Ingredient cost for the whole pot at German supermarket and Indian-grocery
# prices, rounded up. The puliogare powder is the most expensive line by far.
# An estimate, not a receipt.
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
  - contains peanuts
  - contains sesame
tools:
  - Instant Pot Pro Max 6 qt WiFi
  - Wooden spoon

ingredients:
  - name: Rice
    items:
      - 280 g basmati rice, washed and drained
      - 340 ml water
  - name: Tadka
    items:
      - 3 tbsp sesame oil
      - 1 tsp mustard seeds
      - 1/2 tsp cumin seeds
      - 2 pinches asafoetida
      - 50 g raw peanuts
      - 2 green chillies, slit lengthwise
      - 10 curry leaves
  - name: To finish
    items:
      - 4 tbsp puliogare powder, such as MTR brand

steps:
  - name: Pressure cook the plain rice
    appliance: Pressure Cook
    setting: High
    duration: 5 min
    text: >-
      Add 280 g washed and drained basmati rice and 340 ml water to the inner
      pot. Lock on the lid, turn the valve to Sealing, and pressure cook on
      High for 5 minutes. Cooking the rice on its own first keeps the grains
      separate. Tamarind and sugar scorch easily on the base, so the puliogare
      powder never goes in before the lid does.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 10 min
    text: >-
      Leave the pot completely undisturbed for a 10 minute natural pressure
      release. Then turn the valve to Venting and wait for the float valve to
      drop before opening. Fluff the rice gently with a fork and spread it out
      in the pot so it stops cooking in its own steam.

  - name: Make the tadka
    appliance: Sauté
    setting: Medium
    duration: 2 min
    text: >-
      Wipe the pot dry if any rice water is left, then set it to Sauté on
      Medium. Add 3 tbsp sesame oil. Once it is warm, add 1 tsp mustard seeds,
      1/2 tsp cumin seeds, 2 pinches asafoetida and 50 g raw peanuts. Stir
      until the mustard seeds pop and the peanuts turn a light gold.

  - name: Add the chillies and curry leaves, then cancel
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      add 2 slit green chillies and 10 curry leaves. Stir for 30 seconds until
      the chillies blister and the curry leaves crisp up, then press Cancel to
      turn off Sauté.

  - name: Fold in the rice and the powder
    text: >-
      Return the cooked rice to the pot with the tadka, or tip the tadka over
      the rice, either way round. Sprinkle 4 tbsp puliogare powder over the
      top and fold everything through gently with a flat spatula so the grains
      do not break. Fold rather than stir, and lift from the bottom of the pot
      each time, since the powder needs to reach every layer.

  - name: Rest and serve
    text: >-
      Let it sit uncovered for 5 minutes. This is when the rice finishes
      absorbing the tadka oil and the powder's tang stops sitting on the
      surface. Taste and fold through a little more puliogare powder if it
      needs more tang, then serve warm.

# Estimated from the ingredient weights above and divided by three, not
# measured in a lab. Keys map one-to-one onto schema.org NutritionInformation;
# `note` is the only key here that is not a schema property.
nutrition:
  serving_size: About 250 g, a third of the pot
  calories: 590 kcal
  protein_content: 14 g
  fat_content: 26 g
  saturated_fat_content: 4 g
  unsaturated_fat_content: 22 g
  trans_fat_content: 0 g
  cholesterol_content: 0 mg
  carbohydrate_content: 76 g
  sugar_content: 5 g
  fiber_content: 4 g
  sodium_content: 900 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab. The
    puliogare powder's own nutrition label was not to hand, so treat the
    sodium and sugar figures as rougher than the rest. The sesame oil and the
    peanuts carry most of the fat. The powder carries most of the salt and the
    sugar that gives the tang.

notes: >-
  Timings are for a 6 qt Instant Pot Pro Max WiFi (1200 W). The rice is
  pressure cooked on its own, with no powder in the liquid. Tamarind and sugar
  scorch on the base under pressure, and cooking them with the rice also turns
  the grains mushy. Some puliogare powders print packet instructions that have
  you stir the powder in before cooking. Do not do that in a sealed electric
  cooker. Start with 4 tbsp of powder for a mild tang, and use up to 5 for a
  stronger one. Add more at the table if it still needs it. Any raw,
  unsalted peanuts work in place of the ones named here. This is otherwise
  soy-free and dairy-free, but check your specific puliogare powder's tin for
  asafoetida and flour fillers if coeliac.
---
