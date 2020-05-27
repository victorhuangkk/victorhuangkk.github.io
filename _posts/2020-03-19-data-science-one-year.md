---
layout: post
title: Personalized Data Science Road Map
tags: [other]
comments: true
---


## Summary

There are huge amount of blogs introduce people to data science field. To avoid build the wheel twice, I write this one to give out more personal suggestion and summary. All the contents are based on my personal experience and suppose to help people to get first hand experience about data science. So, let's get started.

## Technical Preparations

This is a very personal suggestions for people want to step into data science field. I would suppose you have <1 year coding experience and haven't being trained rigorously in computer science or statistics.

If that's the case, this road map may help you to learn statistical data science in the hard way. Most of the time, newbies would ask, Python or R, MySQL or BigQuery, Logistic Regression or Decision Tree, etc. Based on my limited experience, the question should be reformulated as what is the more suitable way to approach the problem, what's the motivation for this model, what's the best strategy to answer the business question? Of course, tools are important in the middle but end goal should be prioritized. I would give out some personal suggestions in terms of preparations.

### Programming

As a data scientist, you are highly likely to be asked to write Python independently. For example, your manager need a well organized report to unveil a trend. Or, you are asked to prototype/develop a recommendation system. Or, the marketing team need an optimized list of customers to send emails. There are many requests haven't being mentioned here but you may get the flavor. You may solve those questions in any script languages. I am using Python. I was exposed to Python in the wrong way. After several years of coding, I suggest learners pick the language in the hard way. It may take you about 3-6 months to finish all the materials but it would pay back later.

You may find all the materials online. First is to read through Guido van Rossum's documentation of Python and the latest version of Python tutorial. They would help you understand how the language works. Then, numpy and pandas official tutorials would become your best friends. Read them a few times would save you tons of time on stack overflow. Then, read a few coding style guide, cookbook and good repo would level up your skills fast. Computer science data structure algorithms would not be your core skills but them helps a lot to optimize your code.


### SQL
SQL is data science's mother language. Nobody would help you to fetch data and summarize them. If you work for a start-up or mid-size company, to be honest, a huge amount of your time will be spent in writing SQL. to be honest, SQL is an easy language to learn. As long as you are clear about the logic, you know how to write your query. Read a few how-to book plus some exercise would shape you as a good SQL writer. Then, the next step becomes how to re-use your SQL code and maintain them. Most of the time, SQL is a one time request. People care about one data points and you write SQL to pull data for them. My suggestion is, even for those requests, write a short report/documentation for QA purposes. And for reusable SQL components, I would write Python/R to pull data. It may take longer in the beginning but saves effort

### Business Sense and KPI

Many times in your daily work, data questions are loosely formulated. Product managers may care about certain KPIs or just ask, should we launch this product? Then, as a data scientist, it is your job to construct this problem, conform with stakeholders, fetch data from database, do analysis and deliver actionable suggestions. The process sounds smooth but you may face tons of practical problems. So, it is important to think as a consultant, you should babysit your client, provide them end-to-end solutions. It is your job to own the entire process not just statistical analysis or visualization. The company will not pay you 100K a year to write a few lines of R but lift KPIs. So, my suggestion is that you should have a good vision about the entire business, know each department's work and how do they collaborate. And think accordingly, like why do people use this KPI to measure activation rate rather than another one. All of those questions would help you level up your business common sense.

### Statistics and Math

People may think data scientists are applied statistician with better coding skills. This is partially correct. But the truth is that, your expectation is more than this. Your coworkers may not have sufficient statistical background. They may view statistics as black magic, solve all problems in a few seconds, which will never happen. Statistics is crucial to data science. People may use visualizations a lot, to tell vivid stories, but visualizations doesn't tell valid stories, at least not always. You cannot unveil causalities by fancy graphs and it is difficult to estimate relations between different factors. You will need statistical inference to differentiate buckets of testing groups.

And the part most people don't like, math, is also important. Math is not required in your daily job since high school math is more than sufficient in 'high tech' industry. Partial differential equations and martingales are not required to be complete your analysis but they helps you differentiate from others. So, my suggestion is to sharpen this 'not very useful' skills as much as possible.

### Machine Learning and Mathematical Optimization

Most newbies are attracted by these fancy terms, machine learning, AI, neural networks, etc. First of all, I am not an expert in this field. Based on the working experience and discussion with coworkers, most company may not have the scenarios to apply multi-layer neural networks. For that reason, simple machine models and their underlying mathematical reasonings are more important. For example,  if you spend some time to implement prototype clustering by yourself, it helps a lot for you to understand how k-means works. My suggest is that, do not rely on sckit-learn or other packages for learning but follow a comprehensive, derivation driven course to learn what's the underlying mechanics. Nobody cares about if you can write a few lines of Python to run a complicated model but people cares about what kind of problem you can solve. By solving the problem, what risks do you bear with and what are the underlying assumptions. When you understand the formulation for each algorithms and their motivations, all of those problems should be easy enough to answer.

And once you further to machine learning, all core engines are mathematical optimization. Even not in machine learning, optimization itself is important for a business. For example, how to optimize email marketing list by fulfill certain criteria. Or, in recommendation system, how to optimally send recommended links. So, my suggestion is that to get yourself exposed to linear programming or convex optimization a little. Try to implement a few exercise in Python (no EXCEL). From my perspective, a few type of business type business problems could be better solved by optimization compared with machine learning. But you have to do the weight lifting by yourself, problem formulation and programming are more difficult than using pre-built machine learning libraries.

## Communication and Presentation

I remembered that IBM call data scientist as the data analyst with presentation skills. It is exactly true if you work for small or mid size firms. Nobody cares about how fancy your model is or how complicated your 
