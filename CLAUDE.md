# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this site is

A personal recipe site at <https://digvijaygunjal.github.io>, built with Jekyll
and served by GitHub Pages from `main`. GitHub builds Jekyll natively — there is
no Actions workflow, and none is needed.

Recipes are timed against one specific cooker: an **Instant Pot Pro Max 6 qt
WiFi** (1200 W). Its details live in `_config.yml` under `appliance`; reference
them from there rather than retyping the model name.

## The one rule that outranks the others

**Every recipe page must stay importable by URL.** That is the reason this site
exists rather than being a folder of notes. A person pastes a recipe's link into
the Instant Pot app (Instant Brands Connect, whose import is powered by Fresco),
or into Paprika, Mela, Crouton or AnyList, and the whole recipe arrives filled
in.

If a change would improve the look of a page but degrade the structured data,
the structured data wins.

### The import contract

`_layouts/recipe.html` generates the visible page **and** the
`schema.org/Recipe` JSON-LD from the same front matter, so the two cannot drift.
Keep all of the following true:

1. **Images are absolute URLs in the JSON-LD, relative in `<img>` tags.** An
   importer fetches the JSON-LD away from the page, so a relative path there
   resolves against nothing and is dropped silently. The visible tag stays
   relative so the page works on any host.
2. **Every step is a `HowToStep` with both `name` and `text`.** A bare array of
   strings imports as one undifferentiated blob.
3. **Steps restate their appliance session** via `continues: true`. Importers
   read each step in isolation, so a step reading only "add the onion" loses its
   Sauté setting. The layout emits `Sauté on Medium, 8 min. With the pot still
   on Sauté, add the onion…`
4. **`prepTime + cookTime == totalTime`.** Importers disagree about what to do
   when these conflict; some reject the recipe outright.
5. **Each step's `url` anchor resolves** to a matching `id` on the rendered
   `<li>`.
6. **Ingredients are flat strings** — quantity, unit and item on one line, which
   is what parsers split on.

Required fields are `name` and `image`. All fourteen of schema.org's recommended
Recipe fields are currently populated; do not drop one to simplify a layout.

Fresco's import is AI-assisted and can read pages with no structured data at
all. Clean JSON-LD does not unlock the import — it turns a guess into a straight
read, which is what keeps the appliance settings intact.

## Repository layout

```
_config.yml              site settings, appliance, social links, collection
_layouts/default.html    shell: head, nav, footer, copy-link script
_layouts/recipe.html     builds JSON-LD *and* the page from front matter
_recipes/*.md            one file per recipe — data only, no markup
assets/css/main.css      styles
assets/images/recipes/   recipe photos
index.html               landing page + recipe index
```

## Adding a recipe

Copy `_recipes/masala-rice.md`, rename, edit the front matter. The filename
becomes the URL: `_recipes/dal-tadka.md` → `/recipes/dal-tadka/`.

**Never write HTML in a recipe.** If a recipe needs something the layout cannot
express, extend the layout so every recipe gains it.

Step fields: `name`, `appliance` (`Sauté` / `Pressure Cook` / `Natural Release`,
or omit for a manual step), `setting`, `duration`, `continues`, `text`,
optionally `image`.

Write `text` for a `continues: true` step in lowercase, starting mid-sentence —
the layout prepends the appliance context.

### How recipes are written

These conventions are the site's voice; match them:

- **Calibrated for one cooker**, with the adjustment stated where another
  pressure cooker would differ.
- **Every step names its function, level and duration** so the reader is never
  guessing which button to press.
- **Weights, not cups.** Grams and millilitres. In a sealed pot the rice-to-water
  ratio decides the result.
- **Failure modes up front.** Where a step commonly goes wrong — a Burn warning
  from an unscraped base, spices scorching on High — say what happens and why,
  at the point where it matters.

## Images

Put files in `assets/images/recipes/`, reference as a site-root path:

```yaml
image: /assets/images/recipes/masala-rice.jpg
image_alt: A bowl of masala rice with peas, peanuts and fresh coriander.
```

`image` also accepts a list; one path emits a JSON string, several emit an
array. Both are valid schema.org, but some importers mishandle an array where
they expect a string, so leave the single-image case as a string.

Before committing any photo:

- **Resize to ~1600 px wide and recompress under ~500 KB.** Git keeps every
  version of a binary forever, so a full-size phone photo bloats the clone
  permanently. A 4.3 MB source became 255 KB with no visible loss.
- **Strip EXIF.** Phone photos can carry GPS coordinates, and this repo is
  public.
- **Always write `image_alt`** — it is what a screen reader announces.
- The hero crops to 4:3 and index thumbnails to 1:1, so keep food away from the
  extreme edges.

## Building and verifying

```
bundle config set path 'vendor/bundle'
bundle install
bundle exec jekyll build
```

`vendor/`, `.bundle/`, `_site/` and `Gemfile.lock` are gitignored — do not
commit them.

Verify a change before pushing rather than assuming it worked:

- `bundle exec jekyll build` completes without error
- Both JSON-LD blocks parse as JSON, and the Recipe block still carries an
  absolute image URL and per-step anchors
- The page renders at desktop and at ~380 px

Chromium is available for screenshots. When checking an image actually loaded,
assert on `naturalWidth > 0` — a broken image still reports `complete: true`,
so a screenshot alone can mislead.

## Traps this repo has already hit

Each of these cost real debugging time. They are not hypothetical.

- **`jekyll serve` rewrites `site.url` to localhost.** That makes an incorrectly
  absolute URL resolve anyway and hides the bug. A hero image pointing at the
  production domain looked fine under `serve` and only broke when built with the
  real URL. Verify URL-sensitive changes with `jekyll build`, not `serve`.
- **The `github-pages` gem defaults to `jekyll-theme-primer`.** It overrides
  this site's CSS and breaks the build outright with `Invalid US-ASCII
  character` from a Sass partial. `theme: null` in `_config.yml` must stay.
- **`jekyll-seo-tag` reserves `site.social`** for a differently shaped hash.
  Social links therefore live under `social_links`.
- **Liquid has no `push` filter.** To build a list, capture a delimited string
  and `split` it.
- **jekyll-seo-tag also emits a `BlogPosting` JSON-LD block.** The Recipe block
  is the second `<script type="application/ld+json">` on the page — index
  accordingly when validating.

## Front-end conventions

- **No external requests.** Icons are inlined SVG; there are no CDN scripts,
  webfonts or stylesheets. Nothing on a page should break because a third party
  went away.
- **Progressive enhancement.** The copy-link button is injected by script only
  where the clipboard API exists; without it the plain URL stays visible rather
  than leaving a control that silently does nothing.
- Editorial serif look on a warm paper palette, driven by the custom properties
  at the top of `main.css`. Add colours as tokens there rather than inline.

## Git workflow

- Develop on a branch; never commit directly to `main`.
- **Do not open a pull request unless asked.** Push the branch and say it is
  ready.
- A merged PR cannot carry new work. When follow-up work is needed after a
  merge, restart the branch from the latest `main` and open a *new* PR.

## Accuracy

State what was verified and what was not. During this site's build, the exact
in-app menu path for the Instant Pot app's import feature could not be
confirmed, so the site says "find Recipe Import" rather than inventing a tap
sequence. Do the same: where a detail cannot be checked, write around it and
say so, rather than producing something plausible.
