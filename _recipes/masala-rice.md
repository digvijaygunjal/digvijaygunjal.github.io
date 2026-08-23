---
title: Masala Rice
date: 2026-08-22
updated: 2026-08-23
description: A one-pot masala rice. Whole spices bloomed in oil, potatoes, cauliflower and peanuts cooked down on Sauté, then pressure cooked with basmati for 5 minutes.
eyebrow: Instant Pot · One pot · Vegan
alternate_names:
  - Tehri
  - Vegetable tehri
disambiguating_description: >-
  A pressure-cooked one-pot rice: raw basmati is toasted in the masala and then
  cooked in the same pot, so it is not a fried-rice style dish built from
  leftover cooked rice.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# Each entry carries the label shown on the page and the schema.org
# RestrictedDiet enum emitted as suitableForDiet, so the two cannot disagree.
# GlutenFreeDiet is deliberately absent — see notes.
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
  may_contain:
    - id: gluten
      note: >-
        Only through the asafoetida. Most commercial asafoetida is a compound,
        cut with wheat flour to keep it pourable; the gluten-free tins say so on
        the label and are usually cut with rice flour instead. Nothing else here
        is a gluten grain.
  note: >-
    The peanuts are the one that cannot be worked around: they are in the pot
    from the Sauté stage. Leave them out entirely if you are cooking for a
    peanut allergy — the rice is fine without them.
image: /assets/images/recipes/masala-rice.jpg
image_alt: Masala rice on a steel thali, studded with green peas, diced potato and whole bay leaves.
yield: 4 servings
prep_time: PT15M
cook_time: PT45M
total_time: PT60M
prep_time_display: 15 min
cook_time_display: 45 min
total_time_display: 1 hr

# Ingredient cost for the whole pot at German supermarket prices, rounded up.
# An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "3.50"
keywords:
  - instant pot
  - pressure cooker
  - masala rice
  - tehri
  - one pot
  - vegetarian
  - basmati rice
  - vegan
tools:
  - Instant Pot Pro Max 6 qt WiFi
  - Wooden spoon

ingredients:
  - name: Whole spices & fat
    items:
      - 2.5 tbsp oil
      - 1 tsp cumin seeds
      - 1 tsp mustard seeds
      - 2 pinches asafoetida
      - 4 whole cloves
      - 1 star anise
      - 1 bay leaf
      - 8 whole black peppercorns
  - name: Aromatics
    items:
      - 15 g green chillies, finely chopped
      - 1 tbsp ginger-garlic paste
      - 1 large onion, finely chopped
  - name: Ground spices
    items:
      - 1 tsp turmeric powder
      - 1 tbsp ground coriander
      - 1 tsp red chilli powder, or to taste
      - 3 tsp garam masala, divided
      - 2 tsp salt
  - name: Vegetables & rice
    items:
      - 2 small potatoes, cut into 2 cm dice
      - 80 g cauliflower, cut into large florets
      - 50 g raw peanuts
      - 300 g basmati rice, washed and drained
      - 360 ml water
  - name: To finish
    items:
      - 80 g green peas
      - 2 tbsp fresh coriander, chopped

steps:
  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High for 25 minutes. Wait 2 to 3 minutes,
      until the display reads Hot, then add 2.5 tbsp oil to the inner pot.

  - name: Bloom the whole spices
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    # image: /assets/images/recipes/step-tadka.jpg
    text: >-
      reduce the level to Medium and add 1 tsp cumin seeds, 1 tsp mustard seeds,
      2 pinches asafoetida, 4 whole cloves, 1 star anise, 1 bay leaf and 8 whole
      black peppercorns to the hot oil. Stir until the mustard seeds pop and the
      spices smell fragrant. Do not do this on High — cumin and asafoetida scorch
      in seconds at that temperature.

  - name: Cook the aromatics
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      add 15 g finely chopped green chillies and 1 tbsp ginger-garlic paste.
      Stir constantly so the paste does not catch on the base, until the raw
      garlic smell is gone.

  - name: Soften the onion
    appliance: Sauté
    setting: Medium
    duration: 8 min
    continues: true
    text: >-
      add 1 large onion, finely chopped. Cook, stirring every minute or so,
      until translucent, soft and just starting to colour at the edges. The pot
      heats only from the base, so this takes longer than it would in a frying
      pan.

  - name: Roast the ground spices
    appliance: Sauté
    setting: Low
    duration: 30 sec
    continues: true
    text: >-
      reduce the level to Low, then add 1 tsp turmeric powder, 1 tbsp ground
      coriander, 1 tsp red chilli powder, 1 tsp of the garam masala and 2 tsp
      salt. Stir constantly for 30 seconds. If the pan looks dry, add a splash
      of water to stop the ground spices burning.

  - name: Add the vegetables and peanuts
    appliance: Sauté
    setting: Medium
    duration: 3 min
    continues: true
    text: >-
      add 2 small potatoes cut into 2 cm dice, 80 g cauliflower cut into large
      florets and 50 g raw peanuts. Stir until everything is coated in the spice
      mixture and the potato edges start to turn translucent.

  - name: Toast the rice
    appliance: Sauté
    setting: Low
    duration: 90 sec
    continues: true
    text: >-
      reduce the level to Low and add 300 g basmati rice, washed and drained.
      Fold gently to coat every grain in fat, taking care not to break them.
      Drained rice sticks to a hot base almost immediately, which is the most
      common cause of a Burn warning in this recipe.

  - name: Deglaze, then cancel
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      pour in 360 ml water. Scrape the base of the pot thoroughly with a wooden
      spoon for a full minute to lift every browned spice bit. Level the rice so
      it sits under the liquid, then press Cancel to turn off Sauté.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 5 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for 5
      minutes. Because the pot is already hot, it will take about 6 to 9 minutes
      to come up to pressure first. Do not use NutriBoost — the agitation breaks
      basmati grains.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 10 min
    text: >-
      Leave the pot completely undisturbed for a 10 minute natural pressure
      release. This is when the rice finishes absorbing and firms up, so it is
      part of the cooking, not a pause. Then turn the valve to Venting and wait
      for the float valve to drop before opening.

  - name: Add the peas, fluff and serve
    text: >-
      Open the lid away from you and scatter 80 g green peas over the hot rice.
      Close the lid loosely for 3 minutes so they warm through without turning
      grey. Remove the bay leaf and star anise, fold through the remaining 2 tsp
      garam masala and 2 tbsp chopped fresh coriander, fluff gently with a fork
      and serve hot.

# Estimated from the ingredient weights above and divided by four, not measured
# in a lab. Keys map one-to-one onto schema.org NutritionInformation; `note` is
# the only key here that is not a schema property.
nutrition:
  serving_size: About 310 g, a quarter of the pot
  calories: 520 kcal
  protein_content: 13 g
  fat_content: 17 g
  saturated_fat_content: 2 g
  unsaturated_fat_content: 15 g
  trans_fat_content: 0 g
  cholesterol_content: 0 mg
  carbohydrate_content: 83 g
  sugar_content: 4 g
  fiber_content: 7 g
  sodium_content: 1180 mg
  note: >-
    Estimated from the ingredient weights, not laboratory-measured. Nearly all
    of the sodium is the 2 tsp of salt; use 1 tsp and season at the table if you
    are watching it. Peanuts and oil account for most of the fat, and all of it
    is plant fat, which is why cholesterol is nil.

notes: >-
  Timings are calibrated for a 6 qt Instant Pot Pro Max WiFi (1200 W), which
  preheats faster and runs hotter on Sauté than a Duo. If your rice was soaked
  for 20 to 30 minutes rather than just rinsed, drop the pressure cook time to
  4 minutes. Turn Keep Warm off during the natural release so the base layer
  does not dry out. The recipe is not labelled gluten-free even though nothing
  in it is a grain other than rice: most commercial asafoetida is cut with wheat
  flour, so check your tin if that matters.
---
