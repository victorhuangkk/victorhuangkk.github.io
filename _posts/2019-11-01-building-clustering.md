---
layout: post
title: Business Units Clustering
tags: [expansion, machine learning]
comments: true
---
## Summary
For expansion purposes, we need to formulate business park and consolidate information about business park. The original data is purchased from a third party data provider. And the business team used a generic sql approach to cluster all buildings. However, due to the large amount of data and SQL's logic, it is difficult to conduct all calculations in pure SQL.

In the very end, business team need all data to be accessible with BI tool and SQL. So, the best solution would be to create temporary


## Methodology

In short, the business question is to cluster buildings together by distance. In that case, DBCSAN (Density-based spatial clustering of applications with noise). It is a density-based clustering non-parametric algorithm: given a set of points in some space, it groups together points that are closely packed together (points with many nearby neighbors), marking as outliers points that lie alone in low-density regions. And in this case,

## Coding

Since we used a fully developed Python package, the time consuming part is parameter tuning and pipeline setup. In general, we need to deliver a ready-to-use system for business users.
