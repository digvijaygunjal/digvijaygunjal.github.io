---
title: Butter Chicken
date: 2026-08-29
description: Murgh makhani in a pressure cooker. Yoghurt-marinated thigh seared on Sauté, a cashew-and-tomato makhani gravy pressure cooked for 5 minutes and blended smooth, then the chicken simmered back into it and finished with cream, cold butter and kasoori methi.
eyebrow: Instant Pot · North Indian · Gluten-free
alternate_names:
  - Murgh Makhani
  - Murg Makhani
  - Indian Butter Chicken
disambiguating_description: >-
  The Punjabi makhani gravy — tomato, cashew, butter and cream, with the
  fenugreek note that defines it — around tandoori-marinated chicken. Not
  chicken tikka masala, which is a British dish built on the same marinated
  chicken but a spicier, less buttery onion-heavy sauce, and not korma, which
  is nut-and-dairy rich with no tomato at all.
cuisine: Indian
category: Main course
cooking_method: Pressure cooking

# GlutenFreeDiet is claimed: every ingredient below is naturally gluten-free
# and there is no asafoetida here, which is the compound blend that keeps the
# masala rice off this list. Garam masala is a blend but a blend of spices, not
# of flours. The shared-line caveat is in the allergen note, where a reader
# looking for it will actually be.
#
# HinduDiet is this site's beef-free marker, which is a fact about composition
# rather than a claim about who should eat it — see CLAUDE.md.
#
# LowCalorieDiet, LowFatDiet and LowSaltDiet are all deliberately absent: at
# 595 kcal and 1210 mg sodium a serving, with 60 g of butter and 100 ml of
# cream in the pot, none of the three would be true.
diets:
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
        Yoghurt in the marinade, 60 g of butter, and 100 ml of cream. Milk is
        not an optional extra here — makhani means buttery, and the butter and
        the cream are the dish. This one cannot be made safe for a milk
        allergy.
    - id: nuts
      note: >-
        40 g of raw cashews, blended into the gravy rather than scattered on
        top, so they cannot be picked out. Leave them out and the sauce is
        thinner and sharper; see notes for what to do instead.
  note: >-
    Nothing in the pot is gluten, fish, egg or soy, but ground spice blends and
    bagged cashews are both commonly packed on shared lines. Buy certified if a
    coeliac or a severe nut allergy is eating. Kasoori methi is a leaf, not a
    seed — it is not related to any of the fourteen.

# PLACEHOLDER, not a photograph. This recipe was published before the dish had
# been cooked and shot, so the hero is a plain warm panel in the site's own
# --tag colour. Replace the file with a real 4:3 photo — about 1600 px wide,
# recompressed, EXIF stripped — and rewrite `image_alt` and `image_caption` to
# describe it in the same pass.
image: /assets/images/recipes/butter-chicken.png
image_alt: >-
  A plain warm-beige panel standing in for a photograph of the finished butter
  chicken, which has not been taken yet.
image_caption: >-
  Placeholder, not a photograph — the dish has not been shot yet.

yield: 4 servings
prep_time: PT40M
cook_time: PT50M
total_time: PT1H30M
prep_time_display: 40 min
cook_time_display: 50 min
total_time_display: 1 hr 30 min

# Ingredient cost for the whole pot at German supermarket prices, rounded up.
# The chicken is about two thirds of it. An estimate, not a receipt.
estimated_cost:
  currency: EUR
  value: "11.50"
keywords:
  - instant pot
  - pressure cooker
  - butter chicken
  - murgh makhani
  - indian curry
  - chicken thigh
  - kasoori methi
  - gluten-free
tools:
  - Instant Pot Pro Max 6 qt WiFi
  - Immersion blender
  - Wooden spoon
  - Mixing bowl
  - Tongs

ingredients:
  - name: Marinade
    items:
      - 700 g boneless skinless chicken thighs, cut into 3 cm pieces
      - 120 g full-fat plain yoghurt
      - 1 tbsp ginger-garlic paste
      - 1 tbsp lemon juice
      - 1.5 tsp Kashmiri red chilli powder
      - 1 tsp garam masala
      - 0.5 tsp turmeric powder
      - 1 tsp salt
      - 1 tbsp neutral oil
  - name: Fat & whole spices
    items:
      - 40 g butter
      - 1 tbsp neutral oil, for searing
      - 1 bay leaf
      - 1 cinnamon stick, about 5 cm
      - 4 green cardamom pods
  - name: Makhani gravy
    items:
      - 1 large onion, about 180 g, roughly chopped
      - 1 tbsp ginger-garlic paste, for the gravy
      - 40 g raw cashews
      - 1 tsp Kashmiri red chilli powder, for the gravy
      - 1 tsp ground coriander
      - 0.5 tsp turmeric powder, for the gravy
      - 1 tsp salt, for the gravy
      - 120 ml water
      - 400 g tinned chopped tomatoes
      - 2 tbsp tomato purée
  - name: To finish
    items:
      - 100 ml double cream, 30% fat
      - 20 g cold butter, for finishing
      - 1 tbsp kasoori methi
      - 1 tsp garam masala, to finish
      - 2 tsp honey
      - 2 tbsp fresh coriander, chopped

steps:
  - name: Marinate the chicken
    text: >-
      In a mixing bowl, whisk 120 g full-fat plain yoghurt with 1 tbsp
      ginger-garlic paste, 1 tbsp lemon juice, 1.5 tsp Kashmiri red chilli
      powder, 1 tsp garam masala, 0.5 tsp turmeric powder, 1 tsp salt and 1
      tbsp neutral oil. Fold in 700 g boneless skinless chicken thighs cut into
      3 cm pieces until every piece is coated. Cover and refrigerate for at
      least 30 minutes; 4 to 8 hours is better and overnight is best. Use thigh
      rather than breast — 3 cm breast cubes go dry in the time the gravy needs.

  - name: Preheat the pot
    appliance: Sauté
    setting: High
    duration: 3 min
    text: >-
      Set the Instant Pot to Sauté on High for 30 minutes. Wait 2 to 3 minutes,
      until the display reads Hot, then add 1 tbsp neutral oil to the inner pot.
      Take the chicken out of the fridge now so it is not fridge-cold going in.

  - name: Sear the chicken in two batches
    appliance: Sauté
    setting: High
    duration: 8 min
    continues: true
    text: >-
      lift the chicken out of the marinade with tongs, letting the thick
      marinade drip back into the bowl, and lay half the pieces in the pot in
      one layer. Do not stir for the first 2 minutes — that is where the char
      comes from. Turn, give it 2 more minutes, then move that batch to a plate
      and sear the second. Keep whatever marinade is left in the bowl. Yoghurt
      sticks hard, so expect a brown crust on the base; that is flavour and it
      comes up at the deglaze step.

  - name: Bloom the whole spices in butter
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      reduce the level to Medium and add 40 g butter, 1 bay leaf, 1 cinnamon
      stick and 4 green cardamom pods. Count the cardamom pods in — you will
      count them out again before blending, and a pod that goes through the
      blender turns the whole gravy soapy. Stir until the butter has melted and
      the cardamom smells sweet.

  - name: Soften the onion
    appliance: Sauté
    setting: Medium
    duration: 6 min
    continues: true
    text: >-
      add 1 large onion, roughly chopped. There is no need to dice it finely —
      the gravy is blended, so chunks are fine and they release their water
      faster, which starts lifting the seared crust off the base. Cook,
      stirring every minute, until translucent and just golden at the edges.

  - name: Add the ginger-garlic and the cashews
    appliance: Sauté
    setting: Medium
    duration: 1 min
    continues: true
    text: >-
      add 1 tbsp ginger-garlic paste and 40 g raw cashews. Stir constantly so
      the paste does not catch, until the raw garlic smell is gone. The cashews
      only need to warm through — they soften under pressure, not here.

  - name: Roast the ground spices
    appliance: Sauté
    setting: Low
    duration: 30 sec
    continues: true
    text: >-
      reduce the level to Low, then add 1 tsp Kashmiri red chilli powder, 1 tsp
      ground coriander, 0.5 tsp turmeric powder and 1 tsp salt. Stir constantly
      for 30 seconds. Kashmiri chilli is there for colour more than heat, and it
      is the ingredient that scorches first — do this on Low or the gravy turns
      brown and bitter instead of red.

  - name: Deglaze the base properly
    appliance: Sauté
    setting: Low
    duration: 2 min
    continues: true
    text: >-
      pour in 120 ml water and scrape the base of the pot with a wooden spoon
      for a full two minutes, until nothing is stuck and the water has gone
      brown. Scrape the leftover marinade out of the bowl into the pot as well.
      This is the step that decides whether you get a Burn warning: a seared
      yoghurt crust left on the base will trigger it every time.

  - name: Layer the tomatoes on top, then cancel
    appliance: Sauté
    setting: Low
    duration: 30 sec
    continues: true
    text: >-
      tip 400 g tinned chopped tomatoes and 2 tbsp tomato purée on top and
      spread them level, but do not stir them in. Tomato that sinks to the base
      is thick enough to scorch under pressure; floating on the water it cannot.
      Press Cancel to turn off Sauté. The chicken stays out of the pot for now.

  - name: Pressure cook the gravy
    appliance: Pressure Cook
    setting: High
    duration: 5 min
    text: >-
      Lock on the lid and turn the valve to Sealing. Pressure cook on High for 5
      minutes. It takes about 6 to 9 minutes to come up to pressure first,
      because the pot is already hot. Five minutes is enough to collapse the
      onion and soften the cashews to the point where they blend without grit,
      which is the whole reason the gravy is cooked separately from the chicken.

  - name: Natural release for 5 minutes, then vent
    appliance: Natural Release
    duration: 5 min
    text: >-
      Leave the pot undisturbed for a 5 minute natural pressure release, then
      turn the valve to Venting and wait for the float valve to drop before
      opening. Open the lid away from you — the gravy is thick and it spits.

  - name: Fish out the whole spices and blend
    text: >-
      Find and remove 1 bay leaf, 1 cinnamon stick and all 4 green cardamom
      pods. The pods float, so look at the surface first. Then blend the gravy
      smooth with an immersion blender, right in the pot, for about a minute —
      longer than feels necessary. Restaurant makhani is completely
      unstructured; if you can still see onion, it is not done. Without an
      immersion blender, let it cool for 10 minutes, blend in a jug blender in
      two batches, and return it to the pot.

  - name: Simmer the chicken back in
    appliance: Sauté
    setting: Low
    duration: 8 min
    text: >-
      Set the pot to Sauté on Low. Return the seared chicken and any juices from
      the plate, stir once, and simmer uncovered for 8 minutes, stirring every
      couple of minutes. The chicken finishes cooking here rather than under
      pressure, which is what keeps thigh meat in pieces instead of shreds. Cut
      the largest piece open to check it is opaque through.

  - name: Finish with cream, methi and cold butter
    appliance: Sauté
    setting: Low
    duration: 2 min
    continues: true
    text: >-
      crush 1 tbsp kasoori methi between your palms straight into the pot —
      crushing is what releases it, and it is the single ingredient that makes
      this taste like butter chicken rather than tomato-cream chicken. Stir in
      100 ml double cream, 1 tsp garam masala and 2 tsp honey. Let it come to a
      bare simmer, then press Cancel and stir 20 g cold butter through off the
      heat until it disappears. Adding the cream off pressure and the butter off
      heat is what keeps the gravy glossy rather than split.

  - name: Rest and serve
    text: >-
      Leave it to stand for 5 minutes with the lid off — the gravy thickens
      noticeably as it drops below a simmer, and the salt evens out. Taste and
      adjust: more honey if the tomatoes were sharp, more salt if it tastes
      flat, a splash of hot water if it has gone past thick. Scatter 2 tbsp
      chopped fresh coriander over and serve with naan or plain basmati.

# Estimated from the ingredient weights above and divided by four, not measured
# in a lab. Keys map one-to-one onto schema.org NutritionInformation; `note` is
# the only key here that is not a schema property.
nutrition:
  serving_size: About 410 g, a quarter of the pot
  calories: 595 kcal
  protein_content: 38 g
  fat_content: 40 g
  saturated_fat_content: 17 g
  unsaturated_fat_content: 22 g
  trans_fat_content: 1 g
  cholesterol_content: 230 mg
  carbohydrate_content: 20 g
  sugar_content: 11 g
  fiber_content: 3 g
  sodium_content: 1210 mg
  note: >-
    Estimated from the ingredient weights, not laboratory-measured, and for the
    curry alone — rice or naan is on top of this. Three things dominate the
    numbers. The 60 g of butter and 100 ml of cream carry most of the fat and
    nearly all of the saturated fat. The 2 tsp of salt is almost all of the
    sodium, so halve it and season at the table if you are watching it. The
    cholesterol is high because 700 g of chicken thigh is high in it before any
    dairy is added. The trans fat is the small amount that occurs naturally in
    butter and cream, not from hydrogenated fat.

notes: >-
  Timings are calibrated for a 6 qt Instant Pot Pro Max WiFi (1200 W), which
  preheats faster and runs hotter on Sauté than a Duo. On a Duo or a Lux, give
  the sear an extra 2 minutes a batch and expect a slower rise to pressure; the
  5 minute pressure time is unchanged, because it is timed for the cashews and
  not for the meat. If you use chicken breast instead of thigh, cut it into 4 cm
  pieces and drop the final simmer to 5 minutes. For real tandoor char, spread
  the marinated chicken on a rack and grill it under a hot oven grill for 8
  minutes before it goes into the gravy — it is a second pan to wash and it is
  the biggest single upgrade to the dish. Kashmiri chilli powder is for colour;
  ordinary chilli powder at the same quantity will be considerably hotter, so
  use half of it and make up the colour with sweet paprika. Without cashews,
  blend in 2 tbsp of ground almonds at the finish or accept a thinner sauce —
  do not compensate with more cream, which makes it heavy rather than silky.
  Kasoori methi has no substitute; it is worth a trip to an Indian grocer. The
  gravy freezes well on its own for up to 3 months, so a double batch of gravy
  frozen without the chicken turns this into a 20 minute meal later.
---
