---
layout: "post"
title: A/B/n Test Analysis
tags: [experiment, statistics]
---

## Summary

Most companies are testing on various features to improve our KPIs. As a data scientist, part of the job is to help business people make data backed, statistically sound product decisions. Before anything, I should confess that A/B test is challenging since correlation and causation are difficult to be separated and requires dedicated investigation. Additionally, there is rarely ideal scenario where you run only one experiment once a time such that we may not control all variables we should control.

Another challenge we faces is that we are doing Agile style development. So we cannot wait too long since product decisions must be made within 2 or 3 weeks after experiment started.

Apart from those issues, time is a hidden variable in experiment analysis. For instance, we cannot directly compare two weeks with one is overlapped with major marketing campaign and the other is not. Or it is not easy to estimate holiday’s effect on KPI.

To reduce all of these problems, we need a large sample in the design part (> 10%) in our entire user base and suitable methodologies to analyze data.

## Methodology

The workflow about experiment analysis is still partially automated. Which means, data scientists may need to download data online by writing SQL queries or fetch data from BI tools. In terms of data, it will be elaborated in the next section. But in general, you download raw data (user level) to the local machine. After that, you may apply some statistical test to check your assumptions. Any software or library is not silver bullet, you need choose the most suitable one. There are a few summaries I made:

- If PM want to know if group A > group B, then, most likely one way t-test will solve the problem if the metric follows normal distribution.
- Know what you are testing on or what your null hypothesis is. Are your verifying your samples are generated from the same distribution? Are you testing each group’s mean value are the same? Do you care about A > B or do you care about the lift? etc. Each case need to be treated differently.
- Central Limit Theorem (CLT) works and may not work. CLT investigates parameters but if you care about the original distribution, it may never be normal.
- Bootstrap works for small sample size. Imagine you care about mean for one group, you can calculate the mean by sampling from this group with replacement. But be careful, your parameter is biased here.  

## Metrics

Both the product and marketing team cares about certain metrics. From business perspective, people may care about improvement on click through rate, orders per user per week or 3rd week retention. However, from a statistical perspective, you as a data scientist, may need to think differently. Regarding raw distributions, they may fall into binomial distribution, poisson distribution and gaussian distribution. However, each sample point may not be i.i.d. (independent and identically distributed). For that reason, you may not to consider entire distribution as a whole but conduct parameter estimation.

Your may refer the previous post regarding common KPIs distribution. And there are a few special cases you may want to consider carefully.

1. First is binary variables (click through rate, activation rate, etc.). The distribution is simple since it is determined only p and the number of iterations. However, you might be interested in the p itself rather the original distribution. So, based on central limit theorem, you can use either bootstrap to estimate the mean and standard deviation or use Bayesian inference by assuming all data points can be fitted by one binomial distribution. Even each data points may not follow the same distribution based on summation of binomial distribution is still a binomial distribution.


## t-Test or Bayesian Inference

In the very end, business people may need a p-value which might be misleading if you don’t explain it clearly. On the other hand, you may not want to go too deep statistically since business users may not buy it in the end. For that reason, here is my suggestion regarding tests.

- Rule of thumb, make sure your analysis is reproducible. That is to say, your results need to be checked and produce the same results by other data scientists. To achieve this, I would recommend the follows:

  - Write markdown in either Jupyter Notebook (if you like Python) or Rmarkdown (if you prefer R). Your analysis may not follow strict coding style but need to be human readable.
  - Always set seed. Random number is another pain point since it varies machine by machine.
  - If you hard code something, explicitly say it in your code. This is especially true for SQL files since you may use looker to generate SQL. And, if you used Looker explore, paste the url in your script for reproducible purposes.

- Interpretation. You may want to keep your test simple. So, my suggestion is to keep the analysis as simple as possible.

  - If you have raw data and the null hypothesis is to verify if those data are generated from the same distribution or if one sample’s means is larger the other one, then, I would use permutation test.
      ```
      treatment = [ 28.44, 29.32, 31.22, 29.58, 30.34, 28.76, 29.21,
      30.4 ,31.12, 31.78, 27.58, 31.57, 30.73, 30.43, 30.31, 30.32,
      29.18, 29.52, 29.22, 30.56]

      control = [ 33.51, 30.63, 32.38, 32.52, 29.41, 30.93, 49.78,
      28.96, 35.77, 31.42,30.76, 30.6 , 23.64, 30.54, 47.78, 31.98,
      34.52, 32.42, 31.32, 40.72]

      from mlxtend.evaluate import permutation_test
      p_value = permutation_test(treatment, control,
       method='approximate', seed=82)
      print(p_value)
      ```

  - If the sample size is not enough, like less than 1000, I may use bootstrap or Bayesian inference to make full use of all data and leverage prior knowledge. For example, resample from raw data and calculate mean or standard deviation. Based on bootstrap sampling, you may have an estimate rather than one parameter. And if you would like to apply Bayesian analysis, you need to designate a likelihood function and a conjugate prior (easier MCMC). That is to say, always be aware that you are compromising on something.

## Sampling

This part should be done prior to conducting the real experiment. But, business owners or data scientists may be requested to provide ready to use samples for back-end people. In general, back-end engineers don’t care about experiment setup but data scientists must do the weight lifting part.

Based on size of our data, full randomized sampling and stratified sampling should be reasonable. Fully randomization is easy to implement by hashing user id to add users to certain experiment bucket. Stratified sampling is also a great method to ensure we are testing on representative sample. I pasted a sample R chunk here which I used multiple times to select samples from population.

```
set.seed(82)
stratified_sample <- user_data %>%
  group_by(metro_id, channel, activated_year) %>%
  mutate(num_rows=n()) %>%
  sample_frac(0.2, weight=num_rows) %>%
  ungroup %>%
  select(user_id)
```

One important point to notice is that you may not stratify on too many features since the methodology might break at that point.
