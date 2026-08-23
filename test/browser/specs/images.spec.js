const { test, expect } = require('@playwright/test');
const { allPaths } = require('../site');

// A broken image still reports `complete: true`, and renders as a blank box a
// screenshot will not obviously distinguish from a photo that has not loaded
// yet. naturalWidth is the only honest question, and only a real browser can
// answer it — which is the whole reason this check is worth a browser.
for (const pagePath of allPaths()) {
  test(`every image on ${pagePath} actually loads`, async ({ page }) => {
    await page.goto(pagePath);

    // Card thumbnails and step images are lazy, so nothing below the fold has
    // been asked for yet.
    await page.evaluate(async () => {
      window.scrollTo(0, document.body.scrollHeight);
      await new Promise((resolve) => setTimeout(resolve, 100));
      window.scrollTo(0, 0);
    });
    await page.waitForLoadState('networkidle');

    const broken = await page.evaluate(() =>
      Array.from(document.images)
        .filter((img) => img.naturalWidth === 0)
        .map((img) => img.getAttribute('src'))
    );

    expect(broken, 'images that resolved to nothing').toEqual([]);
    expect(await page.evaluate(() => document.images.length), 'images on the page').toBeGreaterThan(0);
  });
}
