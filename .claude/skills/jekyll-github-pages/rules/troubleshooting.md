# Jekyll + GitHub Pages Troubleshooting Guide

Common problems and their solutions, organized by category.

## Table of Contents

- [Deployment Issues](#deployment-issues)
- [URL and Path Problems](#url-and-path-problems)
- [Theme Issues](#theme-issues)
- [Build Failures](#build-failures)
- [Content Not Showing](#content-not-showing)
- [Plugin Problems](#plugin-problems)
- [Local vs Production Differences](#local-vs-production-differences)
- [Performance Issues](#performance-issues)

---

## Deployment Issues

### Site Shows 404 After Enabling GitHub Pages

**Symptoms**:
- GitHub Pages is enabled
- Build shows success (green checkmark)
- Site URL returns "404 - Page not found"

**Causes**:
1. Incorrect `baseurl` in `_config.yml`
2. First deployment still processing
3. Wrong branch or folder selected in settings
4. No `index.html` or `index.md` in root

**Solutions**:

**Check baseurl:**
```yaml
# For username.github.io (user site):
url: "https://username.github.io"
baseurl: ""  # MUST be empty

# For username.github.io/repo-name (project site):
url: "https://username.github.io"
baseurl: "/repo-name"  # MUST have leading slash
```

**Wait for first deploy:**
- First deployment takes 2-5 minutes
- Check **Actions** tab for build status
- Look for green checkmark ✓

**Verify GitHub Pages settings:**
1. Go to repo **Settings** → **Pages**
2. Verify source branch is `main` (or correct branch)
3. Verify folder is `/ (root)` (or `docs/` if using that)
4. Save settings again to trigger rebuild

**Check for index file:**
```bash
ls index.* # Should show index.html or index.md
```

### Site Not Updating After Push

**Symptoms**:
- Pushed changes to GitHub
- No errors shown
- Live site hasn't changed

**Solutions**:

**1. Check build status:**
```bash
# View Actions tab in GitHub
# Or use CLI:
gh run list --limit 5
```

**2. Force refresh browser:**
- Chrome/Firefox: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)
- Safari: Cmd+Option+R

**3. Clear GitHub Pages cache:**
```bash
# Make a trivial change to _config.yml
# Add a comment:
# Updated: 2026-02-10

git add _config.yml
git commit -m "Force rebuild"
git push
```

**4. Check if you edited _config.yml:**
- Changes to `_config.yml` require full site rebuild
- Takes 1-2 minutes instead of 30 seconds

**5. Verify files are committed:**
```bash
git status  # Should show "nothing to commit"
git log -1  # Check latest commit includes your changes
```

---

## URL and Path Problems

### Broken Links and Images on GitHub Pages (Work Locally)

**Symptoms**:
- Links and images work with `jekyll serve`
- Same links broken on live GitHub Pages site
- 404 errors in browser console

**Cause**: Not using `baseurl` correctly in paths

**Solutions**:

**Use relative_url filter for all paths:**
```liquid
<!-- WRONG -->
<link rel="stylesheet" href="/assets/css/style.css">
<img src="/images/photo.jpg">
<a href="/about/">About</a>

<!-- RIGHT -->
<link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">
<img src="{{ '/images/photo.jpg' | relative_url }}">
<a href="{{ '/about/' | relative_url }}">About</a>
```

**For Markdown links, use post_url or link:**
```markdown
<!-- Posts -->
[Read more]({% post_url 2026-02-10-my-post %})

<!-- Pages -->
[About]({% link about.md %})
```

**Test with baseurl locally:**
```bash
# Serve with same baseurl as production
bundle exec jekyll serve --baseurl "/repo-name"
# Visit: http://localhost:4000/repo-name/
```

### Wrong Baseurl Configuration

**How to determine correct baseurl:**

| Site Type | Repository Name | URL | Baseurl |
|-----------|----------------|-----|---------|
| User site | `username.github.io` | `https://username.github.io` | `""` (empty) |
| Organization site | `orgname.github.io` | `https://orgname.github.io` | `""` (empty) |
| Project site | `any-repo-name` | `https://username.github.io/any-repo-name` | `"/any-repo-name"` |

**In _config.yml:**
```yaml
# User/org site:
url: "https://username.github.io"
baseurl: ""

# Project site:
url: "https://username.github.io"
baseurl: "/repo-name"  # Must match repo name exactly
```

### Assets Not Loading (CSS, JS, Images)

**Symptoms**:
- Page loads but has no styling
- Images don't appear
- JavaScript doesn't work

**Solutions**:

**1. Check asset paths use relative_url:**
```liquid
{{ '/assets/css/main.css' | relative_url }}
```

**2. Verify assets are committed:**
```bash
git ls-files | grep assets
# Should list all your asset files
```

**3. Check asset location:**
```bash
# Assets should be in root assets/ folder
ls -la assets/
# Or in theme's assets location
```

**4. Check browser console:**
- Open DevTools (F12)
- Look for 404 errors on assets
- Check if paths have double slashes: `/repo-name//assets/`

**Fix double slashes:**
```liquid
<!-- If baseurl already has leading slash -->
<link href="{{ site.baseurl }}/assets/style.css">  <!-- Wrong -->
<link href="{{ '/assets/style.css' | relative_url }}">  <!-- Right -->
```

---

## Theme Issues

### Theme Not Loading (Site Looks Broken)

**Symptoms**:
- Site has content but no styling
- Layout is plain HTML with no design
- Missing navigation or structure

**Solutions**:

**1. Verify theme name in _config.yml:**
```yaml
# For default GH Pages themes:
theme: minima  # Must be exact name

# For remote themes:
remote_theme: mmistakes/minimal-mistakes
```

**2. Check theme is supported:**

GitHub Pages supports these themes via `theme:`:
- minima (default)
- architect, cayman, dinky, hacker, leap-day, merlot, midnight
- minimal, modernist, slate, tactile, time-machine

For other themes, use `remote_theme:` instead.

**3. Install theme locally:**
```ruby
# Add to Gemfile:
gem "minima", "~> 2.5"
# Or:
gem "jekyll-theme-cayman"
```

Then:
```bash
bundle install
bundle exec jekyll serve
```

**4. Check for theme override conflicts:**
```bash
# If you have custom layouts, they override theme layouts
ls _layouts/  # Remove if you want theme defaults
ls _sass/     # Remove if you want theme styles
```

**5. Clear Jekyll cache:**
```bash
bundle exec jekyll clean
bundle exec jekyll serve
```

### Remote Theme Not Working

**Symptoms**:
- Using `remote_theme` in config
- Build succeeds but theme doesn't apply

**Solutions**:

**1. Add jekyll-remote-theme plugin:**
```yaml
# _config.yml
plugins:
  - jekyll-remote-theme

remote_theme: owner/repo-name
# Or with version:
remote_theme: owner/repo-name@v1.0.0
```

**2. Verify theme repository exists:**
- Visit `https://github.com/owner/repo-name`
- Ensure it's a Jekyll theme (has `_layouts/` folder)

**3. Check for typos:**
```yaml
remote_theme: mmistakes/minimal-mistakes  # RIGHT
remote_theme: mmistakes/minimal-mistake   # WRONG (missing s)
remote_theme: minimal-mistakes            # WRONG (missing owner)
```

**4. Try specific version:**
```yaml
# If default branch doesn't work
remote_theme: mmistakes/minimal-mistakes@4.24.0
```

### Custom Theme Changes Not Appearing

**Symptoms**:
- Modified theme files
- Changes don't show up on site

**Solutions**:

**1. Restart Jekyll server:**
```bash
# Ctrl+C to stop
bundle exec jekyll serve
```

**2. Clear cache and rebuild:**
```bash
bundle exec jekyll clean
bundle exec jekyll serve
```

**3. Check file location:**
```bash
# Override theme files by creating same path locally
# Example for minima theme:
ls _layouts/default.html    # Overrides theme's default.html
ls _includes/header.html    # Overrides theme's header.html
ls _sass/custom.scss        # Custom styles
```

**4. Check if editing right theme:**
```bash
# Find theme location
bundle info --path minima
# Copy files from there to override
```

---

## Build Failures

### Build Fails with "Dependency Error"

**Symptoms**:
- GitHub Actions shows red X
- Error mentions gems, dependencies, or versions

**Solutions**:

**1. Use github-pages gem:**
```ruby
# Gemfile
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
```

Then:
```bash
bundle update github-pages
```

This ensures your local environment matches GitHub Pages exactly.

**2. Remove version constraints:**
```ruby
# WRONG:
gem "jekyll", "~> 4.3.0"

# RIGHT (let github-pages manage versions):
gem "github-pages", group: :jekyll_plugins
```

**3. Check Ruby version:**
```bash
ruby -v  # Should be 2.7 or higher
```

Update Ruby if needed, then:
```bash
bundle install
```

### Build Fails with "Liquid Exception"

**Symptoms**:
- Error message: "Liquid Exception: ... in ..."
- Points to specific file and line number

**Common Causes:**

**1. Unmatched tags:**
```liquid
<!-- WRONG -->
{% if condition %}
  Content
  <!-- Missing {% endif %} -->

<!-- RIGHT -->
{% if condition %}
  Content
{% endif %}
```

**2. Invalid syntax:**
```liquid
<!-- WRONG -->
{{ post.title | upcase | downcase | capitalize | truncate 20 }}

<!-- RIGHT -->
{{ post.title | upcase | downcase | capitalize | truncate: 20 }}
#                                                          ^ colon needed
```

**3. Accessing nil values:**
```liquid
<!-- WRONG (if post.author might not exist) -->
{{ post.author.name }}

<!-- RIGHT -->
{% if post.author %}
  {{ post.author.name }}
{% endif %}
```

**4. Double Liquid processing:**
```liquid
<!-- If you need to show Liquid code literally: -->
{% raw %}
  {{ This won't be processed }}
  {% Neither will this %}
{% endraw %}
```

**Debugging:**
1. Check error message for file and line number
2. Open that file and look at that line
3. Check for unmatched tags above and below
4. Temporarily remove complex Liquid to isolate problem

### Build Fails with "YAML Front Matter" Error

**Symptoms**:
- Error mentions "front matter", "YAML", or "syntax error"
- Points to specific post or page

**Solutions**:

**1. Check front matter formatting:**
```yaml
---
# MUST start with three hyphens on first line
# MUST be valid YAML syntax
# MUST end with three hyphens

title: "My Post"  # Use quotes if title has special characters
date: 2026-02-10  # Valid date format
categories: [blog, tutorial]  # Array syntax
---
```

**2. Common YAML mistakes:**
```yaml
# WRONG - missing quotes around colon
title: My Post: A Guide

# RIGHT
title: "My Post: A Guide"

# WRONG - invalid date
date: Feb 10, 2026

# RIGHT
date: 2026-02-10

# WRONG - wrong array syntax
categories: blog, tutorial

# RIGHT
categories: [blog, tutorial]
# Or:
categories:
  - blog
  - tutorial
```

**3. Check for tabs (use spaces only):**
```bash
# Find tabs in files:
grep -P '\t' _posts/*.md
```

YAML doesn't allow tabs - use 2 spaces for indentation.

**4. Validate YAML online:**
- Copy your front matter
- Visit http://www.yamllint.com/
- Paste and validate

### Build Fails with "Plugin Not Found"

**Symptoms**:
- Error: "Dependency Error: Yikes! It looks like you don't have pluginname"
- Mentions gem or plugin name

**Cause**: Using plugin not on GitHub Pages whitelist

**Solutions**:

**1. Check if plugin is allowed:**

Whitelisted plugins (can use on GH Pages):
- jekyll-coffeescript
- jekyll-default-layout
- jekyll-feed
- jekyll-gist
- jekyll-github-metadata
- jekyll-optional-front-matter
- jekyll-paginate
- jekyll-readme-index
- jekyll-redirect-from
- jekyll-relative-links
- jekyll-remote-theme
- jekyll-seo-tag
- jekyll-sitemap
- jekyll-titles-from-headings
- jemoji

**2. Remove non-whitelisted plugin:**
```yaml
# _config.yml
plugins:
  - jekyll-unsupported-plugin  # Remove this
```

**3. Build locally and deploy built site:**

If you need non-whitelisted plugins:
```bash
# 1. Build site locally
JEKYLL_ENV=production bundle exec jekyll build

# 2. Deploy _site folder to gh-pages branch
git subtree push --prefix _site origin gh-pages

# 3. Change GH Pages settings to deploy from gh-pages branch
```

---

## Content Not Showing

### Posts Not Appearing on Site

**Symptoms**:
- Created posts in `_posts/` folder
- Posts don't show up on homepage or blog page

**Solutions**:

**1. Check filename format:**
```bash
# WRONG:
my-post.md
2026-2-10-my-post.md
2026_02_10_my_post.md

# RIGHT:
2026-02-10-my-post.md
# Format: YYYY-MM-DD-title-with-hyphens.md
```

**2. Check post date isn't in future:**
```yaml
---
date: 2026-12-31  # If today is Feb 10, this won't show
---
```

Fix:
```yaml
# _config.yml
future: true  # Show future posts
```

**3. Check front matter is valid:**
```yaml
---
layout: post  # Must have layout
title: "My Post"  # Must have title
---
```

**4. Check if posts are in correct folder:**
```bash
ls _posts/
# Should list your posts with YYYY-MM-DD prefix
```

**5. Verify homepage template shows posts:**
```liquid
<!-- index.html or index.md should have: -->
{% for post in site.posts %}
  <h2>{{ post.title }}</h2>
{% endfor %}
```

### Collections Not Working

**Symptoms**:
- Created collection in `_config.yml`
- Collection items don't appear

**Solutions**:

**1. Check collection is defined:**
```yaml
# _config.yml
collections:
  portfolio:
    output: true  # Generate pages for items
    permalink: /portfolio/:name/
```

**2. Check folder name matches:**
```bash
# For collection "portfolio":
mkdir _portfolio  # Must have underscore prefix
```

**3. Check collection items have front matter:**
```yaml
---
title: Project Name
# Other fields
---
```

**4. Access collection in templates:**
```liquid
{% for item in site.portfolio %}
  {{ item.title }}
{% endfor %}
```

### Images Not Showing

**Symptoms**:
- Images appear locally but not on GitHub Pages
- Broken image icons on live site

**Solutions**:

**1. Use relative_url filter:**
```liquid
<!-- WRONG -->
<img src="/assets/images/photo.jpg">

<!-- RIGHT -->
<img src="{{ '/assets/images/photo.jpg' | relative_url }}">
```

**2. Check image is committed:**
```bash
git ls-files | grep photo.jpg
# Should show the file
```

**3. Check file extension case:**
```bash
# On Mac/Windows: photo.JPG might work locally
# On Linux (GitHub): Must match exactly photo.jpg
# Solution: Use lowercase extensions consistently
```

**4. Check image path:**
```bash
ls assets/images/photo.jpg
# Verify file exists at this path
```

**5. Optimize large images:**
- Images over 100MB won't be served by GitHub
- Resize and compress large images
- Use JPG for photos, PNG for graphics

---

## Plugin Problems

### jekyll-paginate Not Working

**Symptoms**:
- Pagination configured but not working
- `paginator` variable is empty

**Solutions**:

**1. Check plugin is enabled:**
```yaml
# _config.yml
plugins:
  - jekyll-paginate

paginate: 10
paginate_path: "/page:num/"
```

**2. Use index.html (not index.md):**

Pagination only works with `index.html` in root:
```bash
mv index.md index.html  # If using Markdown
```

**3. Use paginator variables:**
```liquid
<!-- index.html -->
{% for post in paginator.posts %}
  <h2>{{ post.title }}</h2>
{% endfor %}

<!-- Pagination links -->
{% if paginator.previous_page %}
  <a href="{{ paginator.previous_page_path | relative_url }}">Previous</a>
{% endif %}
{% if paginator.next_page %}
  <a href="{{ paginator.next_page_path | relative_url }}">Next</a>
{% endif %}
```

### jekyll-seo-tag Not Adding Meta Tags

**Symptoms**:
- Plugin installed but no meta tags in HTML
- View source shows missing og: and twitter: tags

**Solutions**:

**1. Add to layout head:**
```html
<!-- _layouts/default.html -->
<head>
  {% seo %}
  <!-- Rest of head content -->
</head>
```

**2. Configure in _config.yml:**
```yaml
plugins:
  - jekyll-seo-tag

twitter:
  username: yourname
  card: summary

social:
  name: Your Name
  links:
    - https://twitter.com/yourname
    - https://github.com/yourname
```

**3. Add page-specific SEO:**
```yaml
---
title: Page Title
description: Page description for SEO
image: /assets/images/og-image.jpg
---
```

---

## Local vs Production Differences

### Works Locally, Fails on GitHub Pages

**Common causes:**

**1. Plugin not whitelisted**
- Remove non-whitelisted plugins
- Or build locally and deploy `_site/` folder

**2. Jekyll version mismatch**
```ruby
# Use github-pages gem to match versions
gem "github-pages", group: :jekyll_plugins
```

**3. Baseurl not configured**
```yaml
url: "https://username.github.io"
baseurl: "/repo-name"  # For project sites
```

Test locally with baseurl:
```bash
bundle exec jekyll serve --baseurl "/repo-name"
```

**4. Case-sensitive file paths**
- GitHub Pages is case-sensitive
- Local Mac/Windows may not be
- Always use consistent casing

**5. Absolute paths**
```liquid
<!-- Don't use absolute paths -->
<img src="/Users/you/project/image.jpg">  <!-- WRONG -->
<img src="{{ '/assets/image.jpg' | relative_url }}">  <!-- RIGHT -->
```

### Site Looks Different on GitHub Pages

**Symptoms**:
- Styling different between local and production
- Layout broken on live site

**Solutions**:

**1. Check baseurl in CSS/JS:**
```liquid
<!-- Link CSS with relative_url -->
<link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
```

**2. Build with production environment:**
```bash
JEKYLL_ENV=production bundle exec jekyll build
```

Check `_site/` folder output.

**3. Check for hardcoded URLs:**
```bash
grep -r "localhost:4000" .
grep -r "http://" _layouts/ _includes/
```

Replace with relative URLs.

---

## Performance Issues

### Site Builds Slowly

**Solutions**:

**1. Exclude unnecessary files:**
```yaml
# _config.yml
exclude:
  - node_modules/
  - vendor/
  - .git/
  - .gitignore
  - README.md
  - Gemfile
  - Gemfile.lock
```

**2. Limit posts in development:**
```yaml
# _config.yml (for local development)
limit_posts: 10  # Only build recent 10 posts
```

**3. Use incremental rebuild:**
```bash
bundle exec jekyll serve --incremental
```

Note: This can sometimes cause issues if pages depend on each other.

**4. Reduce large assets:**
- Compress images before committing
- Use image optimization tools
- Consider hosting large files externally

### Site Too Large for GitHub Pages

**Symptoms**:
- Build fails with size error
- Repository over 1 GB
- Site over 100 MB published size

**Solutions**:

**1. Check repository size:**
```bash
du -sh .git
du -sh _site
```

**2. Remove large files from history:**
```bash
# Use git-filter-repo or BFG Repo-Cleaner
# See: https://docs.github.com/en/repositories/working-with-files/managing-large-files
```

**3. Use external hosting for large assets:**
- Host images on Cloudinary, Imgur
- Host videos on YouTube, Vimeo
- Host downloads on Dropbox, Google Drive

**4. Exclude assets from repository:**
```yaml
# _config.yml
exclude:
  - assets/videos/  # Don't include in _site
```

---

## Still Having Issues?

### Debugging Steps

**1. Check GitHub Actions log:**
- Go to repository **Actions** tab
- Click latest workflow run
- Expand "Build with Jekyll" step
- Read full error message

**2. Test locally with same environment:**
```bash
# Use github-pages gem
bundle exec jekyll serve --baseurl "/repo-name"
```

**3. Simplify to isolate problem:**
- Comment out complex Liquid
- Remove custom layouts
- Try default theme
- Remove plugins one by one

**4. Check GitHub Pages health:**
```bash
gh api repos/:owner/:repo/pages/health
```

**5. Search existing issues:**
- Jekyll issues: https://github.com/jekyll/jekyll/issues
- GitHub Pages issues: https://github.com/github/pages-gem/issues

### Getting Help

**Resources:**
- Jekyll Talk forum: https://talk.jekyllrb.com/
- Stack Overflow: Tag [jekyll] or [github-pages]
- GitHub Community: https://github.community/
- Jekyll Docs: https://jekyllrb.com/docs/

**When asking for help, include:**
- Full error message (from Actions log)
- Your `_config.yml` (redact sensitive info)
- Relevant template code
- Link to repository (if public)
- What you've already tried

---

**Remember**: Most issues are configuration problems. Check `_config.yml`, file paths, and front matter first!
