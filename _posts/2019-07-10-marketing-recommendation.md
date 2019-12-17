---
layout: post
title: User Marketing Recommendation System
tags: [marketing, statistics, optimization]
comments: true
---

# Motivation
In order to move all the key metrics up,


# Association Rule


# Convex Optimization



# Metrics
### support:
support(A → B) = support(A → B), 	range: [0,1]
The support metric is defined for merchant sets, not the association rules. Typically, support is used to measure the frequency (significance or importance) of a merchant set in a database. A merchant set is a “frequent merchant set” if its support is larger than a specified minimum-support threshold. For example, if this threshold is set to 0.5 (50%), then a frequent merchant set is defined as a set of merchants that occur together in at least 50% of all users in the data set.         
### confidence:           
confidence(A → B) = support(A → B)support(A), 	range: [0,1]
The confidence of a rule A→B is the probability of seeing merchant B in a user’s order history given that it also contains merchant A. Note that the confidence for A→B is different than the confidence for B→A.
### lift:
lift(A → B) = confidence(A → B)support(B), 	range: [0,∞]
The lift metric is used to measure how much more often merchant A and merchant B of a rule A→B occur together than we would expect if they were statistically independent.
### leverage:
leverage(A → B) = support(A → B) - support(A) $\times$ support(B), 	range: [-1,1]
Leverage computes the difference between the observed frequency of merchant A and merchant B appearing together and the frequency that would be expected if merchant  A and merchant B were independent. A value of 0 indicates independence.
conviction:
conviction(A → B) = 1 - support(B)1 - confidence(A → B), 	range: [0,∞]
A high conviction value means that the consequent is highly depending on the antecedent. For instance, in the case of a perfect confidence score, the denominator becomes 0 for which the conviction score is ∞. Similar to lift, if merchants are independent, the conviction is 1.
