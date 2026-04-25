---
title: "Talks"
permalink: /talks/
author_profile: true
---

These talks are listed as plain text without hyperlinks.

## Invited Talks

<div class="plain-list">
{% for item in site.data.cv.talks.invited %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.title }}</strong><br>{{ item.venue }}{% if item.location %}, {{ item.location }}{% endif %}{% if item.note %}<br>{{ item.note }}{% endif %}</p>
{% endfor %}
</div>

## Conference Presentations

<div class="plain-list">
{% for item in site.data.cv.talks.conference %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.title }}</strong><br>{{ item.venue }}{% if item.location %}, {{ item.location }}{% endif %}{% if item.note %}<br>{{ item.note }}{% endif %}</p>
{% endfor %}
</div>
