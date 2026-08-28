---
layout: page
title: "OverTheWire Write-ups"
permalink: /overthewire
---

# OverTheWire Write-ups

Level-by-level notes and solutions for OverTheWire wargames.

{% assign wargame_posts = site.categories.OverTheWire %}
{% if wargame_posts.size > 0 %}
  <ul class="post-list">
  {% for post in wargame_posts %}
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
  <p>No OverTheWire write-ups yet.</p>
{% endif %}