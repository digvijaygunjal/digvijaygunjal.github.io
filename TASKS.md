# Repository setup backlog

This file exists so a second contributor can pick up work without a handover
conversation. It covers four things the repository does not have yet: a
**licence**, **contributing guidelines**, an automated **test pyramid**, and a
**CI pipeline**.

The site's one rule — *every recipe page must stay importable by URL* — is what
the tests exist to protect. Today that rule is defended entirely by prose in
`README.md` and `CLAUDE.md` and by whoever remembers to read it. Everything
below turns those paragraphs into checks that fail loudly.

Tasks are grouped into phases. Phase 0 is decisions; nothing after it can be
finished until those are made. Within a phase, tasks are ordered so each one
unblocks the next. Sizes: **S** ≈ under an hour, **M** ≈ half a day, **L** ≈ a
day or more.

---

## Phase 0 — Decisions that block the rest

These are judgement calls, not work. Record the answer in the task, then delete
this section once all four are settled.

### T0.1 — Choose the licence (or licences) · S

A recipe site is three different kinds of work in one repository, and one
licence is a poor fit for all three:

| What | Examples | Sensible licence |
|---|---|---|
| Code | `_layouts/`, `_includes/`, `assets/css/`, tests | MIT or Apache-2.0 |
| Recipe prose | the method steps, notes, headnotes in `_recipes/` | CC BY 4.0 or CC BY-SA 4.0 |
| Photographs | `assets/images/recipes/` | CC BY-NC 4.0, or all-rights-reserved |

Notes that matter for the choice:

- A bare list of ingredients and quantities is **not** copyrightable in the US
  (37 CFR § 202.1(a)) and is treated similarly in the EU. The *expression* —
  the written method, the notes, the failure-mode warnings — is. So a licence
  here governs the prose and the photos, not the facts.
- **Apache-2.0 over MIT** if you want an explicit patent grant and a contributor
  story; **MIT** if you want the shortest file that everyone recognises.
- **CC BY-SA** forces derivative recipe collections to stay open; **CC BY** does
  not. **CC BY-NC** blocks commercial reuse but is not an open licence and will
  put some contributors off.
- Do **not** apply a code licence to photographs by accident. That is the most
  common mistake in this kind of repo.

Recommendation: `LICENSE` = MIT for code, plus a `LICENSE-CONTENT` = CC BY 4.0
covering `_recipes/` and `assets/images/`, with a short table in `README.md`
saying which applies to what.

**Blocks:** T1.1, and the `license` JSON-LD field, which `CLAUDE.md` currently
records as deliberately empty ("the repository declares no licence; do not
invent one"). Once this lands, that note changes and the layout can emit it.

### T0.2 — Choose the test toolchain · S

Two credible options:

- **Ruby end to end** (recommended for tiers 1–2). Bundler and Ruby are already
  required to build the site, so contributors install nothing new. Use
  `minitest` (ships with Ruby) or `rspec`, plus `nokogiri` for HTML parsing and
  `html-proofer`, which is the standard Jekyll link/image checker.
- **Node end to end.** Only worth it if you want one language across all three
  tiers.

The browser tier (T2.3) is Playwright either way, which means a `package.json`
appears regardless. Recommendation: **Ruby for tiers 1 and 2, Node/Playwright
for tier 3** — the browser tier runs rarely and its dependency weight is
isolated in one CI job.

**Blocks:** all of Phase 2.

### T0.3 — Decide whether GitHub Pages keeps building the site · S

Right now Pages builds Jekyll natively from `main`, and `CLAUDE.md` says no
Actions workflow is needed. Adding CI does not have to change that:

- **Option A (recommended to start).** Pages keeps deploying. Actions runs
  *verification only* on pull requests and on pushes to `main`. If CI fails on
  `main`, the site still deploys — CI is a gate on merging, not on publishing.
- **Option B.** Switch the Pages source to "GitHub Actions" and deploy with
  `actions/deploy-pages`. Deployment then waits for green tests, and you are
  free of the `github-pages` gem's version pinning (currently Jekyll 3.x) — you
  could move to Jekyll 4 and modern plugins.

Option B is strictly more capable and strictly more to own: you inherit build
breakage that GitHub currently absorbs. Start at A, revisit once CI is stable.

⚠️ Whoever does this must not flip the Pages source setting casually — doing so
while no deploy workflow exists takes the live site down.

**Blocks:** T3.1.

### T0.4 — Decide whether to commit `Gemfile.lock` · S

`.gitignore` excludes it today and `CLAUDE.md` says not to commit it. That is
defensible while the `github-pages` gem is doing the pinning. But an unlocked
`Gemfile` means CI resolves dependencies fresh on every run, so a bad upstream
release breaks the build on a commit that changed nothing, and Dependabot
(T3.4) has little to act on.

Recommendation: commit it once CI exists, and update `CLAUDE.md` and
`.gitignore` in the same PR so the three stop disagreeing. Flagged rather than
done, because it reverses a documented decision.

**Blocks:** nothing, but do it before T3.4 or Dependabot will have a thin job.

---

## Phase 1 — Make the repo safe to contribute to

Nothing here needs tests or CI. It is the paperwork that turns a personal repo
into one a stranger can open a PR against.

### T1.1 — Add the licence file(s) · S
Depends on T0.1. Add `LICENSE` (and `LICENSE-CONTENT` if dual-licensing) using
verbatim upstream text — do not retype or paraphrase a licence. Add a short
"Licence" section to `README.md` with the which-applies-to-what table. Update
the `CLAUDE.md` line that says the repository declares no licence, and set
`license:` in the recipe front matter / layout if T0.1 chose a content licence.

### T1.2 — Write `CONTRIBUTING.md` · M
The single document a new contributor reads. It should cover, in this order:

1. **What this site is for** — one paragraph, and the import rule.
2. **Adding a recipe** — copy an existing `_recipes/*.md`, rename, edit front
   matter. Filename becomes the URL.
3. **The four derived fields** that must be worked out per recipe and never
   copied: `nutrition`, `estimated_cost`, `diets`, `alternate_names` /
   `disambiguating_description`. Say plainly that a wrong number is worse than
   an absent one, because a wrong one is believed.
4. **Never write HTML in a recipe.** Extend the layout instead, so every recipe
   gains the feature.
5. **Weights not cups; every step names its function, level and duration;
   failure modes stated where they happen.** These are the house voice.
6. **Allergens and diets** — reference `_data/allergens.yml` by `id`; only the
   eleven `RestrictedDiet` values are meaningful; `HalalDiet` and `KosherDiet`
   are not claimed because sourcing cannot be known from a recipe.
7. **Images** — resize to ~1600 px and under ~500 KB, strip EXIF, always write
   `image_alt`. Say explicitly that git keeps every version of a binary forever,
   so an unprocessed phone photo cannot be undone by deleting it later.
8. **How to run the checks locally** — one command (T2.5).
9. **Branch, PR and review expectations** — branch off `main`, one concern per
   PR, stack branches when work builds on unmerged work.

Do not restate the whole of `CLAUDE.md`. Link to the README sections that
already exist (`#how-these-recipes-are-written`, `#step-fields`,
`#the-import-contract`, `#images`) and keep the three documents in agreement —
`CLAUDE.md` already requires that.

### T1.3 — Add `CODE_OF_CONDUCT.md` · S
Contributor Covenant 2.1, verbatim, with a real reporting contact filled in.
GitHub surfaces it in the PR sidebar and in the community profile.

### T1.4 — Add issue templates (`.github/ISSUE_TEMPLATE/`) · M
Use YAML issue **forms**, not markdown templates — forms produce structured,
answerable issues instead of a blank box someone deletes.

- `recipe-request.yml` — dish name, who cooks it, any source, photo available?
- `recipe-correction.yml` — which recipe, which step, what happened instead.
  Include a "which cooker did you use?" field: timings assume the Pro Max, and
  most reported failures will turn out to be a different appliance.
- `import-failure.yml` — the highest-value template. Recipe URL, which app
  (Fresco, Instant Brands Connect, Paprika, Crouton…), what arrived wrong.
  This is the failure the whole site is designed to prevent, so make it easy
  to report.
- `site-bug.yml` — page, browser, screen width, what broke.
- `config.yml` — `blank_issues_enabled: false` plus contact links.

### T1.5 — Add `.github/pull_request_template.md` · S
A checklist mirroring the six rules that break silently, because each of them
fails without erroring:

- [ ] `bundle exec jekyll build` passes with no Liquid syntax warnings
- [ ] Images absolute in JSON-LD, relative in `<img>`
- [ ] Every step is a `HowToStep` with both `name` and `text`
- [ ] `continues: true` steps restate their appliance session
- [ ] `prepTime + cookTime == totalTime`
- [ ] Every step anchor resolves to an `id` on the page
- [ ] Ingredients are flat strings — quantity, unit and item on one line
- [ ] `nutrition`, `estimated_cost` and `diets` were worked out, not copied
- [ ] Images resized, recompressed, EXIF stripped; `image_alt` written
- [ ] `updated` bumped if the method or quantities changed

Keep it short enough to actually be ticked. Once T2.x lands, drop the items CI
now proves and keep only the ones a machine cannot check (the derived fields,
the photo processing).

### T1.6 — Add `CODEOWNERS` · S
`_layouts/`, `_includes/`, `_config.yml`, `.github/` and the test suite are
structural — route them to you. Leave `_recipes/` and `assets/images/` without
an owner so recipe PRs are not gated on one person. Pair with T3.3.

### T1.7 — Add `SECURITY.md` · S
Short. A static site with no server and no external requests has a small
surface; say so, and give an email for reports rather than a public issue.

### T1.8 — Add `.editorconfig` and `.gitattributes` · S
`.editorconfig`: UTF-8, LF, final newline, trim trailing whitespace, 2-space
indent for YAML/HTML/CSS. `.gitattributes`: `* text=auto eol=lf`, and mark
`*.jpg`/`*.png` as `binary` so git never tries to diff or merge a photo.

---

## Phase 2 — The test pyramid

Shape: **many fast checks at the base, few slow ones at the tip.** Rough target
once built — ~40–60 tier-1 assertions, ~15–25 tier-2, ~5–8 tier-3. The base
runs in under a second with no build; the tip needs a browser and runs last.

```
        ╱ tier 3 ╲        browser · slowest · fewest
       ╱  E2E &    ╲       renders, images load, filters work
      ╱  visual     ╲
     ╱───────────────╲
    ╱    tier 2       ╲   built _site · needs jekyll build
   ╱  integration:     ╲   JSON-LD shape, anchors, allergen maths
  ╱   the import        ╲
 ╱     contract          ╲
╱─────────────────────────╲
      tier 1: data         no build · milliseconds
  front matter, allergens,  runs on every save
   durations, assets, CSS
```

### T2.1 — Tier 1: data and front-matter tests · M
Depends on T0.2. Parses `_recipes/*.md`, `_data/allergens.yml` and `_config.yml`
directly. No Jekyll build, so these run in milliseconds and can hang off a file
watcher. One test per recipe per rule, so a failure names the file and the rule.

- Required front matter present: `title`, `description`, `date`, `image`,
  `image_alt`, `yield`, `category`, `cuisine`, `cooking_method`, ingredients,
  steps.
- `prep_time`, `cook_time`, `total_time` parse as ISO 8601 durations **and**
  `prep + cook == total`.
- Every `allergens.present[].id` and `allergens.may_contain[].id` resolves
  against `_data/allergens.yml`; no id appears in both lists.
- Every `diets[].schema` is one of the eleven `RestrictedDiet` members. Assert
  the list is exactly eleven, so adding a twelfth by mistake fails here.
- `nutrition` carries all twelve `NutritionInformation` keys, and `nutrition`
  values are per serving with a stated serving size.
- `estimated_cost.currency` is a valid ISO 4217 code.
- Every `image:` path exists on disk; every step `image` exists too.
- Ingredient entries are single-line strings — no nested structure, no newline.
- Every step has `name` and `text`; `continues: true` steps start lowercase
  (the layout prepends the appliance context, so a capital letter reads wrong).
- No recipe contains raw HTML tags (`CLAUDE.md`: never write HTML in a recipe).
- ⚠️ Do **not** implement front-matter parsing by splitting the file on `---`.
  A file missing its closing terminator still yields valid YAML from a naive
  split, so the trap `CLAUDE.md` documents slips straight through. Use a real
  front-matter parser, and rely on T2.2's `datePublished` assertion as the
  authoritative catch.

### T2.2 — Tier 2: import-contract tests against the built `_site` · L
Depends on T0.2, T2.1. Runs `bundle exec jekyll build` once, then asserts
against the HTML. This is the tier that defends the one rule at the top of
`CLAUDE.md`, so it is the one worth over-investing in.

Per recipe page:

- **`datePublished` is present in the Recipe JSON-LD.** The cheapest possible
  proof that the front matter was read at all — a file missing its closing
  `---` renders a plausible page built from no data whatsoever, complete with an
  auto-generated `<h1>` from the filename. Nothing else catches this.
- Exactly one `schema.org/Recipe` object. ⚠️ `jekyll-seo-tag` emits its own
  `BlogPosting` block first, so the Recipe block is the **second**
  `<script type="application/ld+json">` — select it by `@type`, never by index.
- The JSON-LD parses as JSON (a Liquid slip produces a trailing comma and a
  silently unparseable block).
- Every `image` / `thumbnailUrl` URL is absolute; every `<img src>` on the page
  is relative.
- Every `recipeInstructions[].url` anchor resolves to a matching `id` on the
  rendered `<li>`. Both directions — no orphan anchors, no unreferenced ids.
- Every step is a `HowToStep` object with `name` and `text`; none is a bare
  string.
- `supply` is the same strings, in the same order, as `recipeIngredient`;
  `yield` equals `recipeYield`; `timeRequired` equals `totalTime`;
  `performTime` is present.
- `copyrightYear` is emitted as an unquoted **number**.
- `keywords` is a string, not an array.
- **No `step` key is emitted** — the duplicate-method bug. Also assert none of
  the superseded spellings appear: `ingredients`, `steps`, `reviews`, `awards`,
  `isBasedOnUrl`.
- `aggregateRating` and `review` are absent unless real data backs them.
- Allergen arithmetic: contains + may-contain + free-from == the full fourteen,
  with no id in two lists.
- The `@id` is `<page URL>#recipe` and does not collide with the `WebPage`
  `@id` in `mainEntityOfPage`.

Whole-build assertions:

- The build prints **no Liquid syntax warnings**. These do not fail the build
  but render nothing where output was expected — the `contains`-as-a-front-
  matter-key trap is exactly this. Fail the suite on any warning line.
- `html-proofer` over `_site`: no broken internal links, no missing images, no
  `<img>` without `alt`.
- The index page lists every recipe in `_recipes/`.
- `sitemap.xml` exists and contains every recipe URL.
- ⚠️ Build with `jekyll build`, never `jekyll serve` — `serve` rewrites
  `site.url` to localhost, so a wrongly-absolute URL resolves anyway and the
  bug hides.

### T2.3 — Tier 3: browser tests · M
Depends on T2.2. Playwright against the built `_site` over a static file server.
Keep this tier small — five to eight specs, not fifty.

- A recipe page renders at 1280 px and at 380 px with no horizontal overflow.
- Hero and step images actually load: assert `naturalWidth > 0`. ⚠️ A broken
  image still reports `complete: true`, so a screenshot alone will mislead you.
- Index search and the filter controls narrow the list and can be cleared.
- The copy-link button appears where the clipboard API exists, and the plain URL
  stays visible where it does not (the progressive-enhancement rule).
- No network requests to third-party origins — asserts the "no external
  requests" rule directly, which no other tier can see.
- Optional: `axe-core` pass for obvious accessibility failures.

### T2.4 — Asset-hygiene checks · S
Cheap, tier-1 speed, and they enforce rules that are otherwise unrecoverable
once merged:

- No file in `assets/images/` over ~500 KB.
- No image wider than ~2000 px.
- **No EXIF GPS tags.** This repo is public and phone photos carry coordinates.
  Once such a commit lands, deleting the file does not remove it from history.
- Every image under `assets/images/recipes/` is referenced by some recipe
  (catches orphans left behind by a rename).

### T2.5 — One command, used by humans and CI alike · S
A `Rakefile` (or `bin/verify`) where `bundle exec rake` runs tiers 1 → 2 → 3 in
order and stops at the first failing tier. CI must invoke **this same command**,
so "passes locally" and "passes in CI" cannot diverge. Document it in
`CONTRIBUTING.md` and `README.md` → *Testing before you push*, replacing the
manual checklist with the parts a machine still cannot check.

### T2.6 — Documentation cross-reference check · S
`README.md` and `CLAUDE.md` link into each other by anchor
(`README.md#the-import-contract` and others). A heading rename breaks those
silently. A small script that extracts every relative markdown anchor and
asserts the target heading exists is twenty lines and prevents a recurring
paper cut.

---

## Phase 3 — Pipeline

### T3.1 — `.github/workflows/ci.yml` · M
Depends on T0.3, T2.5. Triggers: `pull_request`, and `push` to `main`.

- `ruby/setup-ruby` with `bundler-cache: true`.
- Job **build-and-verify**: `bundle exec rake` (tiers 1 and 2).
- Job **browser**: needs `build-and-verify`; installs Playwright and runs tier 3.
  Split so a front-matter typo fails in thirty seconds rather than four minutes.
- Upload `_site` as an artifact on pull requests, so a reviewer can download and
  open the built page. (A true hosted preview needs a third-party host — Pages
  will not preview a branch. Treat that as out of scope.)
- `concurrency` with `cancel-in-progress: true`, so a force-push does not leave
  a stale run burning.
- Set `permissions: contents: read` explicitly at the workflow level.
- Pin third-party actions to a commit SHA, not a floating tag.

### T3.2 — Cache the bundle and the browser · S
`bundler-cache: true` handles gems. Cache the Playwright browser download
separately, keyed on the Playwright version — it is the slowest step in the
pipeline by a wide margin.

### T3.3 — Turn on branch protection for `main` · S
Depends on T3.1 (a required check must exist before it can be required).
`CLAUDE.md` already says never commit directly to `main`; this is what makes
that true rather than aspirational.

- Require a pull request before merging; require 1 approval.
- Require the CI status checks to pass.
- Require branches to be up to date before merging.
- Dismiss stale approvals on new commits.
- Block force-pushes and deletion of `main`.

Repository settings worth setting at the same time: squash-merge only, auto-
delete head branches after merge, and a repo description plus topics
(`jekyll`, `recipes`, `schema-org`, `instant-pot`, `github-pages`) so the repo
is findable.

### T3.4 — Dependabot · S
`.github/dependabot.yml` for two ecosystems: `bundler` and `github-actions`,
monthly, grouped so one PR covers all patch bumps. More useful once T0.4 lands.

### T3.5 — Scheduled schema.org drift check · M
The field list in `CLAUDE.md` was verified against **release 30.0**. A quarterly
scheduled workflow that clones `schemaorg/schemaorg`, reads
`data/releases/<latest>/schemaorg-current-https.jsonld` and checks three things:

1. no property this site emits has gained a `schema:supersededBy`;
2. the twelve `NutritionInformation` keys are unchanged;
3. every `suitableForDiet` value is still a `RestrictedDiet` member.

Open an issue on failure rather than failing a build nobody is watching.
⚠️ Read the vocabulary from the cloned repository, not from `schema.org` — the
website is not always reachable from a sandbox or behind a corporate proxy, and
an unreachable spec is what tempts someone into guessing a property name.

### T3.6 — Link check on a schedule · S
`html-proofer` with external link checking is too flaky for PR CI (rate limits,
transient 503s) but valuable weekly. Separate workflow, opens an issue on
failure. Keeps the appliance and schema.org URLs in `_config.yml` honest.

---

## Phase 4 — Contributor experience

### T4.1 — Label taxonomy and good first issues · S
Labels: `recipe`, `site`, `docs`, `infra`, `import-bug`, `good first issue`,
`help wanted`. Then file three or four genuinely small issues — "add a recipe
you already cook", "add an `alternate_names` entry to an existing recipe",
"photograph the masala rice" — so a newcomer has an obvious first move.

### T4.2 — README badges and a contributor section · S
CI status badge, licence badge, and a two-line "Contributing" section linking to
`CONTRIBUTING.md`. First thing a visitor looks for.

### T4.3 — A recipe template file · S
`_recipes/_TEMPLATE.md.example` — every field with an inline comment explaining
what it is for and which ones must be derived rather than copied. Turns
"copy an existing file and hope" into a checklist. Keep it excluded from the
build (an underscore prefix plus an `exclude` entry).

### T4.4 — A `SessionStart` hook for Claude Code on the web · S
`.claude/settings.json` with a hook that runs `bundle config set path
'vendor/bundle' && bundle install`, so a web session can build and test
immediately instead of spending its first minutes on setup.

### T4.5 — Keep `TASKS.md` out of the built site · S
Add it to the `exclude` list in `_config.yml` next to `README.md` and
`CLAUDE.md`, or it is published at `/TASKS.md`. *(Done as part of adding this
file.)*

---

## Phase 5 — Deliberately not doing yet

Recorded so they are not re-proposed every few months.

- **Conventional Commits / commitlint.** Overhead out of proportion to a
  two-person recipe site. Revisit if a changelog is ever generated.
- **Visual regression snapshots.** Recipe photos and a warm serif layout produce
  a stream of false positives. The tier-3 render checks cover the real risk.
- **A staging environment.** Pages builds from `main`; the artifact upload in
  T3.1 covers reviewing a change before merge.
- **`aggregateRating` / `review` JSON-LD.** Only ever from real, recorded
  ratings. A site rating its own recipe is dishonest, and search engines discard
  the entire block as a self-serving review when they detect it.
- **A `hasAllergen` property.** It does not exist in schema.org — checked
  against the vocabulary dump, not assumed. Allergens stay in visible prose and
  in plain-text `keywords`. A made-up property is dropped by a strict JSON-LD
  processor and believed by a lenient one, which is the worse of the two.

---

## Suggested order

1. **T0.1–T0.4** — decide.
2. **T1.1, T1.2, T1.5** — licence, contributing guide, PR checklist. A
   collaborator can be invited after this.
3. **T2.1, T2.5** — the fast tier plus one command. Immediate value, no CI yet.
4. **T3.1, T3.3** — CI, then branch protection once a check exists to require.
5. **T2.2** — the import-contract tier. The most valuable and the largest.
6. Everything else, in phase order.
