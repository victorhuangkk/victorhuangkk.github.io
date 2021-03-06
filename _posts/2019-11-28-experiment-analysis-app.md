---
layout: post
title: Ritual Experimental Framework MVP
tags: [product, experiment]
comments: true
---


## Summary
To simplify data science work and level up statistical rigor, I developed this experimentation analysis web application at Ritual. To simplify frontend development process, I leveraged the open source Python dashboard called dash. And the structure is:

```
+-- requirements.txt
+-- src
+-- data
+-- notebook
+-- includes
+-- qa_query
+-- test
+-- main.py
```

Here is a screen shot of the app frontend set up.

![image info](/img/app_screen_shot.png)

All those two plots will be explained in detail later in the blog.

## Philosophy

When performing A/B testing, we need to consider the effect of a treatment as a distribution and not just a single statistic of simple p-value.
Various graphs about underlying metrics' distribution have been displayed in the user interface.

In order to roll out this product, simplicity (Occam's razor) is the rule of thumb
in this approach.

- data transferring between different callbacks: data aggregation and raw data
processing is very expensive computationally. There are at least three potential solutions, `flask cache`, `redis` and `feather`. Finally, I chose `feather` since its ease of use and suitable for data frame structure

- bootstrap vs bayesian analysis: Our users do not come from a fixed parametric distribution with some unknown parameter. Instead they each have their own distribution and own parameters.

  * Although a Bayesian methodology is plausible, it has high computational cost, interpretability issues and needs setup for each metric.
  * The Bootstrap allows generating a distribution using the observed data and re-sampling methodology - this is realistic modeling of the uncertainty in the data and any statistic we are interested in.

## Data Processing

Ibis was chosen to be the backend data processing tools, compared with sqlalchemy (another python -> SQL translator), ibis seems to be more flexible and extensible in multiple ways.

- It is pandas generic. Which means, almost every sql manipulation has the corresponding functions/APIs in ibis.

- It is relatively faster to write after ramping up the syntax compared with
sqlalchemy.

- Support Python UDF (bigquery supports JavaScript only).

In general, ibis translates data aggregation logic to bigquery queries. After data wrangling, a data frame will be returned to the system waiting for further processing. However, in order to provide better vision for product team, like metrics' confidence over time, we need a better storage method  compared with Cache everything.

## Callback

- Multiple dash callbacks were applied here to update based on users' inputs. In order to save computational resources, a Python package called feather was applied instead of Cache/Redis for data frame storage simplicity.

- Callback's refresh will be conducted when a flag is raised in the session. The
design is used to enhance user experience and save computational resources.

- Clicks were implemented by `pickle` and global `n_clicks`. In general, corresponding files are setup to collect `n_clicks` and stores it in the pickle files.

### Generic Structure

For simplicity, this process pass the same format to the next step. The format is looking like this:

|     | user_id | partition_id | week_number | metric |
| --- | ------- | ------------ | ----------- | ------ |
| 1   | tom     | 1            | 1           | 2.7    |
| 2   | victor  | 2            | 1           | 1.2    |
| 3   | ben     | 2            | 1           | 3.5    |

In the previous section, Ibis's detailed aggregation tricks were explained.

To better understand different metric, a distribution summary is provided

|     | metric name | distribution |
| --- | ----------- | ------------ |
| 1   | metric1     | Poisson      |
| 2   | Retention   | Binomial     |
| 3   | metric2     | Binomial     |
| 4   | metric3     | Poisson      |
| 5   | Activation  | Binomial     |


## Concurrent Computation

To accommodate multiple users of the same, concurrency has being considered at the beginning. From dash's perspective,  

## Statistical Analysis


### Bootstrap

To infer the percentage change between experimental group and
control group, bootstrap method was applied here. To increase computational efficiency, I used facebook's Python bootstrap library. The advantages are:

- The package is well developed and wrapped in clean APIs.
- Captured more information from collected data compared with simple statistics.


### Point Estimate

To calculate p value by bootstrap, users will be asked for metrics' value they want to consider. And the underlying null hypothesis becomes two groups difference is not greater than the designated value. And theoretically, the output p-value is the exact p-value.

## Business And Statistical Analysis

There are multiple ways of statistical data analysis,


### Descriptive Statistics

To provide statistical insights, sample size, mean, standard deviation,
kurtosis and skewness are provided in a table.

## Plots
- Metric distribution: to display variables' confidence interval by bootstrap.
To simplify users' work and standardize analysis, $\alpha = 0.95$ are hard
coded in the current system. You may interpret this as:
  - thinner the distribution, less variance is embedded
  - longer the distance between two groups, larger the difference
  - less overlap, more confident the two groups are different

- Violin Plot: raw distribution for all metrics. It explains a huge amount of details,
like what's underlying sample distribution looks like. I believe most of the cases,
even without detailed statistical test, business users/data scientists will be able to
conclude accordingly.

- Box Plot: display metric population in each group.


## Deployment

The dash framework is exported as a flask app and a corresponding Docker image has been built for this app. Then, all internal users have access to the app by IP address checking


## Future Plans

There are a few ongoing improvements related to this MVP.

- Adding more metrics
- Set up corresponding tables in database. Schedule CRON job to write to db on a half day basis. Otherwise the computation for this app will be slow in general.
