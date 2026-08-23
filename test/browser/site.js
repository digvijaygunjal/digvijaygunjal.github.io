// Where the pages under test come from.
//
// The list is read off the built site rather than written down here, so these
// checks know as little about any particular recipe as the ones in Ruby do:
// add a recipe and it is covered, delete one and it stops being checked.
const fs = require('fs');
const path = require('path');

const SITE = path.resolve(__dirname, '../../_site');

function recipePaths() {
  const dir = path.join(SITE, 'recipes');
  if (!fs.existsSync(dir)) {
    throw new Error(`${dir} does not exist — run \`bundle exec jekyll build\` before the browser checks`);
  }
  const paths = fs
    .readdirSync(dir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => `/recipes/${entry.name}/`)
    .sort();

  if (paths.length === 0) {
    throw new Error('the built site contains no recipe pages, so every check below would pass without looking at anything');
  }
  return paths;
}

module.exports = { SITE, recipePaths, allPaths: () => ['/', ...recipePaths()] };
