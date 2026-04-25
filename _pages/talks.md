---
title: "Talks"
permalink: /talks/
author_profile: false
classes: wide
---

## Invited Talks

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.talks.invited %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">"{{ item.title }}," {{ item.venue }}{% if item.location %}, {{ item.location }}{% endif %}{% if item.note %}. {{ item.note }}{% endif %}</span></p>
{% endfor %}
</div>

## Conference Presentations

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.talks.conference %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">"{{ item.title }}," {{ item.venue }}{% if item.location %}, {{ item.location }}{% endif %}{% if item.note %}. {{ item.note }}{% endif %}</span></p>
{% endfor %}
</div>
