# Contributing

Thank you for wanting to add to this. Most contributions here are a new recipe,
a correction to one that is already published, or a fix to the layout that
generates every page.

## What this site is for

These are pressure-cooker recipes, timed against one specific cooker, published
so that **every recipe page stays importable by URL**. Somebody pastes a link
into Fresco, Paprika, Mela or the Instant Brands Connect app, and the whole
recipe — ingredients, steps, times, appliance settings — arrives filled in.

That single rule is why the structure below is fussier than a folder of notes
would be. Every field exists because an importer reads it. When a change would
make a page look better but read worse to a machine, the machine wins.

## Reporting something rather than fixing it

Open an issue and pick the form that fits: **Import failure** when a recipe app
read a page wrongly, **Recipe correction** when the cooking is wrong, **Recipe
request** for a dish you would like worked out, **Site bug** for a page that
does not render. Blank issues are turned off, because every one of those needs
a detail people reliably forget — which app, which cooker, how wide the window
was — and asking for it up front saves a round trip.

Security problems and code of conduct concerns do not go in an issue at all.
Both are linked from the new-issue page, and both go to a private form.

## Adding a recipe

Copy an existing file in `_recipes/`, rename it, and edit the front matter:

```
cp _recipes/masala-rice.md _recipes/dal-tadka.md
```

The filename becomes the URL: `_recipes/dal-tadka.md` → `/recipes/dal-tadka/`.

Every key you can set is tabulated in
[README → Front matter reference](README.md#front-matter-reference), and the
per-step keys in [README → Step fields](README.md#step-fields). Read those
rather than inferring the shape from the file you copied — a recipe can be
missing a field without looking like it is.

### Never write HTML in a recipe

A recipe file is data. `_layouts/recipe.html` builds the visible page and the
JSON-LD from the same fields in the same pass, which is what stops the two from
drifting apart. HTML in a recipe body goes into the page and not into the
structured data, so it is invisible to exactly the importer the site exists for.

If a recipe needs something the layout cannot express, **extend the layout** —
then every recipe gains it, and the new thing lands in both outputs.

### The four fields you must work out, and must not copy

Most front matter transcribes the recipe. Four fields *describe* it, and have a
different answer for every dish. Copying them from the file you started from is
worse than leaving them out, because **a wrong number is believed and an absent
one is not.**

- **`nutrition`** — add up the ingredient weights, divide by the yield. State
  the serving size as a weight. Use `nutrition.note` to say the figures are
  estimated from ingredient weights rather than laboratory-measured, and to name
  whatever dominates them — almost always the salt, the added fat, or both.
- **`estimated_cost`** — the ingredients for the whole pot, not per serving.
  Round up, and say in a comment which shops it is an estimate for.
- **`diets`** — claim only what the ingredient list actually supports, and check
  the compound ingredients before claiming anything. Commercial asafoetida is
  usually cut with wheat flour, which is why the masala rice is not labelled
  gluten-free; ghee, paneer, curd and butter each rule out `VeganDiet`. Where
  the answer depends on which brand the cook buys, leave the claim off and
  explain in `notes`.
- **`alternate_names`** and **`disambiguating_description`** — the names the
  dish is genuinely known by, and the near neighbour it gets mistaken for. Both
  exist so a reader and a search engine can tell this dish from a similar one,
  so a vague answer is no answer.

`updated` is the modification date. Bump it when the method or the quantities
change, not when a typo is fixed.

## The house voice

The conventions are set out in
[README → How these recipes are written](README.md#how-these-recipes-are-written).
The three that get missed:

- **Weights, not cups.** Grams and millilitres. In a sealed pot the ratio of
  grain to water decides the result, and a cup is not a reliable measure of
  either.
- **Every step names its function, level and duration** — `Sauté`, `Medium`,
  `8 min` — so the reader is never guessing which button to press or how long to
  hold it there. A step that continues a session already running sets
  `continues: true`, and its `text` starts lowercase, mid-sentence: the layout
  prepends the appliance context, because an importer reads each step in
  isolation and a step that does not restate its session loses it.
- **Failure modes at the point where they happen.** A Burn warning from an
  unscraped base, spices scorching on a high setting — say what goes wrong and
  why, in the step where it goes wrong, not in a note at the bottom.

All timings assume the cooker recorded under `appliance` in `_config.yml`. Where
another pressure cooker would need a different time, say so and give the
adjustment rather than staying silent.

## Allergens and diets

Every recipe declares both, because "can I eat this" gets asked before the
ingredient list is read, not after.

**Allergens** reference `_data/allergens.yml` **by `id`, never by name**:

```yaml
allergens:
  present:
    - id: peanuts
      note: Cooked into the rice, so they cannot be picked out.
  may_contain:
    - id: gluten
      note: Only through the asafoetida, which is usually cut with wheat flour.
  note: An optional caveat for the whole recipe.
```

The data file holds the fourteen allergens of Annex II to Regulation (EU) No
1169/2011 — a strict superset of the US "Big 9" — and the wording lives there so
that no two recipes phrase the same allergen differently. The layout derives the
"free from" list by subtracting what a recipe declares from the fourteen, so the
three lists always add up, and adding an entry to the data file makes every
recipe claim *less*, never more.

**Diets** carry a visible `label` and a `schema` value:

```yaml
diets:
  - label: Vegan
    schema: VeganDiet
```

Only eleven `schema` values mean anything to a consumer — `LowFatDiet`,
`VegetarianDiet`, `VeganDiet`, `HinduDiet`, `GlutenFreeDiet`, `KosherDiet`,
`LowLactoseDiet`, `LowSaltDiet`, `DiabeticDiet`, `HalalDiet`, `LowCalorieDiet`.
Anything else is silently ignored, so it reads as a claim on the page while
meaning nothing to the app that imported it.

`HinduDiet` is claimed where a recipe is beef-free, which is a fact about what
is in the pot. `HalalDiet` and `KosherDiet` are **deliberately not claimed** —
they depend on how ingredients were sourced, slaughtered and prepared, which a
recipe cannot know about the cook's kitchen or the reader's shop.

## Images

The full workflow, including the multi-image and per-step forms, is in
[README → Images](README.md#images). Before you commit a photo:

- **Resize and recompress.** Roughly 1600 px wide, under ~500 KB. Git keeps
  every version of every binary forever: an unprocessed phone photo bloats the
  clone permanently, and deleting it in a later commit does not undo that — the
  blob stays in history, and getting it out means rewriting history for everyone.
- **Strip EXIF.** Phone photos carry GPS coordinates, and this repository is
  public.
- **Always write `image_alt`.** It is what a screen reader announces.
- The hero crops to 4:3 and index thumbnails to 1:1, so keep the food away from
  the extreme edges.

## Editor and line endings

`.editorconfig` and `.gitattributes` are committed, and between them they mean
you should never see a whole-file diff you did not cause. Most editors read
`.editorconfig` directly; a few need a plugin, and it is worth installing.

UTF-8, LF line endings, a final newline, no trailing whitespace, two-space
indent. YAML is where this matters most: recipe front matter and
`_data/allergens.yml` are both YAML, and an indentation slip there is a change
of meaning rather than of appearance — a key moves into or out of a mapping and
the page silently loses a field.

## Running the checks

```
bundle config set path 'vendor/bundle'
bundle install
bundle exec rake
```

That is the whole story. It builds the site and runs every check, cheapest
first, and stops at the first set that fails — so a front-matter typo fails in
under a second rather than after a browser has started. What each set covers is
tabulated in [README → Testing before you push](README.md#testing-before-you-push).

The browser set needs Node and installs its own toolchain the first time it
runs. Without Node, run the two Ruby sets on their own:

```
bundle exec rake test:sources test:import_contract
```

CI runs the same tasks on every pull request, in two jobs — the Ruby sets
first, the browser set only if those passed. So there is nothing to reproduce
from a red check: whatever CI ran, the command above runs.

### When something fails

A failure names the file and the rule before you read a word of it —
`StepsTest#test_dal_tadka__continuing_steps_read_as_a_continuation` — and the
message says why the rule exists. Fix the recipe, not the check: a rule that
looks wrong is worth arguing about in an issue, and every one of them was added
because something broke silently.

Two things the checks cannot do for you, both listed in full in the README:
whether the nutrition figures are *this* recipe's rather than the file you
copied, and whether the photograph was genuinely processed. A wrong number is
believed; an absent one is not.

Note that `jekyll serve` rewrites `site.url` to localhost, which makes a broken
absolute URL resolve anyway. Preview with it if you like, but verify with
`bundle exec rake`, which builds.

## Branches, pull requests and review

- **Branch off `main`.** Nothing is committed to `main` directly.
- **One concern per pull request.** A recipe, or a layout fix, or a docs change
  — not two of them.
- **Stack branches** when work builds on work that is not merged yet: base the
  second branch on the first, and say so in the description.
- A merged PR cannot carry new work. Start again from the latest `main`.

The pull request template lists the checks that fail *silently* — the ones
where nothing errors and the page still looks fine. Please tick them honestly.
If you could not verify something, say so in the last section rather than
ticking it: an admitted gap costs one review comment, an unfounded tick costs a
broken import. The list is kept short so that it actually gets read.

Changes to `_layouts/`, `_includes/`, `_data/`, `_config.yml` and `.github/`
automatically request a review from a code owner, because a change to any of
them affects every page at once — see [.github/CODEOWNERS](.github/CODEOWNERS).
`_recipes/` and `assets/images/` are deliberately left unowned: a recipe is
additive and self-contained, so adding one is not gated on anybody being
available.

## Where the documentation lives

Three files, deliberately aimed at three readers:

| File | Written for |
|---|---|
| [README.md](README.md) | someone looking at the repository — what it is, and the full field reference |
| **CONTRIBUTING.md** | someone about to change something |
| [CLAUDE.md](CLAUDE.md) | Claude Code working in the repository |

They overlap on purpose, and they must agree. If you change a rule in one,
change it in the others in the same pull request.

They also link into each other by anchor, and `bundle exec rake` checks that
every one of those anchors still points at a heading that exists. A markdown
anchor does not error when it breaks — the reader lands at the top of the file
and never learns they missed the paragraph the link was for — so renaming a
heading is safe here in a way it is not in most repositories: the checks will
name every link that has to follow it.

## Code of conduct

Everyone taking part here — issues, pull requests, review — is covered by the
[Code of Conduct](CODE_OF_CONDUCT.md), which is Contributor Covenant 2.1.
Reports go to the private form linked in its *Enforcement* section, not to a
public issue.
