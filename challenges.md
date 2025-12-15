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