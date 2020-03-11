---
layout: post
title: Product and Strategy Analysis
tags: [product, data analysis]
comments: true
---

## Summary

Most operational data scientists' daily job involved tons of data analysis techniques. This blog is about to summarize some of my technical tips regarding data analysis. Long story short, data analysis is more than visualization but need statistical inference. And our 'notorious' Statistics Education makes stats 101 too far away from daily data analysis. I would use a few case studies to elaborate my findings and hopefully it is helpful.

## Approach

The main difficulty comes from a few ways:

- The underlying distribution is unknown and there is no simple mathematical way to fit a curve
- People are not super familiar with statistical hypothesis, each method has its own assumptions and you may not violate it
- Instead of time consuming statistical tests, visualizations provide simply solutions to meet deadline

And the following scenarios may require detailed study

#### Case 1

Marketing team needs to send out campaign emails on a weekly basis. Users need to meet certain criteria, like their tenure on the platform, their registered location and their loyalty to the platform

#### Case 2

Product team find a KPI drop and need you to figure out what's the underlying reason. There might be multiple factors and need detailed study

#### Case 3

Operations team requests analysts to look at certain merchants to set up predictive churn models.

As you may see, even as a data analyst, you may work with multiple teams simultaneously to provide data driven decisions. However, there is no clear answer to each of the question and you may give out totally different suggestions in the very end by different approaches. I will elaborate my approach to each of the three problems in the next section.

## Methodology

There are multiple methods to look at the same data. There are mainly two streams. One group of people may think raw data is the key.
We may use multiple visualizations to extract totally different conclusions. For that reason, I would recommend analyze the data via multiple methods.

#### Case 1

This problem might be solved easily by hard code parameters in SQL query and fetch data from database. However, rigorously, this is a convex optimization problem. You have multiple constrains and an objective function. My suggestion is to maximize cardinality of the number of users, subject to certain business requirements. This mathematical optimization problem could be solved in by various solvers in various languages. And the data preparation could be done in SQL. However, you may need one whole day to solve this problem compared with 2 hour query composition.

My suggestion is, you may automate this process by providing a shiny/dash tool to collect business inputs -> fetch data -> optimization -> requested output

#### Case 2

This is a typical data analysis question but most likely analysts may end up with visualization. But my suggestion is to start from causal inference. Most likely there is no single factor driving the effect in which case you need model to estimate effect from each feature. For that reason, I would suggest generalized linear model for its interpretability. Even by applying linear model, you may still not be able to track 

#### Case 3

## Presentation

After the analysis has been done, analyst is usually asked to present to business users. They may not necessary has any statistics and data background.
