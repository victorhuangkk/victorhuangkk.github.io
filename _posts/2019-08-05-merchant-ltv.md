---
layout: post
title: Merchant Lifetime Value Analysis
tags: [marketing, statistics]
---

# Customer Lifetime Value

As a two-side marketplace provider, merchants lifetime value is crucial to Ritual's success. Traditionally, customer lifetime value is calculated by the formula below:

<img src="https://render.githubusercontent.com/render/math?math=2asin(\sqrt{p1})-2asin(\sqrt{p2})">


# Objective:

In order to scientifically bid on merchant related ads, we need to estimate lifetime value for merchant by 1, 2 and 3 years as well as by metro and zone types. Data was fetched from the Look we set up. And a sample plot is shown here. Merchants are grouped by their activation months on Ritual. Y-axis is the aggregated ritual fee we collected.


# Methodologies:

In order to calculate merchant lifetime value, we need to consider the following two factors:


1. How much money on average does a merchant generate month by month?
2. What’s the possibility a merchant churn in that month?

Obviously, these questions are difficult to answer without cohort (by acquisition time or by acquisition location) since cohort provided a stable number of merchants. And this approach provides us the insight about flexible churn rate since churn rate is calculated term by term.



Regarding the two terms,

*   Average ritual fee is calculated term by term by total ritual fee collected divided by active number of merchants in that month.
*   Churn rate is calculated term by term by this formula.


After multiplying the two terms and doing a rolling sum, we know the 6/12/24 months lifetime value. To elaborate this idea, I created some toy data below.

**Example**: Suppose we acquired 100 merchants in Toronto at the 1st month of 2018. These 100 merchants are called as a cohort. The following tables illustrate how the cohort based LTV is calculated.


<table>
  <tr>
   <td>Week
   </td>
   <td>Number of Merchants
   </td>
   <td>Churn Rate
   </td>
   <td>Ritual Fee in This Period
   </td>
   <td>Ritual Fee Per Merchant
   </td>
   <td>Churn Adjusted Ritual Fee per Merchant
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td>100
   </td>
   <td>N/A
   </td>
   <td>$10,000
   </td>
   <td>$100
   </td>
   <td>$100
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>100
   </td>
   <td>0%
   </td>
   <td>$10,000
   </td>
   <td>$100
   </td>
   <td>$100
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>98
   </td>
   <td>2%
   </td>
   <td>$10,000
   </td>
   <td>$102
   </td>
   <td>=102*(1-0.02) = $100
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>95
   </td>
   <td>3.1%
   </td>
   <td>$10,000
   </td>
   <td>$105
   </td>
   <td>$105*(1-0.031)=102
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>90
   </td>
   <td>5.3%
   </td>
   <td>$10,000
   </td>
   <td>$111
   </td>
   <td>$105
   </td>
  </tr>
  <tr>
   <td>...
   </td>
   <td>...
   </td>
   <td>...
   </td>
   <td>...
   </td>
   <td>...
   </td>
   <td>...
   </td>
  </tr>
  <tr>
   <td>12
   </td>
   <td>60
   </td>
   <td>5% (assume)
   </td>
   <td>$10,000
   </td>
   <td>$167
   </td>
   <td>$159
   </td>
  </tr>
  <tr>
   <td>Total
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>100+100+100+102+105+.....+159
   </td>
  </tr>
</table>


Based on this table, we know this cohort has 60 merchants “survived” after 12 months with the average 1 year(12 months) LTV of $ 1,000 (supposed). And the table below shows how to calculate merchant average LTV in each metro. The data below means we have 10 active merchants in cohort 1 at their 12 months, 20 active merchants in their 20 months, etc. The metro one-year ltv is weighted by the number of active merchants in that month for each cohort.


<table>
  <tr>
   <td>Cohort
   </td>
   <td>Number of Merchants
   </td>
   <td>Average 1 Year LTV
   </td>
   <td>Weighted LTV
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td>10
   </td>
   <td>$1,000
   </td>
   <td>0.1*$1,000
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>20
   </td>
   <td>$1,100
   </td>
   <td>0.2*$1,100
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>30
   </td>
   <td>$1,200
   </td>
   <td>0.3*$1,200
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>40
   </td>
   <td>$1,300
   </td>
   <td>0.4*$1,300
   </td>
  </tr>
  <tr>
   <td>Result
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>$1,200
   </td>
  </tr>
</table>


In this example, the average LTV for Toronto area is $1200. All the other cities follow the same rubric to get the numbers.
