---
title: "Publications"
permalink: /publications/
author_profile: true
classes: no-page-title
---

## Preprints

<ol class="publication-list">
{% for item in site.data.cv.publications.preprints %}
  <li>{% include publication-entry.html item=item %}</li>
{% endfor %}
</ol>

## Journal Articles

<ol class="publication-list">
{% for item in site.data.cv.publications.journal %}
  <li>{% include publication-entry.html item=item %}</li>
{% endfor %}
</ol>

## Conference Proceedings

<ol class="publication-list">
{% for item in site.data.cv.publications.conference %}
  <li>{% include publication-entry.html item=item %}</li>
{% endfor %}
</ol>
