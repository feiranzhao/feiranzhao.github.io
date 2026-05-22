---
title: "Talks"
permalink: /talks/
author_profile: true
---

## Invited Talks

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.talks.invited %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">"{% if item.slides_url %}<a href="{{ item.slides_url }}">{{ item.title }}</a>{% else %}{{ item.title }}{% endif %}," {{ item.venue }}{% if item.location and item.location != "" %}, {{ item.location }}{% endif %}{% if item.note %}. {{ item.note }}{% endif %}</span></p>
{% endfor %}
</div>

## Conference Presentations

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.talks.conference %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">"{% if item.slides_url %}<a href="{{ item.slides_url }}">{{ item.title }}</a>{% else %}{{ item.title }}{% endif %}," {{ item.venue }}{% if item.location and item.location != "" %}, {{ item.location }}{% endif %}{% if item.note %}. {{ item.note }}{% endif %}</span></p>
{% endfor %}
</div>
