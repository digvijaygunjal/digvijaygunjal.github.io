---
title: Kala Masala Egg Curry
date: 2026-11-22
description: A dark, hot Maharashtrian egg curry for two. Onion, coconut and kala masala brown on Sauté and pressure cook into a gravy, then boiled eggs simmer in it until the red oil rises.
eyebrow: Instant Pot · Maharashtrian · Dairy-free
alternate_names:
  - Andyachi kalwan
  - Anda rassa
  - Maharashtrian egg curry
disambiguating_description: >-
  A Maharashtrian egg curry built on kala masala, the dark roasted spice blend
  of the region, with browned onion and toasted coconut. It is not the Punjabi
  anda curry, which is a pale onion and tomato gravy with garam masala and no
  coconut. It is not the Kerala mutta roast either, which is a thick, dry
  onion fry with no thin gravy at all.
cuisine: Maharashtrian
category: Main course
cooking_method: Pressure cooking

# LowLactoseDiet is this site's dairy-free marker: the fat is oil, and there
# is no ghee, curd, cream or butter in the pot.
#
# HinduDiet is the beef-free marker, a fact about composition. See CLAUDE.md.
#
# VegetarianDiet is deliberately left off. schema.org does not say whether its
# vegetarian includes eggs, and most Indian readers would say it does not, so
# a claim either way would mislead someone. GlutenFreeDiet is left off because
# kala masala is a bought blend that often carries asafoetida, which is usually
# cut with wheat flour. VeganDiet is ruled out by the eggs.
diets:
  - label: Dairy-free
    schema: LowLactoseDiet
  - label: Beef-free
    schema: HinduDiet

# Declared against the fourteen of EU 1169/2011 Annex II, listed in
# _data/allergens.yml; the layout derives the "free from" list from the rest.
#
# Both "may contain" entries hang on the kala masala. Traditional blends grind
# in roasted sesame and many add asafoetida, but the recipe differs between
# makers and households, so neither can be declared as present for every jar.
allergens:
  present:
    - id: eggs
      note: >-
        4 boiled eggs, which are the dish. The gravy works on its own with
        boiled potatoes or chickpeas in their place.
  may_contain:
    - id: sesame
      note: >-
        Many kala masala blends grind in roasted sesame seeds. Read the packet
        you have, or ask whoever made it.
    - id: gluten
      note: >-
        Only through asafoetida, which some kala masala blends contain. It is
        usually cut with wheat flour. Check the packet if that matters.
  note: >-
    Desiccated coconut is in the base and cannot be picked out. EU rules do
    not count coconut as a tree nut, and US labelling does. Groundnut oil is a
    common choice for this curry. If you use it, the dish contains peanuts.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo, about 1600 px wide,
# recompressed and EXIF stripped, and rewrite `image_alt` and `image_caption`
# to describe it in the same pass.
image: /assets/images/recipes/kala-masala-egg-curry.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished kala
  masala egg curry, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

# The eggs boil on the hob while the base browns in the pot, so their 20
# minutes sit inside the cook time and add nothing to it. Cook time counts the
# Sauté, about 8 minutes to come up to pressure, 6 at pressure, a 5 minute
# natural release and the final simmer.
yield: 2 servings
prep_time: PT10M
cook_time: PT45M
total_time: PT55M
prep_time_display: 10 min
cook_time_display: 45 min
total_time_display: 55 min

# Ingredient cost for the whole pot at German supermarket and Indian-grocery
# prices, rounded up. Free-range eggs are most of it. The spices and curry
# leaves are counted at what this uses, not at the price of the packet. An
# estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "4.00"
keywords:
  - instant pot
  - pressure cooker
  - egg curry
  - kala masala
  - andyachi kalwan
  - anda rassa
  - maharashtrian
  - dairy-free
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Small saucepan
  - Bowl of cold water
  - Wooden spoon
  - Ladle
  - Immersion blender (optional)

ingredients:
  - name: Eggs
    items:
      - 4 large eggs
  - name: Tadka
    items:
      - 2.5 tbsp sunflower or groundnut oil
      - 1/2 tsp cumin seeds
      - 10 curry leaves
  - name: Base
    items:
      - 1 large red onion (about 150 g), finely chopped
      - 1 tbsp ginger-garlic paste
      - 3 tbsp unsweetened desiccated coconut (about 15 g)
      - 1 small tomato (about 100 g), finely chopped
      - 3/4 tsp salt, divided
  - name: Spices
    items:
      - 2 tsp kala masala
      - 1 tsp hot red chilli powder
      - 1/2 tsp turmeric powder
  - name: Gravy
    items:
      - 350 ml water
  - name: To finish
    items:
      - 1/2 tsp lemon juice
      - 2 tbsp fresh coriander, finely chopped

steps:
  - name: Boil the eggs
    text: >-
      Start the eggs first, so they cook while the base browns. Put 4 large
      eggs in a small saucepan and cover them with cold water by 2 cm. Bring
      to a rolling boil on high heat. Lower to a gentle simmer and cook for 9
      minutes for a firm yolk.

  - name: Cool, peel and score the eggs
    text: >-
      Move the eggs straight into cold water for 5 minutes, which stops the
      yolks going grey and makes them easier to peel. Peel them. Cut 3 or 4
      shallow slits down each egg so the gravy can get inside. Set them aside.

  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High. Wait until the display reads Hot,
      then add 2.5 tbsp oil to the inner pot.

  - name: Crackle the cumin and curry leaves
    appliance: Sauté
    setting: Medium
    duration: 15 sec
    continues: true
    text: >-
      reduce the level to Medium. Add 1/2 tsp cumin seeds and 10 curry leaves,
      and stand back as the leaves spit. Cumin scorches in seconds on High,
      which is why the level comes down first.

  - name: Brown the onion
    appliance: Sauté
    setting: Medium
    duration: 8 min
    continues: true
    text: >-
      add the chopped onion and a pinch of the salt. Stir every minute or so
      until it is deep golden brown all over. The colour of the onion sets the
      colour of the curry.

  - name: Toast the coconut and ginger-garlic paste
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      stir in 1 tbsp ginger-garlic paste and 3 tbsp desiccated coconut. Keep
      stirring until the coconut turns golden and smells toasted. Coconut
      catches fast, so do not walk away.

  - name: Cook the tomato and spices
    appliance: Sauté
    setting: Low
    duration: 3 min
    continues: true
    text: >-
      reduce the level to Low. Add the tomato, 2 tsp kala masala, 1 tsp chilli
      powder, 1/2 tsp turmeric and the rest of the salt. Stir until the tomato
      breaks down and oil shows at the edges. Dark ground spices burn quickly,
      which is why the level is Low.

  - name: Deglaze the base
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      pour in 350 ml water. Scrape the whole base of the inner pot with a
      wooden spoon until nothing is stuck. Any masala left on the base will
      set off the Burn warning. Press Cancel.

  - name: Pressure cook the gravy
    appliance: Pressure Cook
    setting: High
    duration: 6 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      6 minutes. The pot is already hot, so it should come up to pressure in
      about 8 minutes.

  - name: Natural release, then vent
    appliance: Natural Release
    duration: 5 min
    text: >-
      Leave the pot alone for a 5 minute natural pressure release. Then turn
      the valve to Venting and wait for the float valve to drop before you
      open the lid.

  - name: Simmer the eggs in the gravy
    appliance: Sauté
    setting: Low
    duration: 4 min
    text: >-
      Open the lid away from you. For a smooth gravy, pulse it 3 or 4 times
      with an immersion blender, or leave it rustic. Set the pot to Sauté on
      Low and lower in the 4 scored eggs. Simmer uncovered until a layer of
      dark red oil rises to the top. If the gravy is not bubbling, raise the
      level to Medium.

  - name: Finish and serve
    text: >-
      Press Cancel. Stir in 1/2 tsp lemon juice and scatter over 2 tbsp
      chopped coriander. Serve hot with steamed rice, chapati or bhakri.

# Estimated from the ingredient weights above and divided by two, not
# measured in a lab. Keys map one-to-one onto schema.org NutritionInformation;
# `note` is the only key here that is not a schema property. Worked from 200 g
# of edible egg, 32 g of sunflower oil, 150 g onion, 100 g tomato, 15 g
# desiccated coconut, 15 g ginger-garlic paste, about 10 g of ground spices
# and 4.5 g of salt.
nutrition:
  serving_size: About 375 g, half the pot with 2 eggs
  calories: 400 kcal
  protein_content: 15 g
  fat_content: 31 g
  saturated_fat_content: 9 g
  unsaturated_fat_content: 22 g
  trans_fat_content: 0 g
  cholesterol_content: 370 mg
  carbohydrate_content: 16 g
  sugar_content: 6 g
  fiber_content: 5 g
  sodium_content: 1050 mg
  note: >-
    Estimated from the ingredient weights and divided by two, not measured in
    a lab. The oil carries most of the fat, and the coconut most of the
    saturated fat. Nearly all the sodium is the 3/4 tsp of salt. The
    cholesterol is the egg yolks.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It preheats faster and
  runs hotter on Sauté than a Duo, so on a Duo give the onion a few more
  minutes. This is a small pot of gravy, so the deglazing step matters more
  than usual. A thin layer of masala stuck to the base is enough to trigger
  the Burn warning. Do not cut the water below 350 ml, because the pot needs
  enough thin liquid to build steam. If the gravy is too thin at the end,
  simmer it a few minutes longer before the eggs go in. Kala masala differs a
  lot between brands and households, and so does its heat. With a new blend,
  start with half the chilli powder and taste after pressure cooking. The oil
  is what makes the red layer on top, called tarri, so cutting it changes the
  dish. Vegetarian is not claimed on this page, because many readers do not
  count eggs as vegetarian. Leftovers keep a day in the fridge. Warm them
  gently on Sauté Low with a splash of water, because hard heat makes the
  eggs rubbery.
---
