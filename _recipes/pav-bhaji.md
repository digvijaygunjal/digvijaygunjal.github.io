---
title: Pav Bhaji
date: 2026-09-19
description: Mumbai pav bhaji in a pressure cooker. Potato, cauliflower, carrot and peas cook for 8 minutes under pressure, then mash into a buttery tomato masala. Served with soft rolls toasted in butter and pav bhaji masala.
eyebrow: Instant Pot · Mumbai street food · Vegetarian
alternate_names:
  - Pao Bhaji
  - Mumbai Pav Bhaji
  - Bhaji Pav
disambiguating_description: >-
  The Mumbai street dish: mixed vegetables mashed into a buttery tomato masala,
  eaten with soft rolls toasted in butter. It is not a dry sabzi. The
  vegetables are mashed to a thick mixture you scoop with bread. It is also
  not tawa pulao, the rice dish cooked on the same griddle with the same spice
  blend.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# VeganDiet and LowLactoseDiet are both out: 100 g of butter is in the pot and
# on the pav, and pav bhaji without butter is a different dish.
#
# GlutenFreeDiet is out because the pav are wheat rolls. The bhaji on its own
# is gluten-free apart from the spice blend, which is covered in the notes.
#
# HinduDiet is this site's beef-free marker, which is a fact about composition
# rather than a claim about who should eat it. See CLAUDE.md.
#
# LowFatDiet, LowCalorieDiet and LowSaltDiet would all be untrue at 540 kcal
# and 1060 mg sodium a serving.
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
    - id: gluten
      note: >-
        The pav are wheat rolls. The bhaji itself has no gluten grain in it, so
        serve it with rice or a gluten-free roll and check the spice blend.
    - id: milk
      note: >-
        100 g of butter in total: 20 g at the start, 40 g stirred through the
        mash, and 40 g for toasting the pav and topping the bowls. Cook the
        bhaji in oil for a dairy-free version. It will taste flatter, and that
        is the honest trade.
  may_contain:
    - id: soybeans
      note: >-
        Only through the rolls. Soft white rolls are often made with soya
        flour or soya lecithin. The label lists it where it is there.
    - id: eggs
      note: >-
        Only through the rolls. Mumbai pav is eggless, and some shop-bought
        soft rolls are enriched with egg. Read the label if it matters.
  note: >-
    The two things to read the label on are the rolls and the pav bhaji
    masala. Some spice blends carry asafoetida, which is usually cut with
    wheat flour. Nothing else here comes near the fourteen.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/pav-bhaji.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished pav
  bhaji, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 6 servings
prep_time: PT20M
cook_time: PT55M
total_time: PT1H15M
prep_time_display: 20 min
cook_time_display: 55 min
total_time_display: 1 hr 15 min

# Ingredient cost for the whole pot at German supermarket prices, rounded up.
# The twelve pav are about a quarter of it. An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "9.50"
keywords:
  - instant pot
  - pressure cooker
  - pav bhaji
  - mumbai street food
  - one pot
  - vegetarian
  - pav bhaji masala
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Potato masher
  - Wooden spoon
  - Wide frying pan

ingredients:
  - name: Fat & aromatics
    items:
      - 20 g butter
      - 1 tbsp neutral oil
      - 150 g red onion, finely chopped
      - 1 tbsp ginger-garlic paste
      - 200 g tomatoes, finely chopped
      - 100 g green pepper, finely chopped
  - name: Spices
    items:
      - 2 tbsp pav bhaji masala
      - 1.5 tsp Kashmiri red chilli powder
      - 0.25 tsp turmeric powder
      - 1.5 tsp salt
  - name: Vegetables
    items:
      - 500 g floury potatoes, peeled and cut into 2 cm dice
      - 150 g cauliflower, cut into small florets
      - 100 g carrot, cut into 1 cm dice
      - 100 g green peas, fresh or frozen
      - 300 ml water
  - name: To finish
    items:
      - 40 g butter, for the mash
      - 1 tbsp lemon juice
      - 15 g fresh coriander, chopped
  - name: To serve
    items:
      - 12 pav, or soft white dinner rolls
      - 40 g butter, for toasting the pav and topping the bowls
      - 1 tsp pav bhaji masala, for the pav
      - 80 g red onion, finely chopped
      - 1 lemon, cut into wedges

steps:
  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High for 30 minutes. Wait 2 to 3 minutes,
      until the display reads Hot, then add 20 g butter and 1 tbsp oil. The oil
      raises the smoke point, so the butter browns slowly instead of burning.

  - name: Soften the onion
    appliance: Sauté
    setting: Medium
    duration: 6 min
    continues: true
    text: >-
      reduce the level to Medium and add 150 g finely chopped red onion. Cook,
      stirring every minute, until soft and translucent. The pot heats only
      from the base, so this takes longer than a frying pan would.

  - name: Cook the ginger and garlic
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      add 1 tbsp ginger-garlic paste. Stir constantly so it does not catch on
      the base. Stop when the raw garlic smell has gone.

  - name: Cook down the pepper and the tomato
    appliance: Sauté
    setting: Medium
    duration: 5 min
    continues: true
    text: >-
      add 100 g finely chopped green pepper and 200 g finely chopped tomatoes.
      Cook until the tomatoes collapse and the mixture starts to pull away from
      the base. Tomato still in pieces here will still be in pieces after the
      mashing.

  - name: Roast the masala
    appliance: Sauté
    setting: Low
    duration: 30 sec
    continues: true
    text: >-
      reduce the level to Low, then add 2 tbsp pav bhaji masala, 1.5 tsp
      Kashmiri red chilli powder, 0.25 tsp turmeric powder and 1.5 tsp salt.
      Stir for 30 seconds. Kashmiri chilli carries the red colour and little
      heat, and it scorches before anything else does. On High it goes brown
      and bitter in seconds.

  - name: Add the vegetables and the water
    appliance: Sauté
    setting: Low
    duration: 2 min
    continues: true
    text: >-
      add 500 g diced potato, 150 g cauliflower florets, 100 g diced carrot and
      100 g green peas. Pour in 300 ml water. Scrape the base with a wooden
      spoon for a full minute, until nothing is stuck. A speck of masala left
      on the base is the usual cause of a Burn warning. Press Cancel to turn
      off Sauté.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 8 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      8 minutes. The pot is already hot, so it takes about 8 to 12 minutes to
      come up to pressure first. Eight minutes leaves the potato and the
      cauliflower soft enough to mash with no effort.

  - name: Natural release for 10 minutes, then vent
    appliance: Natural Release
    duration: 10 min
    text: >-
      Leave the pot undisturbed for a 10 minute natural pressure release. Then
      turn the valve to Venting and stand back. Wait for the float valve to
      drop before opening. A quick release straight after cooking spits starchy
      liquid through the valve.

  - name: Mash the bhaji
    text: >-
      Open the lid away from you. Mash everything in the pot with a potato
      masher, working round the edges first and then through the middle. Aim
      for a thick mash that still has some texture. A stick blender turns it
      gluey, because it works the potato starch too hard.

  - name: Simmer with butter, then finish
    appliance: Sauté
    setting: Low
    duration: 4 min
    text: >-
      Set the pot to Sauté on Low. Stir in 40 g butter and simmer uncovered,
      stirring often, until the bhaji mounds on a spoon. Press Cancel, then
      stir in 1 tbsp lemon juice and 15 g chopped fresh coriander. It thickens
      a lot as it cools, so stop while it still looks a little loose.

  - name: Toast the pav
    text: >-
      Split 12 pav in half. Melt 30 g of the serving butter in a wide frying
      pan over medium heat and sprinkle 1 tsp pav bhaji masala into it. Press
      the cut sides of the pav into the butter. Toast until golden, about a
      minute a side, and work in batches.

  - name: Serve
    text: >-
      Spoon the bhaji into six bowls and put a small knob of the remaining
      butter on each. Serve the toasted pav alongside, with 80 g finely chopped
      raw red onion and the lemon wedges. Everyone squeezes their own lemon at
      the table.

# Estimated from the ingredient weights above and divided by six, not measured
# in a lab. Keys map one-to-one onto schema.org NutritionInformation; `note` is
# the only key here that is not a schema property.
nutrition:
  serving_size: About 340 g, a sixth of the bhaji with two pav
  calories: 540 kcal
  protein_content: 12 g
  fat_content: 19 g
  saturated_fat_content: 10 g
  unsaturated_fat_content: 9 g
  trans_fat_content: 0.5 g
  cholesterol_content: 36 mg
  carbohydrate_content: 76 g
  sugar_content: 10 g
  fiber_content: 8 g
  sodium_content: 1060 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab, and counted
    for the bhaji with two pav. Two things dominate the numbers. The 100 g of
    butter carries most of the fat, all of the saturated fat and all of the
    cholesterol. The sodium is split about evenly between the 1.5 tsp of salt
    and the rolls, so bread alone puts a floor under it. Use 1 tsp of salt and
    season at the table if you are watching it. The small trans fat figure is
    what occurs naturally in butter.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. It heats up faster and
  runs hotter on Sauté than a Duo. On a Duo or a Lux, give the onion 2 extra
  minutes and expect a slower rise to pressure. The 8 minute pressure time
  stays the same on any cooker, because it is timed for the potato. Use floury
  potatoes such as Yukon Gold, Russet or a German mehligkochend variety. Waxy
  potatoes hold their shape and fight the masher. For the deep red of a street
  stall without food colouring, add 30 g of raw beetroot, diced small, with the
  other vegetables. It colours the bhaji and you will not taste it. The bhaji
  keeps for 3 days in the fridge and thickens further, so loosen it with a
  splash of hot water when you reheat. It freezes for up to 3 months. The
  recipe is not labelled gluten-free because the pav are wheat rolls. Serve the
  bhaji with rice and it is gluten-free, as long as your spice blend says so on
  the tin. Pav bhaji masala has no real substitute. Garam masala is a different
  blend and tastes wrong here.
---
