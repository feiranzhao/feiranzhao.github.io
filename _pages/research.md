---
title: "Research"
permalink: /research/
author_profile: true
---

{{ site.data.research.vision }}

<div class="research-theme-list">
{% for theme in site.data.research.themes %}
  <section class="research-theme">
    <div class="research-theme__text">
      <h2><a href="{{ theme.url }}">{{ theme.title }}</a></h2>
      <p>{{ theme.description }}</p>
    </div>
    <a class="research-theme__image" href="{{ theme.url }}">
      <img src="{{ theme.image }}" alt="{{ theme.title }}">
    </a>
  </section>
{% endfor %}
</div>
