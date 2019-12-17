---
layout: post
title: Business Units Clustering
tags: [expansion, machine learning]
comments: true
---
# Summary
For expansion purposes, we need to formulate business park and consolidate information about business park. The original data is purchased from a third party data provider. 

There limitations for previous approach are
The generation of business park is not stable. Which means, the business park’s numbering and number of buildings in one business park may be different every time.

Some BPXs show up directly beside each other, when really they should count as 1. Is there something causing this issue (since it should capture everything in 500M)?

A good number of them are not outputting a lat/long which makes them impossible to identify (575 out of 2748)

Based on the main business needs from expansion team, we dissected the problem into two parts. First part is about business park generation and the second part is about merchant assignment.
