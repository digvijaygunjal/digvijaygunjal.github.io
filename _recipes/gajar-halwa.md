---
title: Gajar Halwa
date: 2026-08-23
description: Carrot halwa in a pressure cooker. Grated carrot is sautéed in ghee, then pressure cooked in milk for 3 minutes. It reduces and roasts down on Sauté until it pulls away from the pot.
eyebrow: Instant Pot · Indian sweet · Vegetarian
alternate_names:
  - Gajar ka Halwa
  - Carrot Halwa
  - Gajrela
disambiguating_description: >-
  The pressure cooker route to gajar halwa. The carrots collapse under
  pressure in a little milk in 3 minutes. The open-kadai version simmers them
  down in a litre of milk for an hour. The reducing still happens here, but
  afterwards and on Sauté, where you can see it.
cuisine: Indian
category: Dessert
cooking_method: Pressure cooking

# GlutenFreeDiet is claimed here and deliberately not on the masala rice: every
# ingredient below is naturally gluten-free, with no compounded spice blend in
# the recipe to carry wheat flour in. The cross-contamination caveat is in the
# allergen note, where a reader looking for it will actually be.
diets:
  - label: Vegetarian
    schema: VegetarianDiet
  - label: Gluten-free
    schema: GlutenFreeDiet
  - label: Beef-free
    schema: HinduDiet

# Ids only; wording lives in _data/allergens.yml. The layout derives the
# "free from" list from the other eleven.
allergens:
  present:
    - id: milk
      note: >-
        Ghee, whole milk, and the milk powder if you use it. Clarifying removes
        most of the milk protein from ghee but not all of it, which is why EU
        labelling still requires ghee declared as milk. This is not a recipe
        that can be made safe for a milk allergy.
    - id: nuts
      note: >-
        Cashews and almonds. They are stirred in at the very end, so leaving
        them out costs you the texture and nothing else.
  may_contain:
    - id: sulphites
      note: >-
        Through the raisins. Golden raisins and sultanas are usually treated
        with sulphur dioxide to stop them browning, which is what keeps them
        golden. It has to be declared above 10 mg per kg. Dark, untreated
        raisins avoid it, as does leaving the raisins out.
  note: >-
    Nothing here is gluten, but ground cardamom and chopped nuts are both
    commonly packed on shared lines; buy certified if a coeliac is eating.

image: /assets/images/recipes/gajar-halwa.jpg
image_alt: >-
  A shallow white bowl of gajar halwa on a pale wooden table. The grated
  carrot is cooked down to a deep orange and glossy with ghee, with dark
  raisins showing through it.
image_caption: >-
  Made with ordinary orange carrots, which is why it is deep orange rather than
  the red of a halwa made with winter Delhi carrots.

yield: 4 servings
prep_time: PT20M
cook_time: PT40M
total_time: PT1H
prep_time_display: 20 min
cook_time_display: 40 min
total_time_display: 1 hr

# Whole-pot ingredient cost at German supermarket prices, rounded up.
# An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "3.00"
keywords:
  - instant pot
  - pressure cooker
  - gajar halwa
  - gajar ka halwa
  - carrot halwa
  - indian dessert
  - vegetarian
  - gluten-free
  - diwali
tools:
  - Instant Pot Pro Max 6 qt WiFi
  - Box grater
  - Wooden spoon
  - Slotted spoon

ingredients:
  - name: The carrots
    items:
      - 500 g carrots, coarsely grated (about 650 g whole, before topping and peeling)
      - 50 g ghee, about 3.5 tbsp, divided
      - 120 ml whole milk
  - name: To sweeten and thicken
    items:
      - 100 g granulated sugar
      - 1 pinch salt
      - 30 g full-fat milk powder, optional, or 60 g khoya (mawa), crumbled
  - name: To finish
    items:
      - 30 g cashews and almonds, roughly chopped
      - 20 g golden raisins
      - 0.5 tsp ground green cardamom, from about 6 pods

steps:
  - name: Preheat, and melt the first of the ghee
    appliance: Sauté
    setting: Medium
    duration: 2 min
    text: >-
      Set the Instant Pot to Sauté on Medium. Wait about 2 minutes, until the
      display reads Hot, then add 1 tbsp of the ghee and let it melt. Use
      Medium, not High, throughout this recipe. Ghee smokes at a lower
      temperature than oil, and once it does, everything cooked in it
      afterwards tastes of it.

  - name: Toast the nuts, then the raisins
    appliance: Sauté
    setting: Medium
    duration: 2 min
    continues: true
    text: >-
      add 30 g roughly chopped cashews and almonds. Stir until they are pale
      gold, about 90 seconds. Then add 20 g golden raisins and give them 15
      seconds and no more. Raisins puff almost immediately and turn bitter
      long before nuts are done, so they cannot share the full time. Lift both
      out with a slotted spoon and set aside, leaving the ghee behind in the
      pot.

  - name: Sauté the carrots
    appliance: Sauté
    setting: Medium
    duration: 4 min
    continues: true
    text: >-
      add another 1 tbsp of ghee, then all 500 g of grated carrot. The
      tablespoon left from the nuts is not enough to coat this much carrot on
      its own. Stir to coat, then cook for 4 minutes, until the shreds darken
      a shade, slump and stop smelling raw. Do not skip this step to save
      time. It drives off some of the carrot's own water while the pot is
      still open, and once the lid is locked nothing evaporates at all.

  - name: Add the milk and scrape the base
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      pour in 120 ml whole milk. Scrape the base of the pot with a wooden
      spoon until nothing is stuck to it. Milk catches on a hot base faster
      than anything else in this recipe. A film left there now is the most
      likely cause of a Burn warning. Once the pot is sealed, you can no
      longer stir it loose. Level the carrots under the liquid, then press
      Cancel.

  - name: Pressure cook
    appliance: Pressure Cook
    setting: High
    duration: 3 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      3 minutes. The sugar stays out until after this. Sugar in the pot now
      would pull the water out of the shreds and set them firm. They would
      never soften after that, however long you cooked them. Use High, not
      Max. Grated carrot collapses in 3 minutes at High, and Max would take it
      to purée. The pot should seal in 5 to 8 minutes. If the float valve has
      not risen after 10, there is not enough free liquid to raise steam.
      Open up and add another 60 ml of milk.

  - name: Release the pressure straight away
    appliance: Quick Release
    duration: 2 min
    text: >-
      As soon as the timer ends, turn the valve to Venting. Do it in short
      bursts, not in one go. The contents are milky and foam easily, and a
      full release can spit through the valve. Left to release on its own, the
      pot stays hot and the carrots cook on to mush. This is the one step
      worth standing next to the pot for. Open the lid once the float valve
      drops.

  - name: Stir in the sugar
    appliance: Sauté
    setting: Medium
    duration: 3 min
    text: >-
      The carrots will be soft and sitting in a lot of thin liquid. That is
      what it is supposed to look like. Turn Sauté back on at Medium, then
      stir in 100 g sugar and a pinch of salt. For the first minute or two the
      pot gets wetter, not thicker. The sugar is dissolving and pulling yet
      more water out of the carrot. This is the point where people assume they
      have ruined it. Keep stirring for 3 minutes.

  - name: Reduce, adding the milk powder if you are using it
    appliance: Sauté
    setting: Medium
    duration: 5 min
    continues: true
    text: >-
      sprinkle 30 g full-fat milk powder over the surface a little at a time,
      stirring as you go. Tipped in all at once it clumps, and the lumps will
      not break up later. Cook for 4 to 5 minutes, stirring often. Stop when
      the loose liquid has gone and the halwa holds a shape as you drag the
      spoon through it. The milk powder is genuinely optional. It stands in
      for the slow-cooked richness of khoya. Reduce 500 g of carrot properly
      and you already have gajar halwa, which is traditionally carrots, milk,
      ghee and sugar and nothing else. Leave it out and simply reduce 2 to 3
      minutes longer here. If you are using khoya, crumble in 60 g and not 30
      g. Milk powder is dried and khoya is not, so the two are not swapped
      spoon for spoon.

  - name: The final roast
    appliance: Sauté
    setting: Medium
    duration: 4 min
    continues: true
    text: >-
      add the last 1.5 tbsp of ghee and keep the halwa moving for 3 to 4
      minutes. It will turn glossy and begin coming away from the sides of the
      pot in one mass. That pulling away is how you know it is done, not the
      colour. With ordinary orange supermarket carrots, expect a deep orange.
      The red halwa in Indian photographs is made with winter Delhi carrots.
      No amount of extra cooking will get an orange carrot there.

  - name: Finish off the heat
    text: >-
      Press Cancel. Stir in 0.5 tsp ground green cardamom and the toasted nuts
      and raisins. The cardamom goes in off the heat on purpose. Its aroma is
      fragile, and several minutes on Sauté would drive most of it off. Serve
      warm, or refrigerate and reheat with a spoonful of milk to loosen it.

# Estimated from the ingredient weights above and divided by four, not measured
# in a lab. Keys map one-to-one onto schema.org NutritionInformation; `note` is
# the only key here that is not a schema property.
nutrition:
  serving_size: About 160 g, a quarter of the pot
  calories: 380 kcal
  protein_content: 6 g
  fat_content: 19 g
  saturated_fat_content: 10 g
  unsaturated_fat_content: 9 g
  trans_fat_content: 0.4 g
  cholesterol_content: 38 mg
  carbohydrate_content: 47 g
  sugar_content: 39 g
  fiber_content: 4 g
  sodium_content: 190 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab. The optional
    milk powder is included in the figures. Of the 39 g of sugar, 25 g is the
    sugar you add. The rest is already in the carrots, the milk and the
    raisins. Cutting the added sugar changes the total less than you would
    expect. The trans fat is the small amount that occurs naturally in
    butterfat. Nearly all the saturated fat is the ghee.

notes: >-
  Timings are for a 6 qt Instant Pot Pro Max WiFi (1200 W). On a stovetop
  pressure cooker, count 2 whistles on high in place of the 3 minute pressure
  cook. Release the pressure under a running tap. The Sauté stages become an
  open pan over medium heat, and they take a few minutes longer because the
  base is narrower. Grate the carrots by hand on the coarse side of a box
  grater. A food processor chops where a grater shreds, and you lose the long
  strands that give halwa its texture. Taste a shred of raw carrot before you
  measure the sugar. Sweet winter carrots want closer to 80 g, and pale watery
  ones take the full 100 g or a little more.
---
