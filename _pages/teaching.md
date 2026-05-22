---
title: "Teaching"
permalink: /teaching/
author_profile: true
---

## Teaching Experience

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.teaching.teaching_experience %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body"><strong>{{ item.role }}</strong>, {% if item.url %}<a href="{{ item.url }}">{{ item.course }}</a>{% else %}{{ item.course }}{% endif %}, {{ item.institution }}{% if item.details %}. {{ item.details }}{% endif %}</span></p>
{% endfor %}
</div>

## Supervision

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.teaching.supervision %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body"><strong>{{ item.student }}</strong>, {{ item.program }}. "{{ item.title }}"{% if item.details %}. {{ item.details }}{% endif %}</span></p>
{% endfor %}
</div>
