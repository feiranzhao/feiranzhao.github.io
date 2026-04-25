---
title: "CV"
permalink: /cv/
author_profile: true
---

{% assign profile = site.data.cv.profile %}

## Research Appointment

- {{ profile.current_position.period }}: **{{ profile.current_position.role }}**, {{ profile.current_position.institution }}, {{ profile.current_position.location }}. Advisor: {{ profile.current_position.advisor }}.

## Education

{% for item in site.data.cv.education %}
- {{ item.period }}: **{{ item.degree }}**, {{ item.institution }}, {{ item.location }}{% if item.advisor %}. Advisor: {{ item.advisor }}{% endif %}.
{% endfor %}

## Research Interests

- {{ profile.research_summary }}

## Awards

{% for item in site.data.cv.awards %}
- {{ item.year }}: **{{ item.title }}**, {{ item.organization }}{% if item.note %} ({{ item.note }}){% endif %}.
{% endfor %}

## Service

### Organization

{% for item in site.data.cv.service.organization %}
- {{ item.year }}: {{ item.item }}
{% endfor %}

### Reviewing

{% for item in site.data.cv.service.reviewing %}
- {{ item }}
{% endfor %}

## Teaching Experience

{% for item in site.data.cv.teaching.teaching_experience %}
- {{ item.year }}: **{{ item.role }}**, {{ item.course }}, {{ item.institution }}. {{ item.details }}
{% endfor %}

## Supervision

{% for item in site.data.cv.teaching.supervision %}
- {{ item.year }}: **{{ item.student }}**, {{ item.program }}. "{{ item.title }}." {{ item.details }}
{% endfor %}

## Selected Talks and Presentations

### Invited Talks

{% for item in site.data.cv.talks.invited %}
- {{ item.year }}: "{{ item.title }}," {{ item.venue }}, {{ item.location }}{% if item.note %}. {{ item.note }}{% endif %}.
{% endfor %}

### Conference Presentations

{% for item in site.data.cv.talks.conference %}
- {{ item.year }}: "{{ item.title }}," {{ item.venue }}{% if item.location %}, {{ item.location }}{% endif %}{% if item.note %}. {{ item.note }}{% endif %}.
{% endfor %}

## Referees

{% for item in site.data.cv.referees %}
- **{{ item.name }}**, {{ item.affiliation }}, {{ item.email }}
{% endfor %}
