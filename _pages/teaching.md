---
title: "Teaching"
permalink: /teaching/
layout: archive
author_profile: true
---

{% assign teaching = site.teaching | sort: "date" | reverse %}
{% for post in teaching %}
  {% include archive-single.html %}
{% endfor %}

