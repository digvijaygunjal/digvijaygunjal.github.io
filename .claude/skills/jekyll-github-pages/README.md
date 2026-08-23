# Jekyll GitHub Pages Skill for Claude Code

A comprehensive Claude Code skill for building and publishing beautiful Jekyll websites to GitHub Pages - designed for non-developers who are familiar with GitHub basics.

## What This Skill Does

This skill helps you:
- **Create new Jekyll sites** (blogs, portfolios, documentation sites)
- **Publish to GitHub Pages** (free hosting at username.github.io)
- **Add content** (blog posts, pages, portfolio items)
- **Customize design** (automatically integrates with frontend-design skill for beautiful layouts)
- **Troubleshoot issues** (common errors and fixes included)

**Key Feature**: Automatically invokes the `frontend-design` skill when you need custom layouts, themes, or styling - ensuring your site has distinctive, professional aesthetics instead of generic templates.

## Requirements

- **Claude Code** (the CLI you're using right now!)
- **Git** (you already have this if you're familiar with GitHub)
- **Ruby** (check with `ruby -v`, install from https://www.ruby-lang.org/ if needed)
- **Jekyll & Bundler** (installed via `gem install jekyll bundler`)

## Installation

### 1. Clone this repository:
```bash
cd ~/Documents
git clone https://github.com/pauloschinzel/jekyll-gh-pages.git
```

### 2. Create symlink to Claude skills directory:
```bash
mkdir -p ~/.claude/skills
ln -s ~/Documents/jekyll-gh-pages ~/.claude/skills/jekyll-github-pages
```

### 3. Verify installation:
```bash
ls -la ~/.claude/skills/jekyll-github-pages
# Should show: jekyll-github-pages -> /Users/[your-username]/Documents/jekyll-gh-pages
```

### 4. Restart Claude Code CLI

The skill should now appear when you type `/jekyll-github-pages`

## Quick Start

Once installed, invoke the skill in Claude Code:

```
/jekyll-github-pages
```

Then ask Claude to help you with tasks like:
- "Create a new blog site about technology"
- "Add a new blog post about my recent project"
- "Design a custom hero section for my homepage" (auto-invokes frontend-design)
- "Deploy my site to GitHub Pages"
- "Help me troubleshoot a 404 error on my site"

## What's Included

### Templates
Pre-configured starter files for different site types:
- `_config-blog.yml` - Blog configuration with pagination and RSS
- `_config-portfolio.yml` - Portfolio site with collections
- `_config-docs.yml` - Documentation site structure
- `post-template.md` - Blog post template with proper front matter
- `page-template.md` - Static page template

### Rules & References
- `liquid-cheatsheet.md` - Quick reference for Liquid templating syntax
- `troubleshooting.md` - Solutions for common Jekyll and GitHub Pages issues

### Main Skill File
`SKILL.md` contains comprehensive instructions covering:
- Jekyll concepts explained for non-developers
- Step-by-step workflows for common tasks
- GitHub Pages deployment guide
- Custom design integration with frontend-design skill
- Troubleshooting and advanced features

## Use Cases

This skill supports three main use cases equally:

1. **Blogs** - Personal or professional blogging with posts, categories, tags
2. **Portfolios** - Showcase your work with project collections and galleries
3. **Documentation** - Technical documentation sites with navigation and search

## Design Integration

When you need custom layouts, styling, or design work, this skill **automatically invokes** the `frontend-design` skill to create:
- Custom page layouts and templates
- Hero sections, cards, galleries
- Responsive CSS/SCSS styling
- Distinctive color schemes and typography
- Professional, polished aesthetics

You don't need to manually call frontend-design - the skill handles this integration automatically.

## Updates & Version Control

Since this skill is a Git repository, you can:
- Pull updates: `cd ~/Documents/jekyll-gh-pages && git pull`
- Contribute improvements via pull requests
- Fork and customize for your needs
- Track changes and revert if needed

## Support & Resources

- **Jekyll Documentation**: https://jekyllrb.com/docs/
- **GitHub Pages Documentation**: https://docs.github.com/en/pages
- **Liquid Syntax**: https://shopify.github.io/liquid/
- **Report Issues**: https://github.com/pauloschinzel/jekyll-gh-pages/issues

## License

MIT License - see LICENSE file for details

## Author

Created by Paulo Schinzel for the Claude Code community.

---

**Note**: This skill is designed for users who already understand Git/GitHub basics. If you're new to Git, start with GitHub's learning resources first, then come back to build your Jekyll site!
