---
title: Goan Cod Curry
date: 2026-09-12
description: A Goan coconut fish curry in a pressure cooker. A fresh masala of coconut, chilli and tamarind is ground from scratch and pressure cooked for 4 minutes. Coconut milk goes in after, then the cod poaches off the heat.
eyebrow: Instant Pot · Goan · Dairy-free
alternate_names:
  - Goan Fish Curry
  - Goan Coconut Fish Curry
  - Cod Curry
disambiguating_description: >-
  The coconut and tamarind curry of the Goan coast, built on a wet masala that
  is ground from scratch. It is not a Kerala meen moilee, which is pale, mild
  and thickened with nothing but coconut milk. It is not ambot tik either,
  which is sharp and hot and carries no coconut at all.
cuisine: Goan
category: Main course
cooking_method: Pressure cooking

# GlutenFreeDiet is claimed on composition: every ingredient below is
# naturally gluten-free, the coriander and cumin are whole seeds ground here
# rather than bought as a blend, and there is no asafoetida. The shared-line
# caveat belongs in the allergen note, where someone looking for it will be.
#
# LowLactoseDiet is this site's dairy-free marker, as on the masala rice. The
# fat here is coconut and coconut oil, so there is no dairy anywhere in the
# pot.
#
# HinduDiet is the beef-free marker, a fact about composition. See CLAUDE.md.
#
# VegetarianDiet and VeganDiet are ruled out by the cod. LowFatDiet and
# LowCalorieDiet are both untrue: 27 g of saturated fat a serving comes from
# the coconut milk, the grated coconut and the oil. DiabeticDiet is left off
# even though the carbohydrate is now low, because it is a claim about a whole
# diet and not about one pot.
diets:
  - label: Gluten-free
    schema: GlutenFreeDiet
  - label: Dairy-free
    schema: LowLactoseDiet
  - label: Beef-free
    schema: HinduDiet

# Declared against the fourteen of EU 1169/2011 Annex II, listed in
# _data/allergens.yml; the layout derives the "free from" list from the rest.
# Ids only — the wording lives in the data file so no two recipes phrase the
# same allergen differently.
#
# Coconut is deliberately NOT declared under `nuts`. The fourteen define tree
# nuts as a closed list of eight, and coconut is not one of them. US labelling
# has historically counted it as a tree nut, which is a real difference and is
# why the recipe-level note spells it out rather than leaving it implied.
allergens:
  present:
    - id: fish
      note: >-
        475 g of cod, which is the dish. There is no version of this without
        it. The gravy is good on its own with peas or green beans. Cook it to
        the end of the coconut milk step and stop there.
  may_contain:
    - id: sulphites
      note: >-
        Two possible routes, both on the label. Tamarind concentrate sold in
        jars is sometimes preserved with sulphites. Dried red chillies are
        sometimes treated to hold their colour. Fresh lime juice and Kashmiri
        chilli powder avoid both.
  note: >-
    There is a lot of coconut here, in three forms. Coconut is not one of the
    fourteen and the EU does not count it as a tree nut. US labelling has
    treated it as one, so anyone avoiding tree nuts on American advice should
    know it is in the pot. Ground spices and frozen fish are both commonly
    packed on shared lines. Buy certified if a coeliac is eating. Frozen cod
    is sometimes glazed or brined, so check the pack if you are watching salt.

# PLACEHOLDER, not a photograph. This recipe was written up before the dish
# had been cooked and shot, so the hero is a plain warm panel in the site's
# own --tag colour. Replace the file with a real 4:3 photo, about 1600 px
# wide, recompressed and EXIF stripped, and rewrite `image_alt` and
# `image_caption` to describe it in the same pass.
image: /assets/images/recipes/goan-cod-curry.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished Goan
  cod curry, which has not been taken yet.
image_caption: >-
  A placeholder, not a photograph. The dish has not been shot yet.

yield: 4 servings
prep_time: PT15M
cook_time: PT40M
total_time: PT55M
prep_time_display: 15 min
cook_time_display: 40 min
total_time_display: 55 min

# Ingredient cost for the whole pot at German supermarket prices, rounded up.
# The cod is more than half of it and moves the most: frozen loins were priced
# around 14 EUR a kilo at REWE. An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "13.50"
keywords:
  - instant pot
  - pressure cooker
  - goan fish curry
  - cod curry
  - coconut curry
  - tamarind
  - dairy-free
  - gluten-free
tools:
  - Instant Pot Pro 10-in-1 5.7 L WiFi
  - Blender or food processor
  - Wooden spoon
  - Mixing bowl
  - Ladle

ingredients:
  - name: Cod
    items:
      - 475 g skinless cod loin, thawed and cut into 4 cm chunks
      - 0.25 tsp turmeric powder
      - 0.25 tsp salt
      - 1 tbsp lime juice
  - name: Ground masala
    items:
      - 80 g fresh or frozen grated coconut, thawed
      - 2 medium red onions, about 300 g, roughly chopped
      - 2 medium ripe tomatoes, about 250 g, roughly chopped
      - 4 dried Kashmiri red chillies, stalks removed
      - 4 garlic cloves
      - 15 g fresh ginger, peeled
      - 1 tsp coriander seeds
      - 0.5 tsp cumin seeds
      - 350 ml warm water, for blending and rinsing
  - name: Gravy
    items:
      - 2 tbsp coconut oil
      - 1 small onion, about 80 g, finely sliced
      - 400 ml tinned full-fat coconut milk
      - 1 tsp tamarind paste
      - 1.25 tsp salt, for the gravy
  - name: To finish
    items:
      - 3 tbsp fresh coriander, chopped
      - 1 lime, cut into wedges

steps:
  - name: Season the cod and leave it
    text: >-
      Pat 475 g of cod dry and cut it into 4 cm chunks. Toss them gently with
      0.25 tsp turmeric powder, 0.25 tsp salt and 1 tbsp lime juice. Leave the
      bowl on the counter while you make the masala. Cod is soft and the salt
      firms the surface, so it holds together later. Cut the chunks no smaller
      than 4 cm. Small pieces fall apart in the gravy.

  - name: Blend the masala smooth
    text: >-
      Put 80 g grated coconut, the chopped onions and tomatoes, 4 dried
      chillies, 4 garlic cloves, 15 g ginger, 1 tsp coriander seeds and 0.5
      tsp cumin seeds in a blender. Add 120 ml of the warm water. Blend for a
      full 2 minutes, until no grit is left. Coconut and coriander seed are
      the two that stay coarse. Keep the other 230 ml of water beside the pot.

  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High. Wait until the display reads Hot,
      which takes about 3 minutes, then add 2 tbsp coconut oil.

  - name: Soften the sliced onion
    appliance: Sauté
    setting: Medium
    duration: 4 min
    continues: true
    text: >-
      drop the level to Medium. Add 1 small onion, finely sliced, and cook
      until soft and translucent. This onion stays in pieces and gives the
      gravy some texture, since everything else was blended.

  - name: Cook the masala out
    appliance: Sauté
    setting: Medium
    duration: 5 min
    continues: true
    text: >-
      pour in the blended masala. Stir every minute for 5 minutes, until it
      darkens and smells sweet. Do this on Medium. On High the coconut catches
      and turns bitter. The pressure step finishes the job, so the oil does
      not have to separate yet.

  - name: Deglaze, then cancel
    appliance: Sauté
    setting: Low
    duration: 2 min
    continues: true
    text: >-
      drop the level to Low. Rinse the blender with the remaining 230 ml water
      and pour it in. Scrape the base with a wooden spoon until nothing is
      stuck at all. Stir in 1.25 tsp salt and press Cancel. This is the step
      that decides whether you get a Burn warning. A blended masala is thick
      and it sits on the base, so scrape it properly.

  - name: Pressure cook the masala
    appliance: Pressure Cook
    setting: High
    duration: 4 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for
      4 minutes. The pot is already hot, so it reaches pressure in about 8
      minutes. Four minutes under pressure collapses the onion and takes the
      raw edge off the ground coconut and the coriander seed. That is work
      that would need 20 minutes of simmering.

  - name: Quick release
    appliance: Quick Release
    duration: 2 min
    text: >-
      Turn the valve to Venting straight away. Open the lid away from you once
      the float valve has dropped. The masala spits, and it stains. It should
      look deep red now and taste round instead of sharp.

  - name: Stir in the coconut milk
    appliance: Sauté
    setting: Low
    duration: 4 min
    text: >-
      Set the pot to Sauté on Low. Stir in 400 ml coconut milk and 1 tsp
      tamarind paste. Bring it to a bare simmer, with a few slow bubbles and
      no more. Coconut milk splits at a hard boil, which is why it was kept
      out of the pressure step. Taste it now and add salt if it needs it.

  - name: Slide the cod in, then turn the pot off
    appliance: Sauté
    setting: Low
    duration: 1 min
    continues: true
    text: >-
      lower the cod in one layer and spoon gravy over each piece until it is
      covered. Press Cancel. The pot holds enough heat to cook the fish
      through with nothing on under it.

  - name: Poach the cod off the heat
    text: >-
      Rest the lid on top without sealing it, and leave the pot alone for 8
      minutes. Do not stir. Lift the whole pot and swirl it if you need to mix
      it. The fish is done when it is opaque through and flakes at a fork. If
      it is still glassy in the middle, give it 2 minutes on Sauté on Low.

  - name: Finish and serve
    text: >-
      Scatter 3 tbsp of chopped fresh coriander over the top. Serve in wide
      bowls over hot steamed basmati, with lime wedges at the table. The gravy
      is thin and there is a lot of it, which is the point of this one. Add a
      squeeze of lime at the table if it tastes flat.

# Estimated from the ingredient weights above and divided by four, not
# measured in a lab. Keys map one-to-one onto schema.org NutritionInformation;
# `note` is the only key here that is not a schema property.
nutrition:
  serving_size: About 465 g, a quarter of the pot
  calories: 465 kcal
  protein_content: 25 g
  fat_content: 32 g
  saturated_fat_content: 27 g
  unsaturated_fat_content: 5 g
  trans_fat_content: 0 g
  cholesterol_content: 50 mg
  carbohydrate_content: 20 g
  sugar_content: 9 g
  fiber_content: 4 g
  sodium_content: 960 mg
  note: >-
    Estimated from the ingredient weights, not measured in a lab, and for the
    curry on its own. Rice is on top of this. Coconut dominates the numbers.
    The 400 ml of coconut milk, the 80 g of grated coconut and the 2 tbsp of
    coconut oil carry almost all of the fat. They also make the saturated fat
    unusually high for a fish dish, at about 27 g a serving. The 1.5 tsp of
    total salt is nearly all of the sodium. Drop it to 1 tsp and season at the
    table if you are watching it. Cod itself is very lean, so the 25 g of
    protein arrives with only about 3 g of fat.

notes: >-
  Timings are for a 5.7 L Instant Pot Pro 10-in-1 WiFi. On a Duo or a Lux, expect a
  slower rise to pressure and give the masala 2 extra minutes on Sauté. The 4
  minute pressure time is for the ground masala and does not change. Cod is the
  reason the fish never goes under pressure. Even one minute sealed turns 4 cm
  chunks into threads. Any firm white fish works the same way: pollock, hake,
  haddock or tilapia all poach in the same 8 minutes. Kingfish or salmon steaks
  on the bone want 12 minutes and a cooler gravy. 475 g of cod across four
  people is a light portion of fish, and the gravy is what fills the plate.
  Serve it to three for a fuller one, or add 200 g of green beans or peas after
  the coconut milk goes in. With desiccated coconut, use 40 g and soak it in 80
  ml of hot water for 15 minutes before blending. Dry desiccated coconut will
  not blend smooth and the gravy comes out gritty. Kashmiri chillies are mild
  and are there for colour. Ordinary dried chillies at the same count are much
  hotter, so use two. For a thicker gravy, simmer it on Sauté on Low for 5
  minutes before the fish goes in. The gravy freezes well on its own for up to
  3 months. Freeze it without the fish and this becomes a 15 minute meal later.
  Leftovers keep 2 days in the fridge. Reheat them gently, because a hard boil
  breaks both the coconut milk and the fish.
---
