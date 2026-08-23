const { test, expect } = require('@playwright/test');

// The search box and the filter chips exist only if the script runs: the list
// underneath is complete and correct without them. So the first thing to check
// is that the enhancement arrived at all, and the rest is whether the count it
// reports agrees with the cards it actually left visible.
//
// Nothing here names a recipe. The query is taken from a card on the page, so
// the spec keeps working when the collection changes.
const visibleCards = (page) => page.locator('.recipe-list > li:visible');

test('the search box narrows the list and gives it back', async ({ page }) => {
  await page.goto('/');

  const search = page.locator('input.filter-search');
  await expect(search, 'the search box is added by script when the list is worth filtering').toBeVisible();

  const total = await visibleCards(page).count();
  expect(total, 'recipes on the index').toBeGreaterThan(1);

  // A word this page itself contains, taken from the first card's title.
  const word = (await page.locator('.recipe-list > li .card-title').first().innerText()).trim().split(/\s+/)[0];

  await search.fill(word);
  const narrowed = await visibleCards(page).count();
  expect(narrowed, `searching for "${word}" leaves at least the card it came from`).toBeGreaterThan(0);
  expect(narrowed, 'searching narrows the list').toBeLessThanOrEqual(total);

  await page.locator('button.filter-clear').click();
  await expect(visibleCards(page), 'Clear puts every recipe back').toHaveCount(total);
});

test('a search that matches nothing says so rather than showing an empty page', async ({ page }) => {
  await page.goto('/');

  await page.locator('input.filter-search').fill('zzzzz-not-a-recipe');

  await expect(visibleCards(page)).toHaveCount(0);
  await expect(page.locator('.filter-empty'), 'an empty result explains itself').toBeVisible();
});

test('a filter chip narrows the list, and the count agrees with it', async ({ page }) => {
  await page.goto('/');

  const chip = page.locator('.filter-panel .chip').first();
  await expect(chip).toBeVisible();

  const total = await visibleCards(page).count();
  await chip.click();

  await expect(chip, 'a pressed chip says so to a screen reader too').toHaveAttribute('aria-pressed', 'true');

  const narrowed = await visibleCards(page).count();
  expect(narrowed, 'a filter never adds recipes').toBeLessThanOrEqual(total);

  // The count is written by the script; the cards are what a reader sees. They
  // are two representations of one number and drift apart in silence.
  // "3 of 12 recipes" while filtering, "12 recipes" when nothing is selected.
  const reported = Number((await page.locator('.filter-count').innerText()).match(/\d+/)[0]);
  expect(reported, 'the reported count matches the cards left on the page').toBe(narrowed);

  await page.locator('button.filter-clear').click();
  await expect(visibleCards(page)).toHaveCount(total);
  await expect(chip).toHaveAttribute('aria-pressed', 'false');
});
