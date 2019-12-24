---
layout: post
title: User Marketing Recommendation System
tags: [marketing, statistics, optimization]
comments: true
---

# Motivation
In order to provide personalized recommendations to increase click-through-rate and potentially increase final purchase rate at Ritual, the data science team decided to develop a recommendation v1 for the marketing team.

# Association Rule

Depending on researches online, association rule is one of the most common data mining strategies and it provided some marketing insights. It is simple and easy to interpret (compared with matrix decomposition). In order to extract enough rules from our data, I used monthly order data instead of all order history. And there are a few ways to create the association:

1. Association between users and merchants. Assuming monthly purchase is a one bucket and create multiple buckets for one user by considering multiple months.

2. Association between item and user. This approach is more granular and potentially provide more business contexts

Rather than simple association rule, matrix factorization might be a potential solution. However, the difficulty comes with sparsity, which means, one user may consume in handful amount of merchants. Compared with data collected by YouTube or Netflix, whom can leverage the power of neural network, simplified approach might be more appropriate in this case.

For details about association rule, please refer to the Metrics section later. But in short, you should consider support, confidence, lift and leverage at the same time. But for specific business applications, you may choose one to use for optimization purposes.

# MIP Optimization

After association rules being prepared, a convex optimization problem is needed to satisfy business needs. In real cases, one email may not want to recommend overwhelming amount of restaurants to a user. And you may not direct all order volume to only one restaurant. To achieve this, objective function is the summation of utility in the association matrix and all business needs are implemented as constraints.

To simplify the development process, we need a proper framework to set it up. I used a Python package called `cvxpy`, which is an intuitive convex optimization framework. One major advantage is that  `cvxpy` doesn't require constraints to be in matrix format but accept list format as well.

After the mixed integer optimization problem being set-up, we used the commercial solver, Gurobi and CPLEX, to solve the mixed integer problem. And the outputs were used for personalized emails by marketing team.

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
