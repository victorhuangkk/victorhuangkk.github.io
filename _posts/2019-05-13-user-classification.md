---
layout: post
title: User Classification
subtitle: Data driven user clustering
tags: [machine learning, marketing]
comments: true
---

## Motivation
To make product decisions, product managers need to understand user's behavior in their different tenure stages. For example, product team may have interest to know how many users would place 0 orders in the next week and how many frequent users will degrade to 'dead' users in the next few weeks. Based on the exploratory data analysis and forecasting, both the product team and marketing team could adjust strategies accordingly. For example, sending the potential infrequent users emails or in-app notifications to prompt more purchases.

## Data Collection
There are multiple types of data may determine users' behavior.

1. Demographic features: for instance, I assume high income, younger users may order more than middle income, middle age users.

2. Tenure: for instance, I assume recent acquired users use the app more than older cohort.

3. Previous order pattern: for instance, I assume a user ordered 5-5-5-5-5 lunched in the previous 5 weeks tend to order more than users who ordered 0-0-1-1-1 in the past 5 weeks.

4. Other Features: for instance, I assume organic channel acquired users may order more frequent than advertisement channel acquired users.

To retrieve data, I composed corresponding SQL queries to fetch data from the database. For privacy issue, I cannot disclose detailed sample data here but all of them falls into the four categories above.


## Exploratory Data Analysis
In order to filter powerful predictors among all features, I used both linear regression and random forest to measure feature importance.

## Methodology
The end goal is to accurately group users together.

## Delivery

After k-means aggregation being done, results were saved in a bigquery view and Looker view is built up accordingly. Data as user's order history and demographic features. The product team used this work to create multiple visualizations and it provides product insights regarding product changes.

## Future Work

* Test other clustering algorithm 
