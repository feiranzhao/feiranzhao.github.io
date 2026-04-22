---
title: "Publications"
permalink: /publications/
layout: archive
author_profile: true
---

Below is a selected list of publications currently imported from my BibTeX file.

{% assign pubs = site.publications | sort: "date" | reverse %}
{% for post in pubs %}
  {% include archive-single.html %}
{% endfor %}
