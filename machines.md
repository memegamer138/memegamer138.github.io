layout: page
title: "Machine Write-ups"
permalink: /machines

# Machine Write-ups

Full penetration testing walkthroughs of Hack The Box machines.

{% assign machines = site.categories.Machines | default: site.posts | where_exp: "post", "post.categories contains 'Machines'" %}
{% if machines.size > 0 %}
  <ul class="post-list">
  {% for post in machines %}
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
  <p>No machine write-ups yet. Check back soon!</p>
{% endif %}
