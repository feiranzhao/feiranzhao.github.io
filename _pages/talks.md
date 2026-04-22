---
title: "Talks"
permalink: /talks/
layout: archive
author_profile: true
---

{% assign talks = site.talks | sort: "date" | reverse %}
{% for post in talks %}
  {% include archive-single.html %}
{% endfor %}

