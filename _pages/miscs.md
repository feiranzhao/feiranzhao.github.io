---
title: "Miscs"
permalink: /miscs/
author_profile: true
---

## Honors and Awards

{% for item in site.data.cv.awards %}
- {{ item.year }}: **{{ item.title }}**, {{ item.organization }}{% if item.note %} ({{ item.note }}){% endif %}.
{% endfor %}

## Personal Interests

Outside research, I enjoy outdoor sports, including rock climbing, via ferrata, skiing, and hiking. I also play badminton and see it as a lifelong sport. I enjoy playing guitar as well, especially fingerstyle guitar.
