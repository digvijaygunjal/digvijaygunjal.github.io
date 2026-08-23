# Liquid Template Language Cheat Sheet

Quick reference for Liquid syntax in Jekyll templates.

## What is Liquid?

Liquid is a template language that lets you add dynamic content to your Jekyll site. It uses special tags to output variables, apply logic, and loop through data.

## Basic Syntax

### Output Tags `{{ }}`

Display content from variables:

```liquid
{{ variable }}
{{ page.title }}
{{ site.author }}
```

### Logic Tags `{% %}`

Control flow and logic:

```liquid
{% if condition %}
  Do something
{% endif %}

{% for item in collection %}
  Display item
{% endfor %}
```

## Variables

### Page Variables

Available in posts and pages:

```liquid
{{ page.title }}          # Page/post title
{{ page.date }}           # Publication date
{{ page.url }}            # Page URL
{{ page.content }}        # Full content
{{ page.excerpt }}        # Post excerpt
{{ page.categories }}     # Categories array
{{ page.tags }}           # Tags array
{{ page.author }}         # Author name
{{ page.layout }}         # Layout name
```

### Site Variables

Global site information:

```liquid
{{ site.title }}          # Site title (from _config.yml)
{{ site.description }}    # Site description
{{ site.url }}            # Site URL
{{ site.baseurl }}        # Base URL path
{{ site.time }}           # Current time
{{ site.posts }}          # All posts array
{{ site.pages }}          # All pages array
{{ site.data }}           # Data files
```

### Post Variables

In loops over posts:

```liquid
{% for post in site.posts %}
  {{ post.title }}
  {{ post.date }}
  {{ post.url }}
  {{ post.excerpt }}
  {{ post.categories }}
  {{ post.tags }}
  {{ post.content }}
{% endfor %}
```

## Filters

Modify output using filters with the `|` pipe character.

### String Filters

```liquid
{{ "hello" | capitalize }}           # Hello
{{ "Hello World" | downcase }}       # hello world
{{ "hello world" | upcase }}         # HELLO WORLD
{{ "hello world" | replace: "world", "Jekyll" }}  # hello Jekyll
{{ "hello" | append: " world" }}     # hello world
{{ " hello " | strip }}              # hello
{{ "hello world" | truncate: 8 }}    # hello...
{{ "hello world" | truncatewords: 1 }}  # hello...
{{ "hello" | size }}                 # 5
```

### Array Filters

```liquid
{{ site.posts | size }}              # Number of posts
{{ site.posts | first }}             # First post
{{ site.posts | last }}              # Last post
{{ site.posts | sort: "title" }}     # Sort by title
{{ site.posts | reverse }}           # Reverse order
{{ site.posts | where: "featured", true }}  # Filter by property
{{ site.posts | map: "title" }}      # Extract titles only
{{ array | join: ", " }}             # Join with comma
{{ array | uniq }}                   # Remove duplicates
```

### Date Filters

```liquid
{{ page.date | date: "%B %d, %Y" }}           # February 10, 2026
{{ page.date | date: "%Y-%m-%d" }}            # 2026-02-10
{{ page.date | date: "%b %d" }}               # Feb 10
{{ page.date | date: "%A, %B %d, %Y" }}       # Monday, February 10, 2026
{{ "now" | date: "%Y-%m-%d %H:%M" }}          # Current date/time
```

Common date format codes:
- `%Y` - Year (2026)
- `%m` - Month (02)
- `%d` - Day (10)
- `%B` - Month name (February)
- `%b` - Abbreviated month (Feb)
- `%A` - Day name (Monday)
- `%a` - Abbreviated day (Mon)
- `%H` - Hour (24-hour)
- `%I` - Hour (12-hour)
- `%M` - Minute
- `%p` - AM/PM

### URL Filters

```liquid
{{ "/assets/style.css" | relative_url }}     # Adds baseurl
{{ "/assets/style.css" | absolute_url }}     # Full URL with domain
{{ page.url | relative_url }}                # Relative page URL
{{ "hello world" | slugify }}                # hello-world
{{ "path/to/file.html" | split: "/" | last }}  # file.html
```

### Number Filters

```liquid
{{ 4 | plus: 2 }}                    # 6
{{ 4 | minus: 2 }}                   # 2
{{ 4 | times: 2 }}                   # 8
{{ 4 | divided_by: 2 }}              # 2
{{ 4.5 | round }}                    # 5
{{ 4.5 | floor }}                    # 4
{{ 4.5 | ceil }}                     # 5
```

### Array/String Access

```liquid
{{ "hello"[0] }}                     # h
{{ array[0] }}                       # First element
{{ array[-1] }}                      # Last element
```

## Control Flow

### If Statements

```liquid
{% if page.featured %}
  <span class="badge">Featured</span>
{% endif %}

{% if page.author %}
  <p>By {{ page.author }}</p>
{% else %}
  <p>Author unknown</p>
{% endif %}

{% if post.categories contains "tutorial" %}
  <span>Tutorial</span>
{% endif %}
```

### Unless (opposite of if)

```liquid
{% unless page.published == false %}
  <p>This post is published</p>
{% endunless %}
```

### Case/When (switch statement)

```liquid
{% case page.category %}
  {% when "blog" %}
    <p>Blog post</p>
  {% when "tutorial" %}
    <p>Tutorial</p>
  {% else %}
    <p>Other content</p>
{% endcase %}
```

## Loops

### For Loop

```liquid
{% for post in site.posts %}
  <article>
    <h2>{{ post.title }}</h2>
    <p>{{ post.excerpt }}</p>
  </article>
{% endfor %}
```

### Loop with Limit and Offset

```liquid
{% for post in site.posts limit:5 %}
  # Show only first 5 posts
{% endfor %}

{% for post in site.posts offset:5 limit:5 %}
  # Skip first 5, show next 5
{% endfor %}
```

### Loop with Reverse

```liquid
{% for post in site.posts reversed %}
  # Oldest first
{% endfor %}
```

### Loop Variables

```liquid
{% for post in site.posts %}
  {{ forloop.index }}      # Current iteration (1-indexed)
  {{ forloop.index0 }}     # Current iteration (0-indexed)
  {{ forloop.length }}     # Total iterations
  {{ forloop.first }}      # true if first iteration
  {{ forloop.last }}       # true if last iteration
{% endfor %}
```

### Break and Continue

```liquid
{% for post in site.posts %}
  {% if post.draft %}
    {% continue %}         # Skip this iteration
  {% endif %}

  {% if forloop.index == 10 %}
    {% break %}            # Stop loop
  {% endif %}
{% endfor %}
```

## Comparisons

### Operators

```liquid
==    # Equal
!=    # Not equal
>     # Greater than
<     # Less than
>=    # Greater than or equal
<=    # Less than or equal
contains  # Contains (for strings/arrays)
```

### Examples

```liquid
{% if page.title == "Home" %}
{% if page.featured != false %}
{% if post.date > site.time %}
{% if page.tags contains "jekyll" %}
{% if page.tags.size > 0 %}
```

### Logical Operators

```liquid
{% if page.featured and page.published %}
  # Both must be true
{% endif %}

{% if page.featured or page.pinned %}
  # Either can be true
{% endif %}
```

## Includes

Include reusable snippets:

```liquid
{% include header.html %}

{% include sidebar.html author="John Doe" %}

{% include post-preview.html post=post %}
```

In the included file, access variables:

```liquid
{{ include.author }}
{{ include.post.title }}
```

## Comments

```liquid
{% comment %}
This is a comment and won't appear in output
{% endcomment %}

{%- comment -%}
Hyphens strip whitespace before/after
{%- endcomment -%}
```

## Raw (Escape Liquid)

Prevent Liquid processing:

```liquid
{% raw %}
  {{ This won't be processed }}
  {% This either %}
{% endraw %}
```

## Whitespace Control

Use hyphens to strip whitespace:

```liquid
{%- if true -%}
  No whitespace before or after
{%- endif -%}

{{- variable -}}  # Strip whitespace around output
```

## Common Patterns

### Recent Posts

```liquid
<h2>Recent Posts</h2>
{% for post in site.posts limit:5 %}
  <article>
    <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
    <time datetime="{{ post.date | date_to_xmlschema }}">
      {{ post.date | date: "%B %d, %Y" }}
    </time>
    <p>{{ post.excerpt }}</p>
  </article>
{% endfor %}
```

### Posts by Category

```liquid
<h2>{{ category }} Posts</h2>
{% for post in site.categories.technology %}
  <h3>{{ post.title }}</h3>
{% endfor %}
```

### Tag Cloud

```liquid
{% for tag in site.tags %}
  <a href="/tags/{{ tag[0] | slugify }}">
    {{ tag[0] }} ({{ tag[1].size }})
  </a>
{% endfor %}
```

### Pagination Links

```liquid
{% if paginator.previous_page %}
  <a href="{{ paginator.previous_page_path | relative_url }}">Previous</a>
{% endif %}

<span>Page {{ paginator.page }} of {{ paginator.total_pages }}</span>

{% if paginator.next_page %}
  <a href="{{ paginator.next_page_path | relative_url }}">Next</a>
{% endif %}
```

### Table of Contents

```liquid
<nav class="toc">
  <ul>
    {% for post in site.posts %}
      <li>
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      </li>
    {% endfor %}
  </ul>
</nav>
```

### Reading Time

```liquid
{% assign words = content | number_of_words %}
{% assign minutes = words | divided_by: 180 %}
{% if minutes == 0 %}
  Less than 1 minute
{% else %}
  {{ minutes }} minute read
{% endif %}
```

## Jekyll-Specific Filters

### Link (safe internal links)

```liquid
{{ site.baseurl }}{% link _posts/2026-02-10-post.md %}
{{ site.baseurl }}{% link about.md %}
```

### Post URL

```liquid
{{ site.baseurl }}{% post_url 2026-02-10-post-title %}
```

### Highlight Code

```liquid
{% highlight ruby %}
def hello
  puts "Hello, World!"
end
{% endhighlight %}

{% highlight ruby linenos %}
# With line numbers
{% endhighlight %}
```

### Group By

```liquid
{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}
  <h2>{{ year.name }}</h2>
  {% for post in year.items %}
    <p>{{ post.title }}</p>
  {% endfor %}
{% endfor %}
```

### Where and Where Expression

```liquid
{% assign featured = site.posts | where: "featured", true %}
{% assign recent = site.posts | where_exp: "post", "post.date > site.time" %}
```

## Debugging

### Inspect Variables

```liquid
{{ variable | inspect }}     # Shows full object structure
{{ page | jsonify }}         # JSON output
```

### Check Variable Type

```liquid
{% if variable %}
  Variable exists and is truthy
{% endif %}

{% if variable == nil %}
  Variable is nil
{% endif %}

{% if variable == empty %}
  Variable is empty
{% endif %}
```

## Best Practices

1. **Use relative URLs**: Always use `relative_url` or `absolute_url` filters for paths
2. **Check existence**: Use `{% if variable %}` before accessing
3. **Use where filters**: More efficient than looping and checking conditions
4. **Cache complex operations**: Assign to variable if using multiple times
5. **Use includes**: Break complex templates into reusable pieces
6. **Comment your code**: Help future you understand complex logic
7. **Test locally**: Always test Liquid changes with `jekyll serve`

## More Resources

- Official Liquid docs: https://shopify.github.io/liquid/
- Jekyll Liquid docs: https://jekyllrb.com/docs/liquid/
- Jekyll variables: https://jekyllrb.com/docs/variables/
- Jekyll filters: https://jekyllrb.com/docs/liquid/filters/

---

**Tip**: When stuck, use `{{ variable | inspect }}` to see what data you're working with!
