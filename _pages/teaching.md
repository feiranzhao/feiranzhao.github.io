---
title: "Teaching"
permalink: /teaching/
author_profile: true
---

This page uses plain text entries instead of clickable archive cards.

## Teaching Experience

<div class="plain-list">
{% for item in site.data.cv.teaching.teaching_experience %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.role }}</strong><br>{{ item.course }}, {{ item.institution }}<br>{{ item.details }}</p>
{% endfor %}
</div>

## Supervision

<div class="plain-list">
{% for item in site.data.cv.teaching.supervision %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.student }}</strong><br>{{ item.program }}<br>"{{ item.title }}"<br>{{ item.details }}</p>
{% endfor %}
</div>
