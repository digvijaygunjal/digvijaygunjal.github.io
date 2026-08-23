# Project notes for this vendored skill

Everything beside this file is upstream, kept verbatim so it can be diffed
against the source and updated cleanly.

- **Source:** <https://github.com/pauloschinzel/jekyll-gh-pages>
- **Vendored at commit:** `d9d709ffd79db4cee30d46bc594eb48b8e7d18aa`
- **Licence:** MIT, Copyright (c) 2026 Paulo Schinzel — see `LICENSE`

Vendored into the repository rather than symlinked into `~/.claude/skills/`, as
the upstream README suggests, so that it travels with a clone and is available
to any session working on this site.

To update it, re-copy the upstream files and bump the commit above. Do not edit
them in place; project-specific deviations belong in this file.

## Where this repo overrides the skill

The skill is general-purpose Jekyll guidance aimed at new sites. This site is
already built and has settled conventions, so where the two disagree, **this
repository's `CLAUDE.md` and `README.md` win.** The specific collisions:

| The skill says | This repo does |
|---|---|
| Set a theme: `theme: minima`, `jekyll-theme-cayman`, or `remote_theme: owner/repo` | `theme: null`. A theme overrides this site's CSS, and the `github-pages` default has broken the build outright with a Sass encoding error. |
| Reach for the `frontend-design` skill for layouts and styling | Layouts and `assets/css/main.css` are hand-written to a settled editorial style. Extend them; do not regenerate them. |
| Content lives in `_posts/` as blog posts | Content lives in `_recipes/` as a collection, data-only, with no markup in the files. |

The skill's `templates/_config-*.yml` are starting points for a **new** blog,
portfolio or docs site. They are not this site's configuration and should not be
merged into `_config.yml`.

## What it is genuinely useful for

- `rules/liquid-cheatsheet.md` — Liquid syntax, which this repo's layouts lean
  on heavily
- `rules/troubleshooting.md` — Jekyll and GitHub Pages build failures
- The whitelisted-plugin list, which constrains what can be added to `plugins:`

The skill declares `disable-model-invocation: true`, so it runs only when
invoked deliberately rather than triggering on its own.
