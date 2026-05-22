---
title: "Learning Control for Cyber-Physical Systems"
permalink: /research/cyber-physical/
author_profile: true
---

{% assign theme = site.data.research.themes | where: "id", "cyber-physical" | first %}

{{ theme.description }}

## Publications

{% include research-publications.html publications=theme.publications %}
