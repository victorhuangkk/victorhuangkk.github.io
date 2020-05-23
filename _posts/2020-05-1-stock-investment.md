-   [Summary](#summary)
-   [Instrument Selection](#instrument-selection)
-   [Portfolio Optimization](#portfolio-optimization)
-   [Backtest](#backtest)
-   [Conclusion](#conclusion)

Summary
-------

This project is to create a self use stock selection and portfolio
optimization strategy. In general, investment is the combination of art
and science. Traditionally, people believe that an efficient portfolio
should be exposed to as diversified instruments as possible. For
example, from mean-variance perspective, variance of stocks and bonds
are negatively correlated so they should be included with almost the
same weight to diversify risks. However, regardless of effectiveness of
mean-variance portfolio construction, most individual investors are not
risk averse but loss averse. And the loss is not short term but mid/long
term loss. For that reason, instrument selection is crucial to the
performance in a relatively long time run. I agree with the idea that
value investment should be embraced by most investors since technical
analysis is time consuming. You may not want to quit your job and be a
day trader who doesn’t create concrete value for the society.

Currently, there are thousands of instruments over the market, equities,
fixed income, various derivatives, etfs, mutual funds, etc. My belief
is, simple is the best. If you don’t feel the necessity to add that
instrument to your portfolio, don’t add it. I summarized a few lessons I
learned from the market: 1.

Instrument Selection
--------------------

There are a few guidelines I followed to add instruments to my
portfolio:

1.  You should be familiar with that company. For example, I go to
    Starbucks frequently, I use Nvidia’s GPU in my home machine, I
    travel with Southwest, etc. All of companies create great product.
    In mid-long term, their growth is proposing.

2.  The current market is mainly supported by the Federal Reserve and
    municipal policies. The value of all stocks are generally
    over-prices. To mimic the market,

3.  Information will be digested as soon as possible and that’s the
    reason why you may find counterintuitive phenomenon in the market

-   Technology
    -   U.S.
        1.  Amazon, Apple
        2.  Uber
    -   China
        1.  Bilibili, Alibaba
        2.  Gensheixue(Online learning)
-   BioTech
    1.  Gilead Science, Crisper
-   Defense
    1.  Lockheed Martin

In most of the periods between 2016-2020, stocks are highly

This code chunk was implemented to calculate risk parity portfolios. In
most cases, when the entire market is gradually up, there is no need for
individual investors to hold the cash or cash equivalent, if you care
more about longer term profit rather than next month total portfolio net
value. For that reason, investment target is to maximize midterm to long
term total return. Based on this hypothesis, leveraged ETFs with risk
parity

Portfolio Optimization
----------------------

I do think portfolio optimization is useful. But we cannot simply give
the framework the complete set of stocks which contains all stocks over
the market. By intuitions, we may infer some stocks will outperform
others in short/midterm length. For example, I can assure with high
possibility that Amazon will outperform underarmor in the next one year.
This strategy helps me to construct my portfolio.

But there are two rules which cannot be broken: 1. Diversify portfolio
as much as possible 2. Never short the market

I used a Python package to conduct portfolio optimization

The mathematical formula for this optimization task is stated in below.

    ## Loading stock data from local file C:/Users/guanhua.huang/github/victorhuangkk.github.io/_scripts/stockdata_from_2015-05-20_to_2020-05-20_(64c75c1355d1ccd2ca3f2c5b4ec6e61c).RData

Backtest
--------

To verify the risk

    # check performance summary
    backtestSummary(bt)$performance

    ##                   risk parity portfolio tangency portfolio
    ## Sharpe ratio                  0.8258296          0.7168205
    ## max drawdown                  0.3736189          0.4018382
    ## annual return                 0.2031849          0.1911637
    ## annual volatility             0.2460373          0.2666828
    ## Sterling ratio                0.5438292          0.4757231
    ## Omega ratio                   1.2044897          1.1786037
    ## ROT (bps)                  4578.6200190        656.9454952

    # plot cumulative returns chart
    backtestChartCumReturns(bt)

![](C:/Users/guanhua.huang/github/victorhuangkk.github.io/_posts/2020-05-1-stock-investment_files/figure-markdown_strict/unnamed-chunk-2-1.png)

    # plot assets exposures over time
    backtestChartStackedBar(bt, portfolio = "risk parity portfolio", legend = TRUE)

![](C:/Users/guanhua.huang/github/victorhuangkk.github.io/_posts/2020-05-1-stock-investment_files/figure-markdown_strict/unnamed-chunk-2-2.png)

Conclusion
----------

Based on this short report, we can summarize that risk parity strategy
do work in some scenarios. And depends on how risky we want to develop
the portlfio,
