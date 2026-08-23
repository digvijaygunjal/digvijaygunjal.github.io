// @ts-check
const { defineConfig, devices } = require('@playwright/test');
const path = require('path');

const SITE = path.resolve(__dirname, '../../_site');
const PORT = Number(process.env.PORT || 4173);
const ORIGIN = `http://127.0.0.1:${PORT}`;

// Serves the built site as files, the way GitHub Pages does. Deliberately not
// `jekyll serve`: serve rewrites site.url to localhost, so a wrongly-absolute
// URL resolves anyway and the bug it would have caught disappears.
module.exports = defineConfig({
  testDir: './specs',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: 0,
  reporter: [['list']],
  use: {
    baseURL: ORIGIN,
    trace: 'retain-on-failure'
  },
  projects: [{ name: 'chromium', use: { ...devices['Desktop Chrome'] } }],
  webServer: {
    command: `python3 -m http.server ${PORT} --bind 127.0.0.1 --directory ${SITE}`,
    url: `${ORIGIN}/`,
    reuseExistingServer: !process.env.CI,
    stdout: 'ignore',
    stderr: 'ignore'
  }
});

module.exports.ORIGIN = ORIGIN;
