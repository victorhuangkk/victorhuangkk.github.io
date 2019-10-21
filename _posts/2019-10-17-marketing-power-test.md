---
layout: post
title: Marketing Power Analysis
subtitle: ... or not to be?
tags: [marketing, statistics]
---


In order to plan marketing campaign beforehand, marketing team's manager need to understand the marketing


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
