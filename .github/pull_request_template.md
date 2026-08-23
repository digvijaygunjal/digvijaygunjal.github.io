## What this changes

<!-- One or two sentences. If it fixes an issue, write "Closes #123". -->

## Checklist

Every item below fails **silently** — nothing errors, and the page still looks
right. That is why they are here and not left to the build.

Tick what applies; strike out what does not.

- [ ] `bundle exec jekyll build` passes, with no Liquid syntax warnings
- [ ] Images are absolute URLs in the JSON-LD, relative in `<img>` tags
- [ ] Every step is a `HowToStep` carrying both `name` and `text`
- [ ] `continues: true` steps restate their appliance session
- [ ] `prepTime + cookTime == totalTime`
- [ ] Every step anchor resolves to an `id` on the page
- [ ] Ingredients are flat strings — quantity, unit and item on one line
- [ ] `nutrition`, `estimated_cost` and `diets` were worked out for this dish, not copied
- [ ] Images resized and recompressed, EXIF stripped, `image_alt` written
- [ ] `updated` bumped, if the method or the quantities changed

<!--
Two of these are worth a word on why.

The build prints Liquid syntax warnings without failing, and the markup a
warning names renders as nothing at all — so a clean build is not the same as
a build with no warnings.

The derived fields are the ones that cannot be checked by anyone but you. A
wrong nutrition figure is believed precisely because it is present; an absent
one is not.
-->

## Anything a reviewer should know

<!--
A judgement call you made, a thing you could not check, a branch this one is
stacked on. "Nothing" is a fine answer.

If you could not verify something, say so rather than ticking it — an
admitted gap costs one comment, an unfounded tick costs a broken import.
-->

<!--
Maintainers: when the test tiers land (#32, #33, #34) and one command runs them
all (#36), delete the items CI now proves — the build, the anchors, the time
arithmetic, the JSON-LD shape — and keep only what a machine cannot check: the
derived fields, and whether the photo was really processed. A checklist that
duplicates CI stops being read, and a checklist that is not read is worse than
none.
-->
