---
layout: post
title: Marketing Power Analysis
tags: [marketing, statistics]
---


In order to plan marketing campaign beforehand, marketing team's manager need to plan quarterly marketing spend. It is necessary to make data driven decision. This campaign tried to reactivate "dead" users.

Based on historical data, users' organic(baseline) reactivate rate was 2.3%. To provide business decisions, analysts were required to provide stories. To accomplish this task, power analysis was used here.

To be simple, power analysis connects four variables:

- Significance Level, which represents type I error probability
- Statistical Power, which represents 1 - type II error probability
- Population, which represents number of observations
- Effective size, <img src="https://render.githubusercontent.com/render/math?math=2arcsin(\sqrt{p1})-2arcsin(\sqrt{p2})">


I used a R function called pwr. It accept 3 out of 4 power analysis input and returns the forth one.

[pwr function](https://github.com/cran/pwr/blob/master/R/pwr.r.test.R)


~~~
significance_level <- 1 - seq(0.8, 0.99, by=0.01)
lift <- seq(1.05, 2, by=0.05)/100

mat <- as.data.frame(matrix(nrow = length(significance_level),
                            ncol = length(lift)))

rownames(mat) <- format(significance_level, nsmall = 2)
colnames(mat) <- format(lift, nsmall = 2)

for (i in 1:length(significance_level)) {
  for (j in 1:length(lift)) {
    ratio_1 <- lift[j]
    sig_level <- significance_level[i]
    temp <- pwr.p.test(h = ES.h(ratio_1,0.01), n = NULL,
                       alternative = "greater",sig.level = sig_level, power = 0.8)$n
    print(temp)
    mat[i,j] <- temp
  }
}
~~~

Then, we conducted stratified sampling to create experimental group follow the same distribution as the population in our database. In general, I conducted stratified sampling with numerical and categorical variables differently.

- Numerical variables: I grouped them into buckets and grouped.
- Categorical variables: I grouped them directly. However, may change the

Here are some need to be mentioned.

- Set up random seed for reproducibility
- Metro, acquisition channel and activation year were metrics requested by business team to be included. And they were all categorical variables.
- Based on the number of bucket in each variable, the size of population and sample fraction in the


~~~
set.seed(88)

stratified_sample <- user_data %>%
  group_by(metro_id, channel, activated_year) %>%
  mutate(num_rows=n()) %>%
  sample_frac(0.02, weight=num_rows) %>%
  ungroup %>%
  select(user_id)
~~~
