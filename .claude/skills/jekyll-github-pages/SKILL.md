---
name: jekyll-github-pages
description: Build and publish Jekyll websites to GitHub Pages with beautiful design - supports blogs, portfolios, and documentation sites for non-developers. Automatically integrates with frontend-design skill for custom layouts and styling.
disable-model-invocation: true
allowed-tools: Read, Write, Bash, Glob, Grep, Skill
---

# Jekyll GitHub Pages Skill

## Purpose & Overview

**What is Jekyll?**
Jekyll is a static site generator that transforms plain text files (written in Markdown) into complete HTML websites. Think of it as a tool that takes your content and automatically builds a professional website from it.

**What is GitHub Pages?**
GitHub Pages provides free hosting for static websites directly from your GitHub repository. Once you push your code to GitHub, it automatically builds and publishes your site.

**Why use Jekyll + GitHub Pages?**
- **No coding required** - Write content in Markdown, configure with simple YAML files
- **Free hosting** - GitHub Pages hosts your site at username.github.io for free
- **Built-in integration** - Jekyll is built into GitHub Pages, so deployment is automatic
- **Version control** - All your content is versioned with Git
- **Custom domains** - Use your own domain name (optional)
- **Fast and secure** - Static sites are fast, secure, and reliable

**Who is this for?**
Non-developers who are comfortable with GitHub basics but new to Jekyll. You should know how to use Git (clone, commit, push) but don't need web development experience.

## When to Use This Skill

Invoke this skill when you need to:

1. **Set up a new Jekyll site** (blog, portfolio, or documentation site)
2. **Publish an existing Jekyll site** to GitHub Pages
3. **Add new content** (blog posts, pages, portfolio items)
4. **Customize your site** (themes, layouts, styling)
5. **Troubleshoot build failures** or deployment issues

### Important: Automatic Design Integration

When you need custom layouts, styling, or design work, **this skill automatically invokes the `frontend-design` skill** - you don't need to call it manually. The frontend-design skill will be triggered automatically when:

- Creating custom layouts in `_layouts/` folder
- Designing page templates or components
- Adding custom CSS/SCSS styling
- Building HTML components for `_includes/`
- Creating hero sections, cards, galleries, navigation
- Establishing overall theme, colors, and typography

The frontend-design skill ensures your Jekyll site has distinctive, polished aesthetics instead of generic template looks.

## Prerequisites & Setup

Before starting, ensure you have the required software installed:

### Check Git (you should already have this)
```bash
git --version
# Should show: git version 2.x.x
```

### Check Ruby
```bash
ruby -v
# Should show: ruby 2.7.0 or higher
```

If Ruby is not installed:
- **macOS**: `brew install ruby` (requires Homebrew)
- **Windows**: Download from https://rubyinstaller.org/
- **Linux**: `sudo apt-get install ruby-full` (Ubuntu/Debian)

### Install Jekyll & Bundler
```bash
gem install jekyll bundler
```

Verify installation:
```bash
jekyll -v
# Should show: jekyll 4.x.x
```

### Text Editor
Use any editor you prefer:
- VS Code (recommended for beginners)
- Sublime Text
- Atom
- Or any text editor

## Jekyll Concepts Explained

These concepts are essential for working with Jekyll. Don't worry - they're simpler than they sound!

### Front Matter
A block of YAML at the top of files, enclosed by `---` lines. Contains metadata about the page:

```yaml
---
layout: post
title: "My First Post"
date: 2026-02-10
categories: [blog, tutorial]
---
```

### Layouts
HTML templates that wrap your content. Located in `_layouts/` folder. Common layouts:
- `default.html` - Basic page structure
- `post.html` - For blog posts
- `page.html` - For static pages

Your content gets inserted into the layout where `{{ content }}` appears.

### Includes
Reusable HTML snippets stored in `_includes/` folder. Examples:
- `header.html` - Site header/navigation
- `footer.html` - Site footer
- `sidebar.html` - Sidebar content

Include them in layouts: `{% include header.html %}`

### Posts
Blog articles stored in `_posts/` folder with a specific filename format:
```
YYYY-MM-DD-title-with-hyphens.md
```

Example: `2026-02-10-my-first-post.md`

### Pages
Static pages (About, Contact, etc.) that live in the root directory or custom folders:
- `about.md` → yoursite.com/about
- `contact.md` → yoursite.com/contact
- `pages/portfolio.md` → yoursite.com/pages/portfolio

### _config.yml
The main settings file for your entire site. Contains:
- Site title and description
- URLs and paths
- Theme selection
- Plugin configuration
- Build settings

**Important**: Changes to `_config.yml` require restarting the Jekyll server.

### Liquid
A template language for dynamic content. Uses special tags:

- **Variables**: `{{ variable }}` - Outputs content
- **Logic**: `{% if %}...{% endif %}` - Conditional statements
- **Loops**: `{% for item in collection %}...{% endfor %}` - Iterate over items

Example:
```liquid
{% for post in site.posts %}
  <h2>{{ post.title }}</h2>
  <p>{{ post.excerpt }}</p>
{% endfor %}
```

See `rules/liquid-cheatsheet.md` for a complete reference.

### Collections
Groups of related content beyond posts. Examples:
- Portfolio projects
- Team members
- Documentation sections

Defined in `_config.yml`:
```yaml
collections:
  portfolio:
    output: true
    permalink: /portfolio/:name/
```

### Data Files
Store structured data in `_data/` folder (YAML, JSON, or CSV):
- `_data/team.yml` - Team member info
- `_data/projects.json` - Project details

Access in templates: `site.data.team`

## Common Workflows

### 5.1 Create a New Jekyll Site

**Step 1: Create the site**
```bash
# Navigate to your projects folder
cd ~/projects

# Create new Jekyll site
jekyll new my-site-name

# Navigate into the site
cd my-site-name
```

**Step 2: Test locally**
```bash
# Start the development server
bundle exec jekyll serve

# Open your browser to: http://localhost:4000
# The site will auto-rebuild when you save changes
```

**Step 3: Choose configuration based on your use case**

Copy the appropriate template from this skill's `templates/` folder:

- **For a blog**: Use `templates/_config-blog.yml`
- **For a portfolio**: Use `templates/_config-portfolio.yml`
- **For documentation**: Use `templates/_config-docs.yml`

Replace your `_config.yml` with the chosen template, then customize:
- `title`: Your site name
- `description`: Brief description for SEO
- `url`: Will be your GitHub Pages URL (e.g., `https://username.github.io`)
- `baseurl`: Leave empty for username.github.io, or `/repo-name` for project sites

**Step 4: Customize further**
- Replace `index.md` with your homepage content
- Edit `about.md` to add your about page
- Remove default example posts in `_posts/` folder

### 5.2 Add Content

#### Create a Blog Post

**Step 1: Create the file**
```bash
# Create file in _posts/ with correct naming format
# Format: YYYY-MM-DD-title-with-hyphens.md
touch _posts/2026-02-10-my-first-post.md
```

**Step 2: Add front matter and content**

Use `templates/post-template.md` as a starting point:

```markdown
---
layout: post
title: "My First Blog Post"
date: 2026-02-10 10:00:00 -0000
categories: [technology, tutorial]
tags: [jekyll, blogging]
author: Your Name
excerpt: "A brief summary that appears in post listings and SEO"
---

Your post content starts here in Markdown format.

## Subheading

Write naturally with **bold** and *italic* text.

- Bullet points work
- Just like any Markdown

[Links are easy](https://example.com)

![Add images too](/assets/images/photo.jpg)
```

**Step 3: Preview**
```bash
bundle exec jekyll serve
# Visit http://localhost:4000 to see your new post
```

#### Create a Static Page

**Step 1: Create the file**
```bash
# In root directory for top-level pages
touch services.md

# Or in a subfolder for organization
mkdir pages
touch pages/services.md
```

**Step 2: Add front matter and content**

Use `templates/page-template.md` as a starting point:

```markdown
---
layout: page
title: Our Services
permalink: /services/
---

Your page content in Markdown format.
```

The `permalink` controls the URL where this page appears.

### 5.3 Customize Your Site

#### Edit Site Configuration

Open `_config.yml` and customize these key settings:

```yaml
# Site identity
title: My Awesome Site
description: A blog about technology and creativity
author: Your Name

# URLs (critical for GitHub Pages)
url: "https://username.github.io"
baseurl: ""  # Leave empty for user site, or "/repo-name" for project site

# Social links (if theme supports)
github_username: yourusername
twitter_username: yourusername

# Theme
theme: minima  # Or any GH Pages supported theme
# remote_theme: owner/repo  # For non-default themes

# Plugins (must be on GH Pages whitelist)
plugins:
  - jekyll-feed          # RSS feed
  - jekyll-seo-tag       # SEO optimization
  - jekyll-sitemap       # XML sitemap
  - jekyll-paginate      # Pagination

# Pagination
paginate: 10
paginate_path: "/page:num/"

# Build settings
markdown: kramdown
```

**After editing**: Restart the Jekyll server (Ctrl+C, then `bundle exec jekyll serve`)

#### Choose a Theme

**Option 1: GitHub Pages Supported Themes**

These themes work out-of-the-box on GitHub Pages:
- `minima` (default, clean and simple)
- `jekyll-theme-architect`
- `jekyll-theme-cayman`
- `jekyll-theme-hacker`
- `jekyll-theme-minimal`
- `jekyll-theme-slate`

Full list: https://pages.github.com/themes/

To use one, add to `_config.yml`:
```yaml
theme: jekyll-theme-cayman
```

**Option 2: Remote Themes (more options)**

Use any theme hosted on GitHub:
```yaml
remote_theme: mmistakes/minimal-mistakes
# Or: pages-themes/architect@v0.2.0
```

Popular remote themes:
- `mmistakes/minimal-mistakes` - Feature-rich, documentation-friendly
- `jeffreytse/jekyll-theme-yat` - Modern, responsive blog theme
- `artemsheludko/flexible-jekyll` - Simple portfolio/blog

**Option 3: Custom Design with frontend-design Skill**

When you need a completely custom look, automatically invoke the frontend-design skill:

**Workflow:**
1. Describe your design needs: "Create a modern hero section with gradient background"
2. The skill automatically calls frontend-design
3. Receive production-grade HTML/CSS code
4. Integrate into Jekyll structure:
   - HTML → `_layouts/` or `_includes/`
   - CSS → `assets/css/custom.css`
   - Images → `assets/images/`
5. Reference in your templates:
   ```liquid
   {% include hero.html %}
   ```
   Or add CSS to head:
   ```html
   <link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}">
   ```

**Custom Design Examples:**
- "Design a custom homepage layout with hero section, feature cards, and newsletter signup"
- "Create a portfolio grid layout with hover effects"
- "Build a custom navigation menu with dropdown support"
- "Design an article layout with sidebar and table of contents"

The frontend-design skill ensures your site looks distinctive and professional, not generic.

#### Override Theme Layouts

To customize a theme's layout:

**Step 1: Find the theme's layouts**
```bash
# Locate your theme
bundle info --path minima
# Copy the path shown
```

**Step 2: Copy layout to your site**
```bash
# Create layouts folder
mkdir -p _layouts

# Copy theme layout (example for default.html)
cp [theme-path]/_layouts/default.html _layouts/default.html
```

**Step 3: Edit the copied file**

Your local version now overrides the theme version. Edit as needed, or use frontend-design skill for custom designs.

### 5.4 Deploy to GitHub Pages

#### Step 1: Create GitHub Repository

**For a user/organization site** (yourname.github.io):
```bash
# Repository name MUST be: username.github.io
```
Your site will be at: `https://username.github.io`

**For a project site** (any name):
```bash
# Repository can be named anything
```
Your site will be at: `https://username.github.io/repo-name`

**Create the repository:**
```bash
gh repo create my-site --public --description "My Jekyll site"
```

Or create manually on GitHub.com.

#### Step 2: Configure _config.yml for GitHub Pages

**For user site (username.github.io):**
```yaml
url: "https://username.github.io"
baseurl: ""
```

**For project site:**
```yaml
url: "https://username.github.io"
baseurl: "/repo-name"
```

**Important**: The `baseurl` is critical for links and assets to work correctly on GitHub Pages.

#### Step 3: Push to GitHub

If starting from scratch:
```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial Jekyll site"

# Rename branch to main
git branch -M main

# Add remote (replace URL with your repo)
git remote add origin https://github.com/username/repo-name.git

# Push to GitHub
git push -u origin main
```

If repository already has a remote:
```bash
git add .
git commit -m "Deploy Jekyll site"
git push
```

#### Step 4: Enable GitHub Pages

**Via Web Interface:**
1. Go to your repository on GitHub
2. Click **Settings** → **Pages** (in sidebar)
3. Under "Source":
   - Select branch: `main`
   - Select folder: `/ (root)`
4. Click **Save**

**Via gh CLI:**
```bash
gh repo edit --enable-pages --pages-branch main
```

#### Step 5: Wait for Deployment

- First deployment takes 1-2 minutes
- Subsequent deploys take 30-60 seconds
- Check build status: Repository → **Actions** tab
- Look for green checkmark ✓

#### Step 6: Visit Your Site

- User site: `https://username.github.io`
- Project site: `https://username.github.io/repo-name`

**Troubleshooting**: If you see a 404, check:
- Did GitHub Pages build successfully? (Actions tab)
- Is your `baseurl` correct in `_config.yml`?
- Did you wait 1-2 minutes for first deploy?

See `rules/troubleshooting.md` for detailed solutions.

### 5.5 Update Content Workflow

Once your site is live, use this workflow to add or update content:

**Step 1: Create/edit content locally**
```bash
# Create new post
touch _posts/2026-02-11-second-post.md
# Add front matter and content

# Or edit existing file
nano _posts/2026-02-10-my-first-post.md
```

**Step 2: Test locally**
```bash
bundle exec jekyll serve
# Preview at http://localhost:4000
# Verify changes look correct
```

**Step 3: Commit changes**
```bash
git add .
git commit -m "Add new blog post about topic X"
```

**Step 4: Push to GitHub**
```bash
git push
```

**Step 5: GitHub Pages automatically rebuilds**
- Watch the Actions tab for build status
- Site updates in 30-60 seconds
- Visit your live site to verify changes

**That's it!** This workflow is the core of maintaining your Jekyll site.

## GitHub Pages Specific Configuration

GitHub Pages has some limitations and special requirements to be aware of:

### Allowed Plugins (Whitelist Only)

GitHub Pages only allows these plugins:
- `jekyll-coffeescript`
- `jekyll-default-layout`
- `jekyll-feed` - RSS feed generation
- `jekyll-gist` - Embed GitHub Gists
- `jekyll-github-metadata` - Access repo metadata
- `jekyll-optional-front-matter`
- `jekyll-paginate` - Pagination for posts
- `jekyll-readme-index`
- `jekyll-redirect-from` - Redirect old URLs
- `jekyll-relative-links`
- `jekyll-remote-theme` - Use themes from GitHub
- `jekyll-seo-tag` - SEO optimization
- `jekyll-sitemap` - XML sitemap generation
- `jekyll-titles-from-headings`
- `jemoji` - Emoji support

**To use non-whitelisted plugins:**

You'll need to build your site locally and commit the `_site/` folder:

```bash
# 1. Build site locally
bundle exec jekyll build

# 2. Commit _site folder
git add _site
git commit -m "Add built site"

# 3. Create gh-pages branch from _site
git subtree push --prefix _site origin gh-pages

# 4. Change GitHub Pages to deploy from gh-pages branch
```

### Supported Themes

GitHub Pages supports these themes out-of-the-box:
- `minima` (default)
- `architect`
- `cayman`
- `dinky`
- `hacker`
- `leap-day`
- `merlot`
- `midnight`
- `minimal`
- `modernist`
- `slate`
- `tactile`
- `time-machine`

For other themes, use `remote_theme` instead of `theme`.

### URL Configuration

**Critical**: Set these correctly in `_config.yml`:

**For username.github.io:**
```yaml
url: "https://username.github.io"
baseurl: ""  # EMPTY for user sites
```

**For project sites:**
```yaml
url: "https://username.github.io"
baseurl: "/repo-name"  # MUST include leading slash
```

**In templates**, always use:
```liquid
{{ site.baseurl }}/path/to/resource
# Or the filter:
{{ "/path/to/resource" | relative_url }}
```

This ensures links work both locally and on GitHub Pages.

### Build Environment

GitHub Pages uses:
- Ruby 2.7.x
- Jekyll 3.9.x (not latest 4.x)
- Specific gem versions (managed by GitHub)

To match locally:
```ruby
# Gemfile
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
```

Then run:
```bash
bundle install
bundle update github-pages
```

This ensures your local environment matches GitHub Pages exactly.

## Troubleshooting Common Issues

For detailed solutions, see `rules/troubleshooting.md`. Here are quick fixes for the most common problems:

### Site Shows 404 After Deployment

**Symptoms**: GitHub Pages is enabled, build succeeded, but site shows "404 Not Found"

**Fixes**:
1. Check `baseurl` in `_config.yml`:
   - User site: should be empty (`baseurl: ""`)
   - Project site: should be `/repo-name` (with leading slash)
2. Wait 2-3 minutes - first deploy is slower
3. Check Actions tab for build errors
4. Verify GitHub Pages is enabled and using correct branch

### Site Not Updating After Push

**Symptoms**: You pushed changes but they don't appear on the live site

**Fixes**:
1. Check Actions tab - build might have failed
2. Clear browser cache (Cmd+Shift+R or Ctrl+Shift+R)
3. Wait 1-2 minutes - builds aren't instant
4. Check if you edited `_config.yml` - requires full rebuild
5. Look for build errors in Actions tab

### Theme Not Working

**Symptoms**: Site looks broken, missing styles

**Fixes**:
1. Verify theme name is correct in `_config.yml`
2. For GH Pages themes, use exact name: `theme: minima`
3. For external themes, use `remote_theme: owner/repo`
4. Check theme is on GH Pages supported list
5. Add theme to Gemfile:
   ```ruby
   gem "minima", "~> 2.5"
   ```
6. Run `bundle install`

### Broken Links or Images

**Symptoms**: Links work locally but not on GitHub Pages

**Fixes**:
1. Use `relative_url` filter for all links:
   ```liquid
   {{ "/assets/image.jpg" | relative_url }}
   ```
2. Check `baseurl` is set correctly in `_config.yml`
3. For project sites, all paths need `baseurl` prefix
4. Verify file paths are correct (case-sensitive on GitHub)

### Build Fails with Plugin Error

**Symptoms**: Build fails with "plugin not found" or "unsupported plugin"

**Fixes**:
1. Check if plugin is on GH Pages whitelist (see section above)
2. Remove unsupported plugins from `_config.yml`
3. Or build locally and deploy from gh-pages branch
4. Common issue: using Jekyll 4.x plugins (GH Pages uses 3.9)

### Local Site Works, GitHub Pages Doesn't

**Symptoms**: `jekyll serve` works fine, but GH Pages build fails

**Fixes**:
1. Match GH Pages environment in Gemfile:
   ```ruby
   gem "github-pages", group: :jekyll_plugins
   ```
2. Run `bundle update github-pages`
3. Check for non-whitelisted plugins
4. Verify all paths are relative, not absolute
5. Check Actions tab for specific error message

### Liquid Syntax Errors

**Symptoms**: Build fails with "Liquid Exception" error

**Fixes**:
1. Check for unmatched tags: `{% if %}` needs `{% endif %}`
2. Check for typos in variable names
3. Use `raw` tag for literal Liquid code:
   ```liquid
   {% raw %}
   {{ this won't be processed }}
   {% endraw %}
   ```
4. Validate front matter YAML (must start with `---`)

## Advanced Features

### Custom Domain

**Step 1: Add CNAME file**
```bash
# Create CNAME file in root
echo "www.yourdomain.com" > CNAME
git add CNAME
git commit -m "Add custom domain"
git push
```

**Step 2: Configure DNS**

At your domain registrar, add DNS records:

**For apex domain (yourdomain.com):**
```
A record:
  Host: @
  Points to: 185.199.108.153
  (Also add .109, .110, .111 for redundancy)
```

**For www subdomain:**
```
CNAME record:
  Host: www
  Points to: username.github.io
```

**Step 3: Enable HTTPS**
- Go to repo Settings → Pages
- Check "Enforce HTTPS"
- Wait 24 hours for certificate provisioning

### Collections for Portfolios

Collections let you organize content beyond posts. Perfect for portfolios, team pages, documentation sections.

**Step 1: Define collection in _config.yml**
```yaml
collections:
  portfolio:
    output: true
    permalink: /portfolio/:name/
  team:
    output: false  # Just data, no individual pages
```

**Step 2: Create collection folder and files**
```bash
mkdir _portfolio
touch _portfolio/project-one.md
```

**Step 3: Add front matter**
```markdown
---
title: Project One
client: Acme Corp
date: 2026-01-15
image: /assets/portfolio/project-one.jpg
---

Project description and details here.
```

**Step 4: Display collection**
```liquid
{% for project in site.portfolio %}
  <div class="project">
    <h2>{{ project.title }}</h2>
    <p>{{ project.excerpt }}</p>
    <a href="{{ project.url | relative_url }}">View Project</a>
  </div>
{% endfor %}
```

### Data Files

Store structured data for reuse across your site.

**Step 1: Create data file**
```bash
mkdir _data
touch _data/team.yml
```

**Step 2: Add data (YAML example)**
```yaml
# _data/team.yml
- name: Alice Johnson
  role: Designer
  bio: "Alice creates beautiful interfaces."
  twitter: alicej

- name: Bob Smith
  role: Developer
  bio: "Bob builds robust applications."
  github: bobsmith
```

**Step 3: Use in templates**
```liquid
{% for member in site.data.team %}
  <div class="team-member">
    <h3>{{ member.name }}</h3>
    <p class="role">{{ member.role }}</p>
    <p>{{ member.bio }}</p>
  </div>
{% endfor %}
```

Data files can be YAML, JSON, or CSV format.

### Pagination

For multi-page post listings:

**Step 1: Add to _config.yml**
```yaml
plugins:
  - jekyll-paginate

paginate: 10  # Posts per page
paginate_path: "/page:num/"
```

**Step 2: Update index.html**
```liquid
---
layout: default
---

{% for post in paginator.posts %}
  <article>
    <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
    {{ post.excerpt }}
  </article>
{% endfor %}

<!-- Pagination links -->
{% if paginator.total_pages > 1 %}
  <div class="pagination">
    {% if paginator.previous_page %}
      <a href="{{ paginator.previous_page_path | relative_url }}">Previous</a>
    {% endif %}

    <span>Page {{ paginator.page }} of {{ paginator.total_pages }}</span>

    {% if paginator.next_page %}
      <a href="{{ paginator.next_page_path | relative_url }}">Next</a>
    {% endif %}
  </div>
{% endif %}
```

### Categories and Tags

**Add to post front matter:**
```yaml
---
layout: post
title: "My Post"
categories: [technology, web-development]
tags: [jekyll, ruby, static-sites]
---
```

**Create category/tag pages:**
```bash
mkdir -p categories
touch categories/technology.md
```

```markdown
---
layout: category
title: Technology Posts
category: technology
permalink: /categories/technology/
---
```

**List posts by category:**
```liquid
{% for post in site.categories.technology %}
  <h2>{{ post.title }}</h2>
{% endfor %}
```

### Search Functionality

For static site search, use external services:

**Option 1: Simple JS search (client-side)**
- Use lunr.js or other JavaScript search library
- Generate search index from posts at build time

**Option 2: External search service**
- Algolia (free tier available)
- Google Custom Search
- DuckDuckGo site search

### Comments

Jekyll sites are static, so comments require external services:

**Popular options:**
- Disqus (easy, free)
- Utterances (uses GitHub issues, open-source)
- Staticman (writes comments as git commits)
- giscus (GitHub discussions-based)

## Templates Available

This skill includes starter templates in the `templates/` folder:

### Configuration Templates

**templates/_config-blog.yml**
- Optimized for blogging
- Post pagination enabled
- RSS feed plugin
- Categories and tags support
- Default post layout
- SEO tags

**templates/_config-portfolio.yml**
- Portfolio collections configured
- Project showcase structure
- Optional blog section
- Gallery/grid layouts
- Custom permalinks

**templates/_config-docs.yml**
- Documentation site structure
- Sidebar navigation
- Breadcrumb support
- Table of contents
- Search preparation

### Content Templates

**templates/post-template.md**
- Complete blog post structure
- All common front matter fields
- Markdown examples
- Image and link syntax

**templates/page-template.md**
- Static page structure
- Minimal front matter
- Permalink configuration

**See `templates/README.md`** for detailed usage instructions and customization guidance.

## Additional Resources

### Official Documentation
- **Jekyll Docs**: https://jekyllrb.com/docs/
- **GitHub Pages Docs**: https://docs.github.com/en/pages
- **Liquid Syntax**: https://shopify.github.io/liquid/

### Themes & Plugins
- **GH Pages Supported Themes**: https://pages.github.com/themes/
- **Jekyll Themes Directory**: http://jekyllthemes.org/
- **Jekyll Plugins**: https://jekyllrb.com/docs/plugins/

### Learning Resources
- **Jekyll Step-by-Step Tutorial**: https://jekyllrb.com/docs/step-by-step/01-setup/
- **GitHub Pages Quickstart**: https://docs.github.com/en/pages/quickstart
- **Markdown Guide**: https://www.markdownguide.org/

### Community
- **Jekyll Talk**: https://talk.jekyllrb.com/
- **GitHub Pages Community**: https://github.community/
- **Stack Overflow**: Tag questions with [jekyll] or [github-pages]

## Quick Reference Commands

```bash
# Create new Jekyll site
jekyll new site-name
cd site-name

# Serve locally with auto-rebuild
bundle exec jekyll serve
# Access at: http://localhost:4000

# Serve with drafts visible
bundle exec jekyll serve --drafts

# Serve on different port
bundle exec jekyll serve --port 4001

# Build for production (output to _site/)
bundle exec jekyll build

# Build with production environment
JEKYLL_ENV=production bundle exec jekyll build

# Update dependencies
bundle update

# Update just github-pages gem
bundle update github-pages

# Check Jekyll version
jekyll -v

# Check Ruby version
ruby -v

# Clean build artifacts
bundle exec jekyll clean

# Create new post (with jekyll-compose plugin)
bundle exec jekyll post "My New Post"

# Create new page
bundle exec jekyll page "About"

# Create new draft
bundle exec jekyll draft "Work in Progress"
```

## Summary

This skill guides you through:
1. ✅ **Creating Jekyll sites** (blogs, portfolios, docs)
2. ✅ **Adding content** (posts, pages, collections)
3. ✅ **Customizing design** (themes, layouts, CSS - with frontend-design integration)
4. ✅ **Deploying to GitHub Pages** (automatic hosting)
5. ✅ **Troubleshooting issues** (common problems solved)

**Remember**:
- Write content in Markdown
- Configure with `_config.yml`
- Test locally with `bundle exec jekyll serve`
- Deploy by pushing to GitHub
- Automatically invoke frontend-design for custom layouts and styling

**For detailed troubleshooting**, see `rules/troubleshooting.md`

**For Liquid syntax**, see `rules/liquid-cheatsheet.md`

**For templates**, see `templates/` folder

Happy building! 🚀
