---
title: "Closed-Loop Adaptive Reinforcement Learning"
permalink: /research/adaptive-rl/
author_profile: true
---

{% assign theme = site.data.research.themes | where: "id", "adaptive-rl" | first %}

{{ theme.description }}

## Publications

{% include research-publications.html publications=theme.publications %}
