---
title: "Publications"
permalink: /publications/
author_profile: false
classes: wide
---

## Journal Articles

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.journal %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">{{ item.authors }}. "{{ item.title }}." {{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</span></p>
{% endfor %}
</div>

## Conference Proceedings

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.conference %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">{{ item.authors }}. "{{ item.title }}." {{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</span></p>
{% endfor %}
</div>

## Preprints

<div class="plain-list plain-list--compact">
{% for item in site.data.cv.publications.preprints %}
  <p><span class="plain-list__year">{{ item.year }}</span><span class="plain-list__body">{{ item.authors }}. "{{ item.title }}." {{ item.venue }}{% if item.details %}, {{ item.details }}{% endif %}</span></p>
{% endfor %}
</div>
