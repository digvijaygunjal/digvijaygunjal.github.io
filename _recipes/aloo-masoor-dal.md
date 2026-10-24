---
title: Aloo Masoor Dal
date: 2026-10-24
description: A quick potato and red lentil dal, pressure cooked in one pot with a cumin tadka. Ready in 6 minutes under pressure and thick enough to scoop with bread.
eyebrow: Instant Pot · One pot · Gluten-free
alternate_names:
  - Masoor Dal with Potato
  - Red Lentil and Potato Dal
disambiguating_description: >-
  A red lentil dal with potato cooked in and a cumin tadka stirred through at
  the end. It is not dal tadka, which is usually toor or moong dal with no
  potato. It is not sambar, which adds tamarind and a wider mix of vegetables.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# GlutenFreeDiet is claimed: every ingredient below is naturally gluten-free
# and there is no asafoetida here, which is the compound blend that keeps the
# masala rice and the puliogare off this list. The ground spices are single
# spices, not a blend cut with flour.
#
# HinduDiet is this site's beef-free marker, a fact about composition rather
# than a claim about who should eat it — see CLAUDE.md.
#
# Vegan and Dairy-free are deliberately absent: the ghee puts milk in the pot.
# Swap it for a neutral oil and both would be true; see notes.
diets:
  - label: Vegetarian
    schema: VegetarianDiet
  - label: Gluten-free
    schema: GlutenFreeDiet
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
        1.5 tbsp of ghee. Swap in a neutral oil and the pot has no milk in it
        at all.
  may_contain:
    - id: gluten
      note: >-
        Only a shared-line risk. Ground spice tins are often packed on lines
        that also handle cereals. None of the spices here is a blend cut with
        wheat flour, unlike asafoetida, which this recipe does not use.
  note: >-
    Nothing in the pot is fish, egg, soy, peanuts or tree nuts. Buy certified
    spice tins if a coeliac is eating.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/aloo-masoor-dal.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished aloo
  masoor dal, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 3 servings
prep_time: PT5M
cook_time: PT30M
total_time: PT35M
prep_time_display: 5 min
cook_time_display: 30 min
total_time_display: 35 min

# Ingredient cost for the whole pot at German supermarket prices, rounded up.
# An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "3.00"
keywords:
  - instant pot
  - pressure cooker
  - masoor dal
  - aloo dal
  - red lentil dal
  - one pot
  - gluten-free
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Fine-mesh strainer
  - Wooden spoon or spatula

ingredients:
  - name: Tadka
    items:
      - 1.5 tbsp ghee, or a neutral oil
      - 1 tsp cumin seeds
  - name: Aromatics
    items:
      - 1 medium onion, about 150 g, finely chopped
      - 4 garlic cloves, minced
      - 1 inch piece ginger, about 10 g, grated
      - 1 large tomato, about 150 g, finely chopped
  - name: Spices
    items:
      - 1/2 tsp turmeric powder
      - 3/4 tsp red chilli powder, or to taste
      - 1 tsp ground coriander
      - 1.25 tsp salt
  - name: Dal, potato and water
    items:
      - 200 g masoor dal, split red lentils, rinsed until the water runs clear
      - 1 large potato, about 200 g, peeled and cut into 1.5 cm dice
      - 840 ml water
  - name: To finish
    items:
      - 1/2 tsp garam masala

steps:
  - name: Preheat the pot
    appliance: Sauté
    setting: Medium
    duration: 1 min
    text: >-
      Set the Instant Pot to Sauté on Medium. Wait a minute for the display
      to read Hot, then add 1.5 tbsp ghee to the inner pot and let it melt.

  - name: Bloom the cumin
    appliance: Sauté
    setting: Medium
    duration: 30 sec
    continues: true
    text: >-
      add 1 tsp cumin seeds to the melted ghee. Stir until they sizzle and
      turn a shade darker, about 30 seconds. Watch them closely. Cumin
      scorches within seconds once it starts to colour.

  - name: Soften the aromatics
    appliance: Sauté
    setting: Medium
    duration: 3 min
    continues: true
    text: >-
      add 1 medium onion, finely chopped, 4 minced garlic cloves and 1 inch
      of grated ginger. Stir often until the onion is soft and translucent.

  - name: Cook the tomato and spices
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      add 1 large chopped tomato, 1/2 tsp turmeric powder, 3/4 tsp red chilli
      powder, 1 tsp ground coriander and 1.25 tsp salt. Stir well and cook
      until the tomato softens and starts to break down.

  - name: Add the dal, potato and water
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      add 200 g rinsed masoor dal and 1 large potato cut into 1.5 cm dice.
      Pour in 840 ml water.

  - name: Scrape the base, then cancel
    appliance: Sauté
    duration: 1 min
    continues: true
    text: >-
      scrape the base of the pot thoroughly with a spatula until nothing is
      stuck. Any onion, tomato or spice left behind here is what trips a Burn
      warning under pressure. Press Cancel to turn off Sauté.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 6 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High
      for 6 minutes. The pot takes about 7 to 10 minutes to come up to
      pressure first.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 5 min
    text: >-
      Leave the pot undisturbed for a 5 minute natural pressure release, then
      turn the valve to Venting to let off the rest. Wait for the float valve
      to drop before opening.

  - name: Finish and mash
    text: >-
      Open the lid away from you. Sprinkle 1/2 tsp garam masala over the top
      and stir well. Press a few of the cooked potato cubes against the side
      of the pot to mash them slightly. That is what thickens the gravy.
      Serve hot.

# Estimated from the ingredient weights above and divided by three, not
# measured in a lab. Keys map one-to-one onto schema.org NutritionInformation;
# `note` is the only key here that is not a schema property.
nutrition:
  serving_size: About 520 g, a third of the pot
  calories: 400 kcal
  protein_content: 19 g
  fat_content: 8 g
  saturated_fat_content: 5 g
  unsaturated_fat_content: 3 g
  trans_fat_content: 0 g
  cholesterol_content: 15 mg
  carbohydrate_content: 64 g
  sugar_content: 6 g
  fiber_content: 10 g
  sodium_content: 970 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab. The 1.25
    tsp of salt is nearly all of the sodium; halve it and season at the table
    if you are watching it. The ghee carries most of the fat and all of the
    cholesterol, so a neutral oil instead brings both down.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It heats up faster
  and runs hotter on Sauté than a Duo. Give the tadka and the aromatics
  another minute each on a Duo or a Lux. Swap the ghee for a neutral oil to
  make the dish vegan and dairy-free; nothing else about the method changes.
  Stir a squeeze of lemon or a handful of chopped coriander through at the
  end if you have either. Thick toasted bread, buttered and pan-crisped, is
  the classic way to eat this. Tear off a piece and dunk it in while the dal
  is still hot.
---
