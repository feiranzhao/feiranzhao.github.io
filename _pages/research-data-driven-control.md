---
title: "Data-Driven Control and Online Optimization"
permalink: /research/data-driven-control/
author_profile: true
---

{% assign theme = site.data.research.themes | where: "id", "data-driven-control" | first %}

{{ theme.description }}

## Publications

{% include research-publications.html publications=theme.publications %}
