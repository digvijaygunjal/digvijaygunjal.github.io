---
title: Potato Bhaji
date: 2026-10-11
description: Firm, golden-red potato cubes for hot puris, cooked in one pot. A mustard seed and curry leaf tadka, onion and tomato on Sauté, then 3 minutes under pressure and a quick release.
eyebrow: Instant Pot · One pot · Vegan
alternate_names:
  - Batata Bhaji
  - Aloo Sabzi
  - Puri Bhaji
disambiguating_description: >-
  Cubed potato cooked in a tomato and onion masala until just tender, eaten
  with puris. The cubes stay whole. Pav bhaji is the mashed vegetable dish
  eaten with buttered rolls. Onion bhaji is a fried chickpea flour fritter.
cuisine: Indian
category: Side dish
cooking_method: Pressure cooking

# Nothing in the pot comes from an animal: the fat is sunflower oil.
#
# GlutenFreeDiet is out only because of the asafoetida, which is usually cut
# with wheat flour. See notes and the allergen entry.
#
# HinduDiet is this site's beef-free marker, which is a fact about composition
# rather than a claim about who should eat it. See CLAUDE.md.
#
# LowFatDiet, LowCalorieDiet and LowSaltDiet are not claimed. About a quarter
# of the energy is from the oil, and 600 mg sodium a serving is not low salt.
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
    - id: mustard
      note: >-
        0.5 tsp of mustard seeds in the tadka. They are cooked into the oil, so
        they cannot be picked out. Leave them out and the dish still works.
  may_contain:
    - id: gluten
      note: >-
        Only through the asafoetida. Most asafoetida in shops is cut with wheat
        flour. Gluten-free tins say so on the label. Nothing else here is a
        gluten grain.
  note: >-
    Peanut oil is a common choice for this dish. Use it and the recipe
    contains peanuts. The puris are wheat, so the meal contains gluten even
    when the bhaji does not.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/potato-bhaji.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished potato
  bhaji, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 4 servings
prep_time: PT15M
cook_time: PT30M
total_time: PT45M
prep_time_display: 15 min
cook_time_display: 30 min
total_time_display: 45 min

# Ingredient cost for the whole pot at German supermarket prices, plus an Asian
# grocer for the curry leaves, rounded up. The puris are not included. An
# estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "4.50"
keywords:
  - instant pot
  - pressure cooker
  - potato bhaji
  - batata bhaji
  - aloo sabzi
  - puri bhaji
  - one pot
  - vegan
  - contains mustard
  - may contain gluten
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Wooden spoon

ingredients:
  - name: Tadka
    items:
      - 2 tbsp sunflower oil
      - 0.5 tsp mustard seeds
      - 1 tsp cumin seeds
      - 1 pinch asafoetida
      - 12 fresh curry leaves
  - name: Masala base
    items:
      - 150 g onion, thinly sliced
      - 2 green chillies, slit lengthwise
      - 1 tsp ginger-garlic paste
      - 200 g tomatoes, finely chopped
  - name: Ground spices
    items:
      - 0.5 tsp turmeric powder
      - 1 tsp Kashmiri red chilli powder
      - 1 tsp salt
      - 0.25 tsp sugar
  - name: Potatoes
    items:
      - 750 g waxy potatoes, peeled and cut into 2.5 cm cubes
      - 180 ml water
  - name: To finish
    items:
      - 1 tbsp lemon juice
      - 10 g fresh coriander, finely chopped

steps:
  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High for 15 minutes. Wait 2 to 3 minutes,
      until the display reads Hot, then add 2 tbsp sunflower oil.

  - name: Make the tadka
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      reduce the level to Medium and add 0.5 tsp mustard seeds. When they
      start to pop, add 1 tsp cumin seeds, 1 pinch asafoetida and 12 curry
      leaves. Stir for 20 seconds, until fragrant. Stand back, because the
      curry leaves spit in hot oil. On High the cumin and asafoetida scorch in
      seconds.

  - name: Soften the onion
    appliance: Sauté
    setting: Medium
    duration: 3 min
    continues: true
    text: >-
      add 150 g thinly sliced onion and 2 slit green chillies. Stir every 30
      seconds until the onion is soft and translucent.

  - name: Cook the ginger and garlic
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      add 1 tsp ginger-garlic paste. Stir constantly so it does not catch on
      the base. Stop when the raw garlic smell has gone.

  - name: Soften the tomato
    appliance: Sauté
    setting: Medium
    duration: 3 min
    continues: true
    text: >-
      add 200 g finely chopped tomatoes. Press them against the base with the
      spoon until they soften and release their red juice. Keep the juice in
      the pot. It is part of the liquid the pot needs to reach pressure.

  - name: Add the ground spices off the heat
    text: >-
      Press Cancel to turn off Sauté. Add 0.5 tsp turmeric powder, 1 tsp
      Kashmiri red chilli powder, 1 tsp salt and 0.25 tsp sugar. Stir for 20
      seconds. The heat left in the pot cooks the spices without burning them.
      Kashmiri chilli gives the red colour with little heat.

  - name: Add the potatoes and scrape the base
    text: >-
      Add 750 g cubed potatoes and pour in 180 ml water. Scrape the whole base
      with a wooden spoon until nothing is stuck to it. A speck of browned
      onion or spice left there is the usual cause of a Burn warning. Then
      turn the cubes gently until each one is coated.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 3 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      3 minutes, with Keep Warm turned off. The 3 minutes start only once the pot
      is up to pressure. If the display shows Burn, do a quick release, scrape
      the base and add 60 ml water.

  - name: Quick release
    appliance: Quick Release
    duration: 2 min
    text: >-
      As soon as the timer beeps, turn the valve to Venting and keep your hand
      clear of the steam. Open the lid when the float valve drops. A natural
      release keeps cooking the potatoes, and the cubes turn soft at the
      edges.

  - name: Cook off the liquid
    appliance: Sauté
    setting: Medium
    duration: 3 min
    text: >-
      Set the pot to Sauté on Medium with the lid off. Fold the cubes gently
      every 30 seconds until the liquid has thickened and clings to them. Stop
      while the base still looks a little wet, because the cubes soak up more
      as they rest.

  - name: Finish and serve
    text: >-
      Press Cancel. Pour 1 tbsp lemon juice over the potatoes and scatter on
      10 g chopped coriander. Fold once from the bottom up with a flat spoon,
      so the cubes stay whole. Serve with hot puris.

# Estimated from the ingredient weights above and divided by four, not measured
# in a lab. Keys map one-to-one onto schema.org NutritionInformation; `note` is
# the only key here that is not a schema property.
nutrition:
  serving_size: About 300 g, a quarter of the pot
  calories: 240 kcal
  protein_content: 5 g
  fat_content: 7 g
  saturated_fat_content: 1 g
  unsaturated_fat_content: 6 g
  trans_fat_content: 0 g
  cholesterol_content: 0 mg
  carbohydrate_content: 40 g
  sugar_content: 5 g
  fiber_content: 5 g
  sodium_content: 600 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab, and counted
    for the bhaji alone without puris. The potatoes carry nearly all of the
    carbohydrate. The 2 tbsp of oil carry nearly all of the fat. Almost all of
    the sodium is the 1 tsp of salt, so use less and season at the table if
    you are watching it.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It heats up faster and
  runs hotter on Sauté than a Duo. On a Duo or a Lux, give the onion an extra
  minute and expect a slower rise to pressure. The 3 minute pressure time stays
  the same on any cooker, because it is timed for 2.5 cm cubes. Cut the cubes
  evenly. Smaller pieces turn to mash before larger ones are cooked through.
  Use a waxy potato such as Yukon Gold, a red-skinned variety or a German
  festkochend one. Floury potatoes break up at this time and are better kept
  for pav bhaji. If a cube still resists a knife after the release, simmer on
  Sauté Low for 2 minutes with the lid off. The Pro manual asks for 375 ml of
  liquid to pressure cook. Here 180 ml of water and the juice of 200 g of
  tomatoes come close to that. Cut the water and you risk a Burn warning
  before the pot seals. The extra liquid is cooked off on Sauté at the end. Use peanut oil in place of
  sunflower if you like the taste, and the recipe then contains peanuts. The
  recipe is not labelled gluten-free only because of the asafoetida. Buy a tin
  that says gluten-free and the bhaji is gluten-free. It keeps for 2 days in
  the fridge.
---
