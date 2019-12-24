---
layout: post
title: Product Sense
subtitle: Some product thoughts by a data scientist
tags: [product, data]
comments: true
---

Product managers are in the center of an Internet based company. However, it is relatively difficult to judge a product person's ability. In my daily job, I worked with multiple product managers extensively. Helping them pull data from various data sources, conducting statistical analysis and make product related decisions. So, based on my understanding, product is really the center of a company. Someone may believe data is the new trend since traditional product development is subjective. However, I would argue that data may be misleading some time. I would like to decouple the product life cycle in multiple stages and how data get involved in different steps.


## Opportunity Discovery

Designing a product is very tricky and takes energy. For example, how to increase user retention on the platform requires  


## Data Analysis Workflow

To be a reliable data analyst, I would dissect the project as the following steps:

1. Demystify business question. To achieve this goal, data analysts have to work together with product managers or other business users to specify the exact question you want to answer. It's both sides task to fully understand each other.

2. Exploratory Data Analysis. Talk is cheap but show me the code. After knowing the question, it is better for the analyst to conduct some simple analysis and give out initial stage results. Then, both sides need sit together to discuss the progress. And if there are multiple potential explanations, please choose one which makes the best sense

3. More work and Report. Data analysis is more than a messy Jupyter Notebook with unreproducible codes and plots. I would define a qualified analyst as a modern age consultant. You have to write code, but you have to tell vivid story as well.

4. Conclusion and Documentation. After the analysis been done, the answered business question, methodologies and visualizations need to be organized in easy-to-read manner and version controlled.  

I am going deeper in each direction.


### Demystify business question

This step is crucial but get ignored by a handful amount of junior analysts. I made this mistakes a lot of times as well. I viewed the job of data analysts as data wrangler or SQL composer. The truth is that data makes no sense without business applications. You need to push the business users to understand the real question beneath a simple ask. For example, a product manager may ask you pull a list users for him without telling you ask business contexts. You may still accomplish this task without asking a single question. He may use the list to conduct an experiment which means multiple criteria need modification. However, you hard coded a bunch of parameters for simplicity. The result is that you doubled or tripled the initial workload compared with the original ask.


### Exploratory Data Analysis

In most cases, one question might be answered by multiple ways. For example, you may group users by acquisition time, region or acquisition channel for one experiment. 
