---
layout: post
title: Looker A/B test
tags: [product, experiment]
---

Currently, most Internet based companies are conducting A/B tests. For example, Uber loves to use A/B test to roll out new features, Facebook uses the in-house A/B test system to check the success of marketing campaign. At Ritual, we are conducting statistical test backed A/B test analysis to rollout products and improve our marketing strategies.

Based on our use cases, variables might be grouped into three categories, following binomial distribution, poisson distribution and gaussian distribution.

One common mistake that people may make is to use aggregated mean to roll out features. It is not appropriate since variables follow drastically different distributions may share the same mean. And it is dangerous to conclude experiment based on a single parameter without any statistical tests. To make our life easier, T test might be the goto tool.

## Frequentist Approach

Regarding variables, the test are designed by normal distribution approximation. That is to say, instead of checking distribution itself, it is easier to look at parameters we are interested in.

The current solution is, end users designate the baseline parameters and the framework would enable them to pivot by group of interests.


## Bayesian Approach

Compared with frequentist approach, Bayesian statistics provided a more understandable approach to A/B tests analysis. In this approach, I used a little code block from Looker but it turns out this approach is relatively difficult.

<img src="https://render.githubusercontent.com/render/math?math=z=\frac{\hat p_1-\hat p_2}{\sqrt{\hat p(1-\hat p)\left(\frac{1}{n_1}+\frac{1}{n_2}\right)}}">



## Looker Implementation
To rollout the system faster, BI tools, like Looker might be a better choice compared with programming approaches. I was inspired by multiple blog from Looker. Links are shared in the end.

In general, to make the product as flexible as possible, liquid variables were used in this case. I decoupled step for explanation purposes.

#### Step I

To conduct frequentist parametric statistical analysis related to mean, four parameters are needed:

- Sample Size: number of data points allocated to this bucket
- Success Size: number of activated user, the number of orders people placed, etc.
- Sample Mean: (Success Size) / (Sample Size)
- Sample Standard Deviation:
  - Binomial Distribution: p(1-p)
  - Other than Binomial Distribution: Calculated by Google BigQuery's

Then all parameters are stored in Looker available for

#### Step II

Different from post on Looker's official site, product team at Ritual prefer to look at comparison between buckets each time, not once a time. So, the main challenge became how to enable business users look at pairwise comparisons all at once. To do this, In this step, the view calculated corresponding metrics for everything.

And in order to calculate exact p-value for different sample size, BigQuery UDF was implemented. T-Score would be calculated in Looker by built-in function. Then, a javascript function would be applied to calculate the real p-value.

~~~
CREATE OR REPLACE FUNCTION `tscore`(a FLOAT64,
                                    b FLOAT64,
                                    c FLOAT64,
                                    d FLOAT64)
                                    RETURNS FLOAT64 LANGUAGE js
OPTIONS (library=["gs://repo/jstat.min.js"]) AS
"""
var value = a;
var mean = b;
var sd = c;
var n = d;
return jStat.tscore( value, mean, sd, n );
""";
~~~

#### Step III

Ask user to input calculated mean




#### Code
