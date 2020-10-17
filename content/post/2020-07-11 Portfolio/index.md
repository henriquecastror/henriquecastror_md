---
authors:
- admin
categories: []

date: "2020-07-11T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/OHOU-5UVIYQ
  focal_point: ""
  preview_only: false

projects: []

subtitle: Launching my website with a portfolio optimization example.

summary: 

tags:
- 

title: My very first post! 

---


Welcome! I am happy that you are here! 

This is truly the first post on my website. 

In the past few days, I made some posts to practice dealing with the website code. However, I am really launching the website with this post. 

And there is no better way to launch it than providing a code in which I work with the very first topic that made me fall in love with finance: the efficient frontier by Markowitz (1952). 

Though I don't work much with portfolio selection anymore, it is always nice to remember what made me gravitate towards finance.

In this post, first, we will be selecting some stocks from Ibovespa. Then, we are going to estimate several combinations of these stocks, forming portfolios. Then, we will plot the return and the risk of these portfolios to reach the efficient frontier.

This post is based on a package from my friend [Marcelo Perlin](https://www.msperlin.com/blog/) and on [this post](//www.codingfinance.com/post/2018-05-31-portfolio-opt-in-r/).


## *Installing packages and calculating statistics*

If this is your first time using R, you'll need to install the necessary packages. If you already have these packages, ignore this step.

    install.packages(c("tidyr", "devtools","magrittr","tidyquant","plotly","timetk","dplyr"))
    
You need to load packages now.
    
    library(tidyr)
    library(devtools)
    library(magrittr)
    library(tidyquant) 
    library(plotly) 
    library(timetk) 
    library(dplyr)
    library(BatchGetSymbols)


Then, let's select the tickers we want to analyze. There are four rows below. The rows 1 to 3 download all the tickers included in IBovespa. 

To keep it simple, let's use only the tickers in the 4th row below.

    df.ibov <- GetIbovStocks()
    tickIbov <- df.ibov$tickers
    tickIbov <- paste(tickIbov , ".SA", sep="")
    
    tickIbov <- c("ITUB4.SA","ABEV3.SA","LREN3.SA","B3SA.SA","HYPE3.SA")

Then, we need to define the period we want to use.

    first.date  <- "2020-06-01"
    last.date   <- "2020-06-30"
    freq.data   <- 'daily'

Then, we download the prices and calculate the returns of all stocks.

    prices <- BatchGetSymbols(tickers = tickIbov, 
                         first.date = first.date,
                         last.date = last.date,
                         thresh.bad.data = 0.5,
                         freq.data = freq.data,
                         cache.folder = file.path(tempdir(),'BGS_Cache') )

    return_vector <- prices$df.tickers %>%
                    group_by(ticker) %>%
                    tq_transmute(select = price.adjusted,
                    mutate_fun = periodReturn,
                    period = 'daily',
                    col_rename = 'return',
                    type = 'log')

Notice that all returns are in the same column. We need to put each stock in a different column.

    head(return_vector)

    return_matrix <- return_vector %>% spread(ticker, value = return) %>% tk_xts()
    head(return_matrix)

Now, let's calculate the average return of each stock.

    ret_mean <- colMeans(return_matrix)
    print(round(ret_mean, 5))

Finally, let's create the covariance matrix annualized.

    cov_mat <- cov(return_matrix) * 252
    print(round(cov_mat,4))

Ok, the first section is concluded. We have the return and risk of all stocks.




## *Single portfolio analysis*


Now that we have all the necessary data, let's analyze one portfolio. 

First, let's generate random weights for each stock. 

Notice the weights will be random, so you will reach a different result each time you run the code. 

Also, we need the sum of the weights to be 1.

    w <- runif(n = length(prices$df.control$ticker))  

    w <- w/sum(w)                                     

    print(sum(w))                                   

Now, let's calculate the annualized portfolio returns, the portfolio risk, and the Sharpe ratio. 

For now, let's set the risk-free rate to zero. You can change it anytime.

    port_return <- (sum(w * ret_mean) + 1)^252 - 1

    port_risk <- sqrt(t(w) %*% (cov_mat %*% w))

    rf <-0

    sharpe <- (port_return - rf) /port_risk

These are the portfolio's statistics.

    print(port_return)

    print(port_risk)

    print(sharpe)





## *An analysis of multiple portfolios*

A more realistic example is to generate several different portfolios to find the one that suits us best.

First, let's select the number of portfolios we want to calculate the statistics.

I am selecting 1.000, which means that we will calculate the statistics of 1.000 different portfolios.

Again, the weight of each stock in each portfolio will be random.

    port_num <- 10000 
    
Here we need to create a matrix to store weights.

We also create a vector to store the returns, another vector to store the risk of each portfolio, and a third vector to store the Sharpe ratios.
    
    w_all           <- matrix(nrow = port_num, ncol = length(prices$df.control$ticker))

    port_return_all <- vector('numeric', length = port_num) 

    port_risk_all   <- vector('numeric', length = port_num) 

    sharpe_all      <- vector('numeric', length = port_num) 



Now, we create a loop to calculate the statistics of all the portfolios we created.

Then, we store the statistics in the empty vectors.

    for (i in seq_along(port_return_all)) {
    w <- runif(length(prices$df.control$ticker))
    w <- w/sum(w)
    w_all[i,] <- w 
  
    port_return <- (sum(w * ret_mean) + 1)^252 - 1
    port_return_all[i] <- port_return
  
    port_sd          <- sqrt(t(w) %*% (cov_mat  %*% w))
    port_risk_all[i] <- port_sd
  
    sr <- port_return/port_sd 
    sharpe_all[i] <- sr
    }


Finally, to keep things organized, let's create a table with the portfolio statistics combined.



    w_all <- tk_tbl(w_all)
    
    colnames(w_all) <- colnames(return_matrix)

    portfolio <- tibble(Return = port_return_all,
                    Risk = port_risk_all,
                    Sharpe = sharpe_all)

    portfolio <- tk_tbl(cbind(w_all, portfolio))






## *Final part: optimization and efficient frontier*

We are almost done! 

The code below finds the portfolio with minimum variance and the portfolio with the maximum Sharpe ratio. 

They are the portfolios that create the Efficient Frontier of Markowitz (1952).

    min_var <-  portfolio[which.min(portfolio$Risk),]        

    max_sr <-   portfolio[which.max(portfolio$Sharpe),] 


Finally, let's put in a graph.

    p <- portfolio %>%
    ggplot(aes(x = Risk, y = Return, color = Sharpe)) +
    geom_point() +
    theme_classic() +
    scale_y_continuous(labels = scales::percent) +
    scale_x_continuous(labels = scales::percent) +
    labs(x = 'Annualized Risk',
       y = 'Annualized Returns',
       title = "Portfolio Optimization & Efficient Frontier") +
    geom_point(aes(x = Risk,
                 y = Return), data = min_var, color = 'red') +
    geom_point(aes(x = Risk,
                 y = Return), data = max_sr, color = 'red') 

    ggplotly(p)

  

This is the frontier I've found. Remember, yours might be different because the weights are random.


{{< figure src="rplot.png" lightbox="true" >}}


The frontier is quite similar to those we see in textbooks. 

If you expand the number of stocks, you'll need to expand the number of portfolios to find a frontier like this one. 

Also, notice that the annualized return seems quite high. The reason is the period we are using (June 2020). In this period, we had a strong bull market after the bear market of March 2020 due to the COVID-19 crisis. 

Notice that portfolios' risks are also higher than usual levels.


## *Thanks for passing by*

Thank you for reading until the end!

If you want to read more stuff like this, stay tunned. 

If you want to receive an email every time I post stuff like this, please click on the newsletter button and let me know your email.

See ya! 




