---
title: "Miscs"
permalink: /miscs/
author_profile: true
---

## Honors and Awards

{% for item in site.data.cv.awards %}
- {{ item.year }}: **{{ item.title }}**, {{ item.organization }}{% if item.note %} ({{ item.note }}){% endif %}.
{% endfor %}
