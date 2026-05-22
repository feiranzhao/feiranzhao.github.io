---
title: "Feiran Zhao (赵斐然)"
permalink: /
author_profile: true
---

{% assign profile = site.data.cv.profile %}

Hi there! I am currently a postdoctoral researcher at the Automatic Control Laboratory (IfA), ETH Zurich, Switzerland, under the supervision of **[Prof. Florian Dorfler](https://dorfler.ethz.ch/)**. Before that, I received his Ph.D. degree in Control Science and Engineering from the Department of Automation, Tsinghua University, Beijing, China, in 2024, supervised by **[Prof. Keyou You (游科友)](https://www.au.tsinghua.edu.cn/en/info/1075/3331.htm)**. I was also a visiting scientist at the Automatic Control Laboratory (IfA), ETH Zurich, from December 2022 to May 2023. I received the B.Eng. degree in Automation from Harbin Institute of Technology, Harbin, China, in 2018. His current research focuses on reinforcement learning, data-driven control, adaptive control, and their intersections.

## Research Vision

My research aims to build next-generation intelligent control systems that learn and adapt from real-world interactions while preserving closed-loop stability, safety, robustness, and performance guarantees. My approach is to develop **closed-loop adaptive reinforcement learning** as a principled bridge between reinforcement learning, adaptive control, online optimization, and data-driven control. I fouc on:

- **Theory:** data-enabled policy optimization, policy gradient adaptive control, safe and scalable learning for networked dynamical systems.
- **Applications:** embodied and safety-critical systems, including autonomous robots, power-electronic and energy networks, aerospace systems, and other cyber-physical systems where learning must happen inside feedback loops.

## Latest News

<div class="latest-news" markdown="1">
{% for item in site.data.cv.news limit:12 %}
- {{ item.date }}: {% if item.url and item.link_text %}{% capture news_link %}<a href="{{ item.url }}">{{ item.link_text }}</a>{% endcapture %}{{ item.item | replace_first: item.link_text, news_link }}{% elsif item.url %}<a href="{{ item.url }}">{{ item.item }}</a>{% else %}{{ item.item }}{% endif %}
{% endfor %}
</div>
