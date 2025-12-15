layout: page  
title: "Challenge Solutions"
permalink: /challenges

# 🎯 Challenge Solutions

Focused solutions for CTF-style challenges (web, crypto, forensics, reversing).

{% assign challenges = site.categories.Challenges | default: site.posts | where_exp: "post", "post.categories contains 'Challenges'" %}
{% if challenges.size > 0 %}
  <ul class="post-list">
  {% for post in challenges %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span class="post-date">{{ post.date | date: "%b %d, %Y" }}</span>
      <div class="post-tags">
        {% for tag in post.tags %}
          <span class="tag">{{ tag }}</span>
        {% endfor %}
      </div>
    </li>
  {% endfor %}
  </ul>
{% else %}
  <p>No challenge write-ups yet. Coming soon!</p>
{% endif %}

<style>
:root {
  --primary: #2c3e50;
  --secondary: #3498db;
  --accent: #e74c3c;
  --light: #f8f9fa;
  --dark: #1a1a1a;
  --gray: #6c757d;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  line-height: 1.6;
  color: var(--dark);
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
}

.post-list { list-style: none; padding: 0; }
.post-list li { padding: 15px 0; border-bottom: 1px solid #eee; }
.post-list li:last-child { border-bottom: none; }

.post-date { color: var(--gray); font-size: 0.9em; margin-left: 10px; }
.post-tags { margin-top: 5px; }
.tag { display: inline-block; background: var(--light); color: var(--primary); padding: 2px 8px; border-radius: 12px; font-size: 0.8em; margin-right: 5px; margin-top: 5px; border: 1px solid #ddd; }

h1 { color: var(--primary); border-bottom: 3px solid var(--secondary); padding-bottom: 10px; }
h2 { color: var(--primary); margin-top: 40px; padding-bottom: 10px; border-bottom: 1px solid #eee; }

a { color: var(--secondary); text-decoration: none; }
a:hover { color: var(--accent); text-decoration: underline; }

@media (max-width: 768px) {
  body { padding: 15px; }
}
</style>

