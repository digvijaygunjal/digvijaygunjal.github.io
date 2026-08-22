# digvijaygunjal.github.io

Recipe site built with Jekyll and served by GitHub Pages. Recipes are tuned
for the Instant Pot Pro Max. Every recipe page ships server-rendered
`schema.org/Recipe` JSON-LD, so recipe importers (Instant Connect / Fresco,
Paprika, Mela, etc.) can read a recipe straight from its URL.

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

Every recipe page emits one `schema.org/Recipe` block as JSON-LD, containing:

| | fields |
|---|---|
| Required | `name`, `image` |
| Recommended | `author`, `datePublished`, `description`, `prepTime`, `cookTime`, `totalTime`, `recipeYield`, `recipeIngredient`, `recipeInstructions`, `recipeCategory`, `recipeCuisine`, `keywords`, `cookingMethod` |
| Extra | `suitableForDiet`, `tool`, per-step `url` and `image` |

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

Paste a built page into the [Schema Markup Validator](https://validator.schema.org/)
or Google's Rich Results Test. Both catch malformed JSON-LD, which is the
usual reason an import silently fails.

## Local preview

```
bundle install
bundle exec jekyll serve
```

Needs Ruby. You can skip it and just push — GitHub Pages builds Jekyll
natively on every commit, no Actions workflow needed.
