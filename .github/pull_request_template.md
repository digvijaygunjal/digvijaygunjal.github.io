## What this changes

<!-- One or two sentences. If it fixes an issue, write "Closes #123". -->

## Checklist

- [ ] `bundle exec rake` passes

Everything that can be checked by a machine is checked by that command — the
build and its Liquid warnings, the JSON-LD shape, absolute image URLs, step
anchors, the time arithmetic, the allergen subtraction, image size and EXIF.
What is left is what nobody but you can confirm:

- [ ] `nutrition`, `estimated_cost` and `diets` were worked out for *this* dish, not copied from the file you started from
- [ ] The photograph is the right one — well cropped, genuinely resized and recompressed — and `image_alt` describes what is actually in it
- [ ] `updated` bumped, if the method or the quantities changed

<!--
Why only these three.

They are the ones that fail silently *and* cannot be automated. A wrong
nutrition figure is believed precisely because it is present; an absent one is
not. A checklist that duplicates the checks stops being read, and a checklist
that is not read is worse than none.
-->

## Anything a reviewer should know

<!--
A judgement call you made, a thing you could not check, a branch this one is
stacked on. "Nothing" is a fine answer.

If you could not verify something, say so rather than ticking it — an
admitted gap costs one comment, an unfounded tick costs a broken import.
-->
