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