---
title: "About"
permalink: /
author_profile: true
---

{% assign profile = site.data.cv.profile %}

I am **{{ profile.name }}**, a **{{ profile.title | downcase }}** at **{{ profile.affiliation }}**.
My research focuses on data-driven control, adaptive control, reinforcement learning, and their applications to dynamical systems.

## Current Position

- {{ profile.current_position.period }}: **{{ profile.current_position.role }}**, {{ profile.current_position.institution }}, {{ profile.current_position.location }}. Advisor: {{ profile.current_position.advisor }}.

## Research Interests

{% for item in profile.interests %}
- {{ item }}
{% endfor %}

## Education

{% for item in site.data.cv.education %}
- {{ item.period }}: **{{ item.degree }}**, {{ item.institution }}, {{ item.location }}{% if item.advisor %}. Advisor: {{ item.advisor }}{% endif %}.
{% endfor %}

## Selected Highlights

- Outstanding Ph.D. Dissertation Award, Chinese Association of Automation, 2025.
- Outstanding Doctoral Student Award, Beijing Association of Automation, 2023.
- Organizer of the 2025 NCCR Workshop on Interconnection of Autonomous Systems.
- Reviewer for TAC, Automatica, TCST, TCNS, L-CSS, ACC, CDC, IFAC, and ECC.

## Contact

- Email: {{ profile.email }}
- Website: {{ profile.website }}
- Google Scholar: <https://scholar.google.com/citations?user=xUI18FkAAAAJ&hl=zh-CN>
- ORCID: <https://orcid.org/my-orcid?orcid=0000-0003-3142-2903>
- GitHub: <https://github.com/Feiran-Zhao-eth>
