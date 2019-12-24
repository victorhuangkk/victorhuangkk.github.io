---
layout: post
title: Data and Product
subtitle: How to become a reliable data analyst
tags: [product, data]
comments: true
---

Product managers are in the center of an Internet based company. As a data analyst, you may work with them on a daily basis. But how to conduct high quality statistical data analysis need time. I would love to share some of my previous experience and mistakes to help other analysts grow faster. 


## Data Analysis Workflow

To be a reliable data analyst, I would dissect the project as the following steps:

1. Demystify Business Question. To achieve this goal, data analysts have to work together with product managers or other business users to specify the exact question you want to answer. It's both sides task to fully understand each other.

2. Exploratory Data Analysis. Talk is cheap but show me the code. After knowing the question, it is better for the analyst to conduct some simple analysis and give out initial stage results. Then, both sides need sit together to discuss the progress. And if there are multiple potential explanations, please choose one which makes the best sense

3. More work and Report. Data analysis is more than a messy Jupyter Notebook with unreproducible codes and plots. I would define a qualified analyst as a modern age consultant. You have to write code, but you have to tell vivid story as well.

4. Conclusion and Documentation. After the analysis been done, the answered business question, methodologies and visualizations need to be organized in easy-to-read manner and version controlled.  

I am going deeper in each step.


### Demystify Business Question

This step is crucial but get ignored by a handful amount of junior analysts. I made this mistakes a lot of times as well. I viewed the job of data analysts as data wrangler or SQL composer. The truth is that data makes no sense without business applications. You need to push the business users to understand the real question beneath a simple ask. For example, a product manager may ask you pull a list users for him without telling you ask business contexts. You may still accomplish this task without asking a single question. He may use the list to conduct an experiment which means multiple criteria need modification. However, you hard coded a bunch of parameters for simplicity. The result is that you doubled or tripled the initial workload compared with the original ask.


### Exploratory Data Analysis

In most cases, one question might be answered by multiple ways. For example, you may group users by acquisition time, region or acquisition channel for one experiment. The business users may have millions of assumptions but you may answer the question in only a few ways due to data constraints. At the same time, you need to understand the data from a statistical perspective. One simple example would be, two sets of data may share the same mean and variance but have drastically different underlying distribution.

That is to say, you need to provide `analyst's view` rather than following their guidance. Please remember, analysts and business users are collaborators.


### More work and Report
After deciding which way to go make sure everyone is on the same page, the analysts will start the real work. I do believe methodologies are more important the specific languages. You may use `R`, `Python`, `Julia` or even `Scala` if you choose the suitable approaches.

I believe data analysis is a combination of art, science and engineering. You should use your creativity you find meaningful approaches. After that, you have to follow rigorous statistics guidelines to generate results. In the very end, you have to choose clear visualizations to tell a thoughtful story.

I would like to share more thoughts here. I do recommend use raw data compared with `backed` data. The reason behind it is that you may mess easily forget your underlying assumptions. Always remember what you are trying to answer and follow that.

Regarding statistical data analysis, I would recommend every analyst to review introductory statistical inference textbook, some Bayesian analysis, regression analysis and experimental design. Those should enable you to conduct rigorous data analysis without violating statistics principles.

In terms of visualization, I have the following recommendations.

* Simple statistical graphs, use `ggplot2` or `seaborn`.
* Interactive plot, use `plotly`
* Geographical Data, use `kepler.gl`
* Fancy Plot, `r2d3`, `d3.js`, `pyecharts`, `vega`


### Conclusion and Documentation

This is an often ignored step since analysts may view most the analysis work as ad hoc tasks. It is wrong!!          

* First, you need to be reliable by providing unreproducible suggestions. you cannot be the only person in the company who can execute the code.

* Second, it saves time for you and others. You may reuse/revise large amount of work in the future if everything is well written and fully documented. And other business users/analysts may borrow your analysis to answer similar questions.

* Third, if anything goes wrong, you need to find the `bug`. Is there a number being wrongly calculated or an assumption was made incorrectly. It is not for blaming purposes but good for bug fixing and future improvement.

I prefer to use `R` for data analysis tasks. It provides clear visualizations, data wrangling tools and statistical packages. Additionally, you may use `dbplyr` to replace SQL, which is difficult to maintain. I would open two files, one is `.R` and the other is `.Rmd`. You may use the `.R` file to conduct analysis and `.Rmd` file to generate report. And in the very end, you may create a folder follow the similar pattern:

```
+-- requirements.txt
+-- src
|-- analysis.R
|-- report.Rmd
+-- data
|-- data_fetch.sql
|-- other_data.csv
```

And the folder should be stored in on GitHub(or something similar).
