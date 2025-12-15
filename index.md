---
layout: default
title: "HTB Write-ups & Notes"
---

# Security Write-ups

Welcome to my  blog where I document solutions to Hack The Box machines and challenges, and other security research. This site serves as my public notebook to reinforce learning and share knowledge with the community.

---

## Latest Write-ups

### Latest Machines
{% assign machine_posts = site.categories.Machines | default: site.posts | where_exp: "post", "post.categories contains 'Machines'" %}
{% if machine_posts.size > 0 %}
  <ul class="post-list">
  {% for post in machine_posts limit:5 %}
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
  <p><a href="/machines">View all machines →</a></p>
{% else %}
  <p>No machine write-ups yet. Coming soon!</p>
{% endif %}

### Latest Challenges
{% assign challenge_posts = site.categories.Challenges | default: site.posts | where_exp: "post", "post.categories contains 'Challenges'" %}
{% if challenge_posts.size > 0 %}
  <ul class="post-list">
  {% for post in challenge_posts limit:5 %}
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
  <p><a href="/challenges">View all challenges →</a></p>
{% else %}
  <p>No challenge write-ups yet. Coming soon!</p>
{% endif %}

---

## Browse by Category

<div class="categories">
  <div class="category-card">
    <h3><a href="/machines">Machines</a></h3>
    <p>Full system penetration testing walkthroughs from Hack The Box.</p>
    {% assign machine_count = site.categories.Machines | size %}
    <p class="count">{{ machine_count }} write-ups</p>
  </div>
  
  <div class="category-card">
    <h3><a href="/challenges">Challenges</a></h3>
    <p>Focused solutions for web, crypto, forensics, and other CTF-style challenges.</p>
    {% assign challenge_count = site.categories.Challenges | size %}
    <p class="count">{{ challenge_count }} write-ups</p>
  </div>
  
  <div class="category-card">
    <h3><a href="/tags">Tags</a></h3>
    <p>Browse by specific techniques, tools, or vulnerability types.</p>
    {% assign unique_tags = site.tags | size %}
    <p class="count">{{ unique_tags }} tags</p>
  </div>
</div>

---

## Popular Tags

<div class="tag-cloud">
  {% assign sorted_tags = site.tags | sort %}
  {% for tag in sorted_tags %}
    {% assign tag_size = tag[1] | size %}
    {% assign font_size = tag_size | times: 0.5 | plus: 0.8 %}
    <a href="/tags#{{ tag[0] | slugify }}" style="font-size: {{ font_size }}em;">
      {{ tag[0] }} ({{ tag_size }})
    </a>
  {% endfor %}
</div>

---

## Recent Activity

<div class="activity">
  <h3>Latest Updates</h3>
  <ul>
  {% for post in site.posts limit:8 %}
    <li>
      <span class="activity-date">{{ post.date | date: "%b %d" }}</span>
      <span class="activity-type">
        {% if post.categories contains "Machines" %}{% endif %}
        {% if post.categories contains "Challenges" %}{% endif %}
      </span>
      <a href="{{ post.url | relative_url }}">{{ post.title | truncate: 40 }}</a>
    </li>
  {% endfor %}
  </ul>
</div>

---

## 📬 About This Blog

This blog is built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/). All write-ups are created to document my learning process in cybersecurity. Flags and sensitive information are always redacted to preserve the integrity of the platforms.
