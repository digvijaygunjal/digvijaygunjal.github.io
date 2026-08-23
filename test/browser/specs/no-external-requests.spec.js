const { test, expect } = require('@playwright/test');
const { allPaths } = require('../site');

// "No external requests" is a rule about what the page fetches, and only a
// real browser can see that. Icons are inlined SVG, there are no CDN scripts,
// no webfonts and no third-party stylesheets, so nothing here should break
// because someone else's service went away — and nobody reading a recipe
// should be announced to a third party.
for (const pagePath of allPaths()) {
  test(`${pagePath} asks nobody else for anything`, async ({ page, baseURL }) => {
    const foreign = [];
    page.on('request', (request) => {
      const url = request.url();
      if (!url.startsWith(baseURL) && !url.startsWith('data:') && !url.startsWith('blob:')) {
        foreign.push(`${request.resourceType()} ${url}`);
      }
    });

    await page.goto(pagePath);
    await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
    await page.waitForLoadState('networkidle');

    expect(foreign, 'requests to origins other than this site').toEqual([]);
  });
}
