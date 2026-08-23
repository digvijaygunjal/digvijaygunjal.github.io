const { test, expect } = require('@playwright/test');
const { recipePaths } = require('../site');

// The import strip is the point of the whole site: it is where a reader gets
// the URL to paste into a recipe app. Where the clipboard API exists the
// script swaps the plain link for a copy button; where it does not, the link
// stays. This rule cannot be checked anywhere cheaper — a parser sees the
// markup before the script runs, and the script's own condition is the thing
// under test.
//
// One recipe page is enough: the strip comes from the shared layout, so a
// second page would exercise the same code twice.
const recipe = recipePaths()[0];

test('the URL the strip hands out is absolute, whatever the browser can do', async ({ page }) => {
  await page.goto(recipe);

  const url = await page.locator('.import-strip').getAttribute('data-recipe-url');
  expect(url, 'a relative URL pasted into an app resolves to nothing').toMatch(/^https?:\/\/.+/);
  expect(url.endsWith(recipe), `the strip offers ${recipe}, not some other page`).toBe(true);
});

test('with the clipboard API, the link becomes a button that copies it', async ({ page, context }) => {
  await context.grantPermissions(['clipboard-read', 'clipboard-write']);
  await page.goto(recipe);

  const url = await page.locator('.import-strip').getAttribute('data-recipe-url');
  const button = page.locator('button.copy-link');

  await expect(button, 'localhost is a secure context, so the API is available').toBeVisible();
  await expect(page.locator('.import-strip-url'), 'the button replaces the plain link rather than joining it').toHaveCount(0);

  await button.click();
  await expect(button, 'the button says what it did').toHaveText(/copied/i);
  expect(await page.evaluate(() => navigator.clipboard.readText()), 'what actually landed on the clipboard').toBe(url);
});

test('without the clipboard API the URL stays visible and no dead button appears', async ({ page }) => {
  // Deleting the API is the honest way to stand in for the browsers and
  // contexts that do not offer it: an insecure origin, or an older browser.
  await page.addInitScript(() => {
    Object.defineProperty(navigator, 'clipboard', { value: undefined, configurable: true });
  });
  await page.goto(recipe);

  const link = page.locator('.import-strip-url');
  await expect(link, 'the URL is what a reader falls back to').toBeVisible();
  await expect(page.locator('button.copy-link'), 'a control that could do nothing is never rendered').toHaveCount(0);

  const url = await page.locator('.import-strip').getAttribute('data-recipe-url');
  expect(await link.getAttribute('href'), 'the visible link and the strip agree').toBe(url);
});
