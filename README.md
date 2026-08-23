# digvijaygunjal.github.io

Recipe site built with Jekyll and served by GitHub Pages. Recipes are tuned
for the Instant Pot Pro Max. Every recipe page ships server-rendered
`schema.org/Recipe` JSON-LD — every property of `Recipe` itself, and everything
`HowTo`, `CreativeWork` and `Thing` contribute that a recipe can honestly fill
in — so recipe importers (Instant Connect / Fresco, Paprika, Mela, etc.) can
read a recipe straight from its URL.

## Layout

```
_config.yml              site settings, collection + permalinks
_layouts/default.html    shell: head, nav, footer
_layouts/recipe.html     generates JSON-LD *and* the visible page from front matter
_recipes/*.md            one file per recipe — data only, no markup
assets/css/main.css      styles
assets/images/recipes/   recipe photos
index.html               recipe index
```

## Adding a recipe

Copy `_recipes/masala-rice.md`, rename it, edit the front matter. The filename
becomes the URL: `_recipes/dal-tadka.md` → `/recipes/dal-tadka/`.

You never write HTML. The layout builds both outputs (visible page and
JSON-LD) from the same fields, so they can't drift apart.

### How these recipes are written

These conventions are the site's voice. Match them when adding a recipe:

- **Calibrated for one cooker.** Timings assume the cooker recorded under
  `appliance` in `_config.yml`. Where another pressure cooker would differ, say
  so and give the adjustment rather than staying silent.
- **Every step names its function, level and duration**, so the reader is never
  guessing which button to press or how long to hold it there.
- **Weights, not cups.** Grams and millilitres. In a sealed pot the ratio of
  grain to water decides the result, and a cup is not a reliable measure.
- **Failure modes up front.** Where a step commonly goes wrong — a Burn warning
  from an unscraped base, spices scorching on a high setting — say what happens
  and why, at the point where it matters.

### Front matter reference

Everything on a recipe page comes from these keys. The layout builds the
visible page and the `schema.org/Recipe` JSON-LD from them in the same pass, so
filling a field in fills it in for both.

**Identity**

| key | example | becomes |
|---|---|---|
| `title` | `Masala Rice` | `name` |
| `description` | one or two sentences | `description` |
| `alternate_names` | `[Tehri, Vegetable tehri]` | `alternateName` |
| `disambiguating_description` | what it is *not* | `disambiguatingDescription` |
| `identifier` | defaults to the filename slug | `identifier` |
| `author` | a name or a list; defaults to both maintainers | `author`, `creator`, `copyrightHolder` |
| `date` | `2026-08-22` | `datePublished`, `dateCreated`, `copyrightYear` |
| `updated` | `2026-08-23` | `dateModified` |
| `in_language` | defaults to `site.lang` | `inLanguage` |

**Classification**

| key | example | becomes |
|---|---|---|
| `category` | `Main course` | `recipeCategory` |
| `cuisine` | `Indian` | `recipeCuisine` |
| `cooking_method` | `Pressure cooking` | `cookingMethod` |
| `keywords` | a list | `keywords`, joined with `, ` |
| `diets` | `- label: Vegan` / `schema: VeganDiet` | `suitableForDiet` |
| `eyebrow` | the small line above the title | page only |

`diets` carries both halves on purpose: `label` is what the page shows,
`schema` is a member of schema.org's `RestrictedDiet` enumeration
(`VeganDiet`, `VegetarianDiet`, `GlutenFreeDiet`, `LowLactoseDiet`,
`LowSaltDiet`, `LowFatDiet`, `LowCalorieDiet`, `DiabeticDiet`, `HalalDiet`,
`HinduDiet`, `KosherDiet`). Keeping them in one entry stops the badge and the
structured data from claiming different things.

**Times, yield and cost**

| key | example | becomes |
|---|---|---|
| `prep_time` | `PT15M` | `prepTime` |
| `cook_time` | `PT45M` | `cookTime`, and `performTime` |
| `total_time` | `PT60M` | `totalTime`, and `timeRequired` |
| `prep_time_display` | `15 min` | page only |
| `cook_time_display` | `45 min` | page only |
| `total_time_display` | `1 hr` | page only |
| `yield` | `4 servings` | `recipeYield` and `yield` |
| `estimated_cost` | `currency: EUR`, `value: "3.50"` | `estimatedCost` |

The ISO 8601 durations and the display strings are separate because
`PT45M` is unreadable and `45 min` is unparseable. **Keep them in agreement**,
and keep `prep_time + cook_time == total_time` — some importers reject a recipe
whose durations disagree.

`estimated_cost` is what the ingredients cost for the whole pot. `currency` is
an ISO 4217 code; the page turns the common ones into a symbol.

**Contents**

| key | becomes |
|---|---|
| `tools` | `tool`, and the *Equipment* list |
| `ingredients` | `recipeIngredient` and `supply`, and the *Ingredients* list |
| `steps` | `recipeInstructions`, and the numbered method |
| `nutrition` | `nutrition`, and the *Nutrition* panel |
| `notes` | page only |

`ingredients` is a list of groups, each with a `name` and `items`. The group
names are for the reader; the structured data gets the flattened list, so a
heading can never end up inside an ingredient.

**Nutrition**

Twelve keys, one per schema.org `NutritionInformation` property, plus a `note`
that is shown to the reader and left out of the structured data:

```yaml
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
    Estimated from the ingredient weights, not laboratory-measured.
```

Figures are **per serving**. Work them out from the ingredient weights and the
yield; do not copy them from another recipe. Say in `note` that they are an
estimate and name whatever dominates them — usually the salt or the added fat.

**Optional, and empty unless you have the data**

| key | becomes |
|---|---|
| `video` | `video` as a `VideoObject` |
| `license` | `license` |
| `is_based_on` | `isBasedOn`, for an adapted recipe |
| `same_as` | `sameAs`, if published elsewhere too |
| `rating` | `aggregateRating` |
| `reviews` | `review` |

`rating` and `reviews` must come from real feedback. A rating a site awards its
own recipe is dishonest, and search engines discard the entire structured-data
block when they spot a self-serving review.

### Images

Put the file in `assets/images/recipes/`, then reference it from front matter:

```yaml
image: /assets/images/recipes/masala-rice.jpg
image_alt: A bowl of masala rice with peas, peanuts and fresh coriander.
```

The layout converts that to an **absolute** URL in the JSON-LD
(`https://digvijaygunjal.github.io/assets/...`). That matters: an importer
fetches the structured data on its own, away from the page it came from, so a
relative path has nothing to resolve against and the image is silently dropped.

Several images — importers use the first, the page shows the first as the hero:

```yaml
image:
  - /assets/images/recipes/masala-rice.jpg
  - /assets/images/recipes/masala-rice-plated.jpg
```

A single step can carry its own photo, which also lands in that step's JSON-LD:

```yaml
  - name: Bloom the whole spices
    image: /assets/images/recipes/step-tadka.jpg
```

Practical notes:
- Landscape, roughly 4:3 or 16:9, at least ~1200 px wide. The hero is cropped
  to 4:3 and index thumbnails to 1:1, so keep the food off the extreme edges.
- Use JPEG and keep files under ~500 KB; every image is committed to the repo.
- Always write `image_alt`. It is what a screen reader announces.
- The path starts with `/` — a site-root path, not a path relative to the
  markdown file.

### Step fields

| field | purpose |
|---|---|
| `name` | short step title |
| `appliance` | `Sauté`, `Pressure Cook`, `Natural Release`, or omit for a manual step |
| `setting` | `High` / `Medium` / `Low` |
| `duration` | `30 sec`, `8 min` |
| `continues` | `true` if the appliance session is already running |
| `text` | the instruction |

**Why `continues` matters.** Importers read each step in isolation. A step
that just says "add the onion" gets no appliance attached and renders as a
plain manual step, losing the Sauté indicator. With `continues: true`, the
layout emits `Sauté on Medium, 8 min. With the pot still on Sauté, add the
onion…`

So write `text` for a continuing step in lowercase, starting mid-sentence.

## The import contract

Importability is the point of this site, so treat the following as fixed. If you
change the layout, keep all of it true.

Every recipe page emits one `schema.org/Recipe` block as JSON-LD. `Recipe`
inherits from `HowTo`, `CreativeWork` and `Thing`, which between them define
148 valid properties — most of which a recipe page has no honest answer for.
What a page carries today:

| from | fields |
|---|---|
| `Recipe` | `recipeCategory`, `recipeCuisine`, `cookingMethod`, `recipeYield`, `cookTime`, `recipeIngredient`, `recipeInstructions`, `suitableForDiet`, `nutrition` — **all nine** |
| `HowTo` | `prepTime`, `totalTime`, `performTime`, `yield`, `tool`, `supply`, `estimatedCost` |
| `CreativeWork` | `author`, `creator`, `publisher`, `datePublished`, `dateCreated`, `dateModified`, `copyrightYear`, `copyrightHolder`, `copyrightNotice`, `keywords`, `inLanguage`, `thumbnailUrl`, `timeRequired`, `isAccessibleForFree`, `isFamilyFriendly` |
| `Thing` | `name`, `image`, `description`, `alternateName`, `disambiguatingDescription`, `identifier`, `url`, `mainEntityOfPage` |

`name` and `image` are the two a consumer will refuse to import without.

Two properties are left out on purpose. `step` means the same thing as
`recipeInstructions`, and a consumer that read both and concatenated them would
import every step twice. The superseded spellings — `ingredients`, `steps`,
`reviews`, `awards`, `isBasedOnUrl` — are left out for the same reason: two
lists that can disagree are worse than one.

The property list is checked against
[schemaorg/schemaorg](https://github.com/schemaorg/schemaorg), release 30.0,
which is the repository <https://schema.org/Recipe> is published from. Read
`data/releases/<version>/schemaorg-current-https.jsonld` there rather than
trusting this table.

Rules that are easy to break by accident:

1. **Images are absolute URLs.** An importer fetches the JSON-LD away from the
   page, so a relative path resolves against nothing and is dropped silently.
2. **Every step is a `HowToStep` with both `name` and `text`.** A bare string
   array imports as one undifferentiated blob.
3. **Steps restate their appliance session** (`continues: true`). Importers read
   steps in isolation; without this, an imported step loses its Sauté setting.
4. **`prepTime + cookTime == totalTime`.** Some importers reject a recipe whose
   durations disagree, others silently take the wrong one.
5. **Each step's `url` anchor resolves** to a matching `id` on the rendered
   `<li>`.
6. **Ingredients are flat strings** — quantity, unit and item on one line, since
   that is what parsers split on.

Fresco's import (used by the Instant Pot app) is AI-assisted and can read pages
that lack structured data at all, but clean JSON-LD turns a guess into a
straight read — which is what keeps the appliance settings intact.

## Testing before you push

```
bundle exec rake
```

One command. It takes about four seconds and stops at the first set that fails.
CI invokes these same Rake tasks rather than keeping a list of its own — that is
the whole point of there being one. It splits them across two jobs, so a
front-matter typo comes back in well under a minute instead of after Chromium
has downloaded, but the tasks it runs are the ones here and nothing else.

| What it reads | What it checks |
|---|---|
| `_recipes/`, `_data/`, `_config.yml` | required front matter, ISO 8601 durations that add up, allergen ids that resolve, `RestrictedDiet` values, all twelve nutrition properties, ISO 4217 currency, single-line ingredients, steps that name their appliance, images that exist, no raw HTML |
| `assets/images/` | nothing over 500 KB, nothing wider than 2000 px, no EXIF, no orphaned photos |
| the built `_site` | exactly one Recipe object, `datePublished`, absolute image URLs in the JSON-LD and relative ones in the markup, step anchors resolving both ways, `supply` matching `recipeIngredient`, no duplicated or superseded properties, allergen arithmetic, no Liquid warnings, no broken links |
| the site in Chromium | no sideways scrolling at 1280 px or 380 px, images that really loaded, the index filters, the copy-link button, and that the page fetches nothing from anyone else |

The browser set needs Node; it installs its own toolchain the first time and
lives entirely under `test/browser`. To run only the Ruby sets:

```
bundle exec rake test:sources test:import_contract
```

### What no check can do for you

These are the ones that need a person, and they are the ones a reviewer will
ask about:

- **The nutrition figures are this recipe's**, not the ones from the file you
  copied. Nothing can tell a plausible number from a right one.
- **The cost, the diets and the allergen notes are honest.** A check confirms
  `VeganDiet` is a real value; only you can confirm the dish is vegan.
- **The photo is the right photo, and was actually processed.** The checks catch
  a 3 MB file. They cannot see a crop that cuts the food in half.
- **The prose reads like the rest of the site** — see
  [How these recipes are written](#how-these-recipes-are-written).

Worth doing when you change `_layouts/recipe.html` rather than a recipe: paste a
built page into the [Schema Markup Validator](https://validator.schema.org/) or
Google's Rich Results Test. The checks assert the shape this site emits; the
validators know the whole vocabulary.

If schema.org is unreachable — a sandbox or a corporate proxy will sometimes
block it — clone <https://github.com/schemaorg/schemaorg> and read
`data/releases/<version>/schemaorg-current-https.jsonld`. That is the source
the website is published from, so it answers the same questions.

## Local preview

```
bundle install
bundle exec jekyll serve
```

Needs Ruby. You can skip it and just push — GitHub Pages builds Jekyll
natively on every commit, and no workflow in this repository deploys anything.
`.github/workflows/ci.yml` only gates merging: it runs the checks on every pull
request and uploads the built `_site`, so a reviewer can download the pages a
change would publish and open them locally.

### Which Ruby

`.ruby-version` pins **3.3.4**, which is the version GitHub Pages itself runs.
Any version manager that reads that file — rbenv, rvm, chruby, mise, asdf —
picks it up with no further configuration.

The number is not arbitrary and should not be bumped on taste. It comes from
<https://pages.github.com/versions.json>, which is what Pages publishes about
its own build environment, alongside `github-pages` 232 and Jekyll 3.10.0. The
`github-pages` gem pins the rest of the dependency tree; matching the
interpreter too is what makes a local build and the deployed one the same
build. Update it when that file changes, not before.

The macOS system Ruby will not do — it is 2.6, and `github-pages` 232 pulls in
gems that need 3.1 or newer, so `bundle install` fails outright rather than
degrading gracefully.

## Licence

[MIT](LICENSE), for everything in this repository.

| What | Covered by |
|---|---|
| Code — `_layouts/`, `_includes/`, `assets/css/` | MIT |
| Recipe prose — the method, notes and headnotes in `_recipes/` | MIT |
| Photographs — `assets/images/` | MIT |

One licence rather than the usual code/content split, because the recipes and
photographs may move to a home of their own later. Choosing content terms now
would mean licensing material that will not stay here, and a Creative Commons
grant is irrevocable once published — so the content licence is a decision for
wherever that material lands.

Note the consequence while it does live here: MIT is a software licence, and it
covers the prose and the photographs too. It is permissive and unambiguous, so
nothing about your rights is unclear — it is simply drafted for a different kind
of work than a photograph.

A bare list of ingredients and quantities is not copyrightable in the US
(37 CFR § 202.1(a)), and is treated similarly in the EU. What the licence
governs is the expression — the written method, the notes, the failure-mode
warnings — and the photographs, not the underlying facts.

Recipe pages do not emit a `license` field in their JSON-LD. Declaring MIT there
would tell an importer the recipe is under a software licence, which is a claim
about code rather than about a recipe. The field stays absent until the content
has terms of its own.
