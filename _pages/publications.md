---
title: "Publications"
permalink: /publications/
author_profile: false
---

The publications below are shown as plain text rather than linked post entries.

## Journal Articles

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.journal %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.title }}</strong><br>{{ item.authors }}<br>{{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</p>
{% endfor %}
</div>

## Conference Proceedings

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.conference %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.title }}</strong><br>{{ item.authors }}<br>{{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</p>
{% endfor %}
</div>

## Preprints

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.preprints %}
  <p><span class="plain-list__year">{{ item.year }}</span> <strong>{{ item.title }}</strong><br>{{ item.authors }}<br>{{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</p>
{% endfor %}
</div>
