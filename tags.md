layout: page
title: "Browse by Tag"
permalink: /tags

#  All Tags

Browse write-ups by specific techniques, tools, or topics.

{% assign sorted_tags = site.tags | sort %}
{% for tag in sorted_tags %}
  <h2 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h2>
  <ul class="post-list">
  {% for post in tag[1] %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span class="post-date">{{ post.date | date: "%b %d, %Y" }}</span>
      {% if post.tags %}
      <div class="post-tags">
        {% for t in post.tags %}
          <span class="tag">{{ t }}</span>
        {% endfor %}
      </div>
      {% endif %}
    </li>
  {% endfor %}
  </ul>
{% endfor %}