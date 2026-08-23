const { test, expect } = require('@playwright/test');
const { allPaths } = require('../site');

// Two widths: a desktop window, and a narrow phone. 380 px is the width where
// a fixed-width table or an unbroken URL starts pushing the page sideways, and
// a page that scrolls horizontally is one a cook cannot read one-handed at the
// hob.
const WIDTHS = [1280, 380];

for (const pagePath of allPaths()) {
  for (const width of WIDTHS) {
    test(`${pagePath} does not scroll sideways at ${width}px`, async ({ page }) => {
      await page.setViewportSize({ width, height: 900 });
      await page.goto(pagePath);

      // Naming the offending elements matters more than the number: "the page
      // overflows by 40px" sends someone hunting, "<pre.highlight> is 420px
      // wide" is the fix.
      const offenders = await page.evaluate((viewport) => {
        return Array.from(document.querySelectorAll('body *'))
          .filter((el) => el.getBoundingClientRect().right > viewport + 1)
          .slice(0, 5)
          .map((el) => `${el.tagName.toLowerCase()}${el.className ? '.' + String(el.className).split(' ')[0] : ''}`);
      }, width);

      expect(offenders, 'elements reaching past the right edge of the viewport').toEqual([]);

      const overflow = await page.evaluate(
        () => document.documentElement.scrollWidth - document.documentElement.clientWidth
      );
      expect(overflow, 'horizontal overflow in pixels').toBeLessThanOrEqual(0);
    });
  }
}
