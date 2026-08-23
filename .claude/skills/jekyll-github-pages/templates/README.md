# Jekyll Templates

This folder contains starter templates for different types of Jekyll sites. Use these templates as starting points for your own site configuration and content.

## Configuration Templates

### `_config-blog.yml`

**Use this for**: Personal or professional blogs

**Features**:
- Post pagination (10 posts per page)
- RSS feed generation
- Category and tag support
- SEO optimization
- Social media integration
- Default post layout

**How to use**:
1. Copy this file to your Jekyll site root as `_config.yml`
2. Customize the values (title, description, author, etc.)
3. Update social usernames
4. Set correct `url` and `baseurl`

**Customization checklist**:
- [ ] Site title and description
- [ ] Author name and email
- [ ] URL and baseurl
- [ ] Social media usernames
- [ ] Timezone
- [ ] Permalink structure (if desired)

---

### `_config-portfolio.yml`

**Use this for**: Portfolio sites, creative showcases, freelancer sites

**Features**:
- Portfolio collections (projects, case studies)
- Skills and services sections
- Optional blog section
- Social links (including design platforms like Behance, Dribbble)
- Contact information

**How to use**:
1. Copy this file to your Jekyll site root as `_config.yml`
2. Customize personal information
3. Update skills, services, and bio
4. Create `_portfolio/` folder for projects

**Customization checklist**:
- [ ] Personal information (name, email, location)
- [ ] Bio and description
- [ ] Skills list with proficiency levels
- [ ] Services offered
- [ ] Social profiles (including design platforms)
- [ ] Portfolio grid settings

**Creating portfolio items**:
```bash
mkdir _portfolio
touch _portfolio/project-name.md
```

Each portfolio item should have front matter like:
```yaml
---
title: Project Name
client: Client Name
date: 2026-02-10
category: [Web Design, Branding]
image: /assets/portfolio/project-image.jpg
featured: true
---
```

---

### `_config-docs.yml`

**Use this for**: Documentation sites, API references, technical guides

**Features**:
- Multiple documentation collections (docs, guides, API)
- Navigation structure
- Table of contents
- Breadcrumb navigation
- Code syntax highlighting
- "Edit on GitHub" links
- Version tracking

**How to use**:
1. Copy this file to your Jekyll site root as `_config.yml`
2. Update project name and repository URL
3. Customize navigation structure
4. Create collection folders (`_docs/`, `_guides/`, `_api/`)

**Customization checklist**:
- [ ] Project name and description
- [ ] GitHub repository URL
- [ ] Version number
- [ ] Navigation structure
- [ ] Collection folders created
- [ ] Baseurl (important for project sites)

**Documentation structure**:
```bash
mkdir _docs _guides _api
touch _docs/getting-started.md
touch _guides/basic-usage.md
touch _api/overview.md
```

Each doc should have front matter like:
```yaml
---
title: Getting Started
order: 1
toc: true
---
```

---

## Content Templates

### `post-template.md`

**Use this for**: Creating new blog posts

**Includes**:
- Complete front matter with all common fields
- Markdown formatting examples
- Code block examples
- Image syntax
- Table syntax
- Blockquote examples

**How to use**:
1. Copy to `_posts/` folder with correct naming: `YYYY-MM-DD-title.md`
2. Update front matter (title, date, categories, tags)
3. Replace content with your actual post
4. Add images to `/assets/images/`

**Front matter fields explained**:
- `layout`: Template to use (usually "post")
- `title`: Post title (shown in listings and page)
- `date`: Publication date and time
- `categories`: Broad groupings (e.g., technology, design)
- `tags`: Specific keywords (e.g., jekyll, tutorial, css)
- `author`: Author name
- `excerpt`: Summary for listings and SEO
- `image`: Featured image path
- `featured`: Whether to highlight this post
- `comments`: Enable/disable comments

---

### `page-template.md`

**Use this for**: Creating static pages (About, Contact, Services, etc.)

**Includes**:
- Basic page front matter
- Common page sections
- Markdown formatting
- Call-to-action examples

**How to use**:
1. Copy to root directory or `pages/` folder
2. Name it appropriately (e.g., `about.md`, `contact.md`)
3. Update front matter
4. Add your content

**Common pages to create**:
- `about.md` - About you or your project
- `contact.md` - Contact information and form
- `services.md` - Services you offer (for portfolios)
- `portfolio.md` - Portfolio landing page
- `blog.md` - Blog landing page (if not using index)

---

## Choosing the Right Template

| Site Type | Use This Config | Create These Folders | Focus On |
|-----------|----------------|---------------------|----------|
| **Blog** | `_config-blog.yml` | `_posts/` | Writing posts, categories, tags |
| **Portfolio** | `_config-portfolio.yml` | `_portfolio/`, `_case-studies/` | Projects, images, case studies |
| **Documentation** | `_config-docs.yml` | `_docs/`, `_guides/`, `_api/` | Clear structure, navigation, examples |

## Combining Templates

You can mix features from multiple templates:

**Blog + Portfolio**:
- Start with `_config-portfolio.yml`
- Add pagination settings from `_config-blog.yml`
- Create both `_posts/` and `_portfolio/` folders

**Documentation + Blog**:
- Start with `_config-docs.yml`
- Add post settings from `_config-blog.yml`
- Create `_posts/` folder alongside `_docs/`

## Common Customizations

### Changing Permalink Structure

In `_config.yml`:
```yaml
# Default: /YYYY/MM/DD/title/
permalink: /:year/:month/:day/:title/

# Just title: /my-post-title/
permalink: /:title/

# With category: /category-name/my-post-title/
permalink: /:categories/:title/

# Custom: /blog/my-post-title/
permalink: /blog/:title/
```

### Adding Custom Collections

In `_config.yml`:
```yaml
collections:
  your-collection-name:
    output: true
    permalink: /your-collection/:name/
```

Then create folder: `_your-collection-name/`

### Enabling Features

Most features are enabled in `_config.yml`:

```yaml
# RSS Feed
plugins:
  - jekyll-feed

# SEO Tags
plugins:
  - jekyll-seo-tag

# Sitemap
plugins:
  - jekyll-sitemap

# Pagination
plugins:
  - jekyll-paginate
paginate: 10
```

## Troubleshooting

**Problem**: Changes to `_config.yml` not appearing

**Solution**: Restart Jekyll server (Ctrl+C, then `bundle exec jekyll serve`)

---

**Problem**: Permalinks not working as expected

**Solution**: Check `baseurl` setting and ensure you're using `{{ post.url | relative_url }}` in templates

---

**Problem**: Collections not showing up

**Solution**:
1. Verify collection is defined in `_config.yml`
2. Ensure folder name matches: `_collection-name/`
3. Restart Jekyll server

---

**Problem**: Syntax highlighting not working

**Solution**: Add to `_config.yml`:
```yaml
markdown: kramdown
highlighter: rouge
```

## Next Steps

After choosing and customizing a template:

1. **Test locally**: `bundle exec jekyll serve`
2. **Add content**: Create posts, pages, or portfolio items
3. **Customize design**: Edit theme or use frontend-design skill
4. **Deploy**: Push to GitHub and enable GitHub Pages

For more help, see the main `SKILL.md` file.
