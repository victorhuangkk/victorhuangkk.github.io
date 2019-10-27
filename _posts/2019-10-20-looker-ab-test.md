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

```javascript
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
```

#### Step III

Ask user to input calculated mean




#### Code


~~~
view: ab_test {

# Add any variables here for splitting your data into A and B groups (in this case experimental group id, channel, metro and partition)

  filter: a_b_slice1 {}
  filter: a_b_slice2 {}
  filter: a_b_slice3 {}
  filter: a_b_slice4 {}

# Add Control Group Here After the First Round
  parameter: control_average {
    label: "Please Input the Calculated Control Group Mean"
    type: number
    default_value: "0.1"
  }

  parameter: control_group_size {
    label: "Please Input the Calculated Control Group Size"
    type: number
    default_value: "1000"
  }

  parameter: control_std {
    label: "Please Input the Calculated Control Group Standard Deviation"
    type: number
    default_value: "0.1"
  }

# Based on current setup, different variables need separate development.

# For rollout purposes, we need activation, 3rd week rentention and opu to be calculated. It might be easier to hard code different measures
# than use liquid variable and set up individual calculation in the current stage.

  parameter: metric_selector {
    type: string
    allowed_value: { value: "metric_1" }
    allowed_value: { value: "metric_2" }
    allowed_value: { value: "metric_3" }
    allowed_value: { value: "metric_4" }
    default_value: "metric1"
  }

  dimension: a_b {
    type: yesno
    hidden: no
    sql: {%condition a_b_slice1 %} ${TABLE}.a_b_slice1 {% endcondition %}
       AND {%condition a_b_slice2 %} ${TABLE}.slice2 {% endcondition %}
       AND {%condition a_b_slice3 %} ${TABLE}.slice3 {% endcondition %}
       AND {%condition a_b_slice4 %} ${TABLE}.slice4 {% endcondition %};;
  }

  dimension: user_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

# 3rd week retention
  measure: total_week_3_users {
    label: "Total Users | Week 3 Rentention"
    type: count_distinct
    filters: {
      field: user_weekly.user_week
      value: "3"
    }
    sql:user_weekly.user_id ;;
  }

  measure: active_week_3_users {
    label: "Active Users | Week 3 Rentention"
    type: count_distinct
    filters: {
      field: user_weekly.is_weekly_active_user_in_period
      value: "yes"
    }
    filters: {
      field: user_weekly.user_week
      value: "3"
    }
    sql: user_weekly.user_id;;
  }

# opu
  measure: total_activated_users {
    label: "All Activated Users | OPU"
    type: count_distinct
    sql: user_weekly.user_id ;;
    filters: {
      field: user_weekly.user_post_activation
      value: "yes"
    }
  }

  measure: total_orders_in_week {
    label: "All Orders In the Given Week | OPU"
    type: sum_distinct
    sql: user_weekly.orders_in_week ;;
    sql_distinct_key: CONCAT(user_weekly.user_id, CAST(user_weekly.week AS STRING)) ;;
  }


  # 7 day activation

  # need to be cleaned up, should use previous explore related stuff instead of aggregation from scratch.
  measure: new_signups {
    label: "All New Signups | 7 Day Activation"
    description: "Count distinct User IDs who signup with valid email, and not a guest"
    type: count_distinct
    sql: client_user_v2.user_id ;;
    filters: {
      field: client_user_v2.signup_timestamp_date
      value: "after 2004/01/01"
    }
    filters: {
      field: client_user_v2.email
      value: "-NULL"
    }
    filters: {
      field: client_user_v2.account_state
      value: "-GUEST, -GUEST_SUSPENDED"
    }
  }


  measure: activations_within_7_days {
    label: "Activation Within 7 Days | 7 Day Activation"
    description: "Count distinct User IDs where their first purchase was within 7 days of signing up"
    type: count_distinct
    sql: IF(TIMESTAMP_DIFF(client_user_v2.first_purchase_timestamp,
             client_user_v2.signup_timestamp, HOUR) <= 7*24, client_user_v2.user_id, null) ;;
    filters: {
      field: client_user_v2.account_state
      value: "-GUEST, -GUEST_SUSPENDED"
    }
    filters: {
      field: client_user_v2.first_purchase_timestamp_date
      value: "after 2004/01/01"
    }

  }

  # 30 day RO return


  measure: num_merchant_users_through_window_a {
    label: "Total Number of RO Users Merchant Pair | 30 Day RO Return"
     type: number
    sql: ${first_visit_order.num_merchant_users_through_window_a} ;;

  }

  measure: distinct_merchant_users {
    label: "RO Returned User Merchant Pair| 30 Day RO Return"
    type: number
    sql: ${order_1.distinct_merchant_users};;
  }


  measure: variable_mean {
    type: number
    sql: CASE WHEN {% parameter metric_selector %} = '3_week_retention' THEN ${active_week_3_users}/${total_week_3_users}
              WHEN {% parameter metric_selector %} = '7_day_activiation' THEN ${activations_within_7_days}/${new_signups}
              WHEN {% parameter metric_selector %} = '30_day_ro_return' THEN SAFE_DIVIDE(${distinct_merchant_users}, ${num_merchant_users_through_window_a})
              WHEN {% parameter metric_selector %} = 'opu' THEN SAFE_DIVIDE(${total_orders_in_week}, ${total_activated_users})
              END;;
    value_format: "0.0000"
  }


  measure: variable_standard_deviation{
    type: number
    sql: CASE WHEN {% parameter metric_selector %} = '3_week_retention' THEN ${variable_mean} * (1-${variable_mean})
              WHEN {% parameter metric_selector %} = '7_day_activiation' THEN ${variable_mean} * (1-${variable_mean})
              WHEN {% parameter metric_selector %} = '30_day_ro_return' THEN ${variable_mean} * (1-${variable_mean})
              WHEN {% parameter metric_selector %} = 'opu' THEN STDDEV(user_weekly.orders_in_week)
         END;;
    value_format: "0.0000"
  }


  measure: con_size {
    type: number
    hidden: yes
    sql: {% parameter control_group_size %} ;;
  }

  measure: con_avg {
    type: number
    hidden: yes
    sql: {% parameter control_average %} ;;
  }

  measure: con_std {
    type: number
    hidden: yes
    sql: {% parameter control_std %} ;;
  }

  measure: t_score {
    type: number
    sql:CASE WHEN {% parameter metric_selector %} = '3_week_retention'
             THEN (${variable_mean} - ${con_avg}) /
                  SQRT(
                  (POWER(${variable_standard_deviation},2) / ${total_week_3_users}) + (POWER(${con_std},2) / ${con_size})
                  )
            WHEN {% parameter metric_selector %} = '7_day_activiation'
            THEN (${variable_mean} - ${con_avg}) /
                  SQRT(
                  (POWER(${variable_standard_deviation},2) / ${new_signups}) + (POWER(${con_std},2) / ${con_size})
                  )
            WHEN {% parameter metric_selector %} = '30_day_ro_return'
            THEN (${variable_mean} - ${con_avg}) /
                  SQRT(
                  (POWER(${variable_standard_deviation},2) / ${num_merchant_users_through_window_a}) + (POWER(${con_std},2) / ${con_size})
                  )

            WHEN {% parameter metric_selector %} = 'opu'
            THEN (${variable_mean} - ${con_avg}) /
                  SQRT(
                  (POWER(${variable_standard_deviation},2) / ${total_activated_users}) + (POWER(${con_std},2) / ${con_size})
                  )
        END ;;
    value_format: "0.0000"
  }

  measure: t_test {
    label: "p value"
    description: "In general, the smaller p value is is, the stronger conclusion we can make"
    type: number
    sql: CASE WHEN {% parameter metric_selector %} = '3_week_retention' THEN redash488.Victor.ttest(${t_score}, ${total_week_3_users})
              WHEN {% parameter metric_selector %} = '7_day_activiation' THEN redash488.Victor.ttest(${t_score}, ${new_signups})
              WHEN {% parameter metric_selector %} = '30_day_ro_return' THEN redash488.Victor.ttest(${t_score}, ${num_merchant_users_through_window_a})
              WHEN {% parameter metric_selector %} = 'opu' THEN redash488.Victor.ttest(${t_score}, ${total_activated_users})
         END;;
    value_format: "0.0000"
  }

  measure: significance {
    label: "Statistical-Business Interpretation"
    # assume > 1000 data points in the sample, and p values are hard coded for the ease of use.
    sql:
      CASE
       WHEN ${total_week_3_users} <= 100 OR ${total_activated_users} <= 100 OR ${new_signups} <= 100 OR ${num_merchant_users_through_window_a} <= 100
             THEN 'Be Careful, Not Enough Data Points'
       WHEN ABS(${t_test}) <= 0.0005 THEN"Very strong believe those two groups are different"
       WHEN ABS(${t_test}) <= 0.001 THEN '0.001 sig. level'
       WHEN ABS(${t_test}) <= 0.005 THEN '0.005 sig. level'
       WHEN ABS(${t_test}) <= 0.01 THEN '0.01 sig. level'
       WHEN ABS(${t_test}) <= 0.025 THEN 'Strong belief those two metrics are different'
       WHEN ABS(${t_test}) <= 0.05 THEN 'Relativley strong belief those two metrics are different'
       WHEN ABS(${t_test}) <= 0.1 THEN 'Not strong belief. '
       ELSE 'INSIGNIFICANT!!'
      END ;;
  }
}

~~~
