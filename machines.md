---
layout: page
title: "Machine Write-ups"
permalink: /machines
---

# Machine Write-ups

Full penetration testing walkthroughs of Hack The Box machines.

{% assign machines = site.categories.Machines | default: site.posts | where_exp: "post", "post.categories contains 'Machines'" %}
{% if machines.size > 0 %}
  <ul>
  {% for post in machines %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a> 
      <span class="post-date">({{ post.date | date: "%b %d, %Y" }})</span>
      <br>
      <small>Tags: {% for tag in post.tags %}<span class="tag">{{ tag }}</span> {% endfor %}</small>
    </li>
  {% endfor %}
  </ul>
{% else %}
  <p>No machine write-ups yet. Check back soon!</p>
{% endif %}