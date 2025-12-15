---
layout: page  
title: "Challenge Solutions"
permalink: /challenges
---

# 🎯 Challenge Solutions

Focused solutions for CTF-style challenges (web, crypto, forensics, reversing).

{% assign challenges = site.categories.Challenges | default: site.posts | where_exp: "post", "post.categories contains 'Challenges'" %}
{% if challenges.size > 0 %}
  <ul>
  {% for post in challenges %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      <span class="post-date">({{ post.date | date: "%b %d, %Y" }})</span>
      <br>
      <small>Tags: {% for tag in post.tags %}<span class="tag">{{ tag }}</span> {% endfor %}</small>
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

.post-list {
  list-style: none;
  padding: 0;
}

.post-list li {
  padding: 15px 0;
  border-bottom: 1px solid #eee;
}

.post-list li:last-child {
  border-bottom: none;
}

.post-date {
  color: var(--gray);
  font-size: 0.9em;
  margin-left: 10px;
}

.post-tags {
  margin-top: 5px;
}

.tag {
  display: inline-block;
  background: var(--light);
  color: var(--primary);
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 0.8em;
  margin-right: 5px;
  margin-top: 5px;
  border: 1px solid #ddd;
}

.categories {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin: 30px 0;
}

.category-card {
  border: 1px solid #e1e4e8;
  border-radius: 8px;
  padding: 20px;
  transition: transform 0.2s, box-shadow 0.2s;
}

.category-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.category-card h3 {
  margin-top: 0;
  color: var(--primary);
}

.category-card .count {
  font-weight: bold;
  color: var(--secondary);
}

.tag-cloud {
  text-align: center;
  margin: 30px 0;
  line-height: 2.5;
}

.tag-cloud a {
  margin: 0 5px;
  text-decoration: none;
  color: var(--primary);
  opacity: 0.8;
}

.tag-cloud a:hover {
  opacity: 1;
  text-decoration: underline;
}

.activity {
  background: var(--light);
  padding: 20px;
  border-radius: 8px;
  margin: 30px 0;
}

.activity ul {
  list-style: none;
  padding: 0;
}

.activity li {
  padding: 5px 0;
  display: flex;
  align-items: center;
}

.activity-date {
  font-family: monospace;
  background: #fff;
  padding: 2px 6px;
  border-radius: 4px;
  margin-right: 10px;
  min-width: 60px;
  text-align: center;
  font-size: 0.9em;
}

.activity-type {
  margin-right: 10px;
  min-width: 30px;
}

h1 {
  color: var(--primary);
  border-bottom: 3px solid var(--secondary);
  padding-bottom: 10px;
}

h2 {
  color: var(--primary);
  margin-top: 40px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

a {
  color: var(--secondary);
  text-decoration: none;
}

a:hover {
  color: var(--accent);
  text-decoration: underline;
}

@media (max-width: 768px) {
  .categories {
    grid-template-columns: 1fr;
  }
  body {
    padding: 15px;
  }
}
</style>