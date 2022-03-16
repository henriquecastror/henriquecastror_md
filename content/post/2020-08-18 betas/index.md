---
authors:
- admin
categories: []

date: "2020-08-18T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/0rTCXZM7Xfo
  focal_point: ""
  preview_only: false

projects: []

subtitle: Beta variation through time

summary: 

tags:
- MBA
- Open Code
- Finance

title: A comment about a stock's Beta

---

I read the other day that some stocks have defensive Betas while others have aggressive ones. This is always true as a stock has either a Beta below one or above one (ok, let's ignore the unlikely case where a stock has a Beta one).

But, can we say that a stock always is aggressive (Beta above one) or defensive (Beta below one)? In other words, is there any time-variation of a stock's Beta?

# Before we start, what is Beta?

Beta is a measure of the linear relationship between a stock's return and the market's return. It measures the degree by which the return of the stock "follows" the market return.

I could cite the formula (i.e., the covariance between market's return and stock's return, over the Variance of market's return), but I believe it is more intuitive to see the graph below. 

The graph below is a simple plot of the IBOV's (market) and ABEV's (a selected stock, see below) returns. We can observe that when the IBOV's returns are positive, ABEV's returns are likely positive too. The blue line shows this positive linear relationship. The Beta is the linear coefficient of this line (if you remember the type of function y = a + bx, the linear coefficient  is b; this is what we are going to calculate below).

There are two things to understand here: 1) Beta is used in valuation models (such as the CAPM); thus it is essential to calculate it correctly; 2) when Beta is higher than 1, it means the stock is aggressive  (meaning that when the market's return is 1% the stock's return is higher than 1%). The opposite  occurs when the Beta is below 1 (meaning that when the market's return is 1% the stock's return is lower than 1%), and the stock is defensive.


{{< figure src="Beta.png" width="100%" >}}


# Beta variation through time

But let's check if there is time-variation in a stock's Beta. Start by loading the following packages.

    library(tidyquant) 
    library(roll)
    library(BatchGetSymbols)
    library(ggplot2)
    library(plotly) 

Then, we need to define the period we want to download. Let's download 5 years.

    first.date  <- "2015-01-01"
    last.date   <- "2020-07-31"
    freq.data   <- 'daily'

Then, we download the prices and calculate the returns. Let's use one stock that traditionally has a Beta below one: ABEV3. We also need to download the Index Bovespa to use as a benchmark for the market.


    ibov <- BatchGetSymbols(tickers = "^BVSP",
                            first.date = first.date,
                            last.date = last.date,
                            thresh.bad.data = 0.5,
                            freq.data = freq.data,
                            cache.folder = file.path(tempdir(),'BGS_Cache') )
    asset <- BatchGetSymbols(tickers = "ABEV3.SA",
                            first.date = first.date,
                            last.date = last.date,
                            thresh.bad.data = 0.5,
                            freq.data = freq.data,
                            cache.folder = file.path(tempdir(),'BGS_Cache') )
    ret_ibov <- ibov$df.tickers  %>%tq_transmute(select = price.adjusted,
                                        mutate_fun = periodReturn,
                                        period = 'daily',
                                        col_rename = 'return',
                                        type = 'log')
    ret_asset <- asset$df.tickers  %>%tq_transmute(select = price.adjusted,
                                        mutate_fun = periodReturn,
                                        period = 'daily',
                                        col_rename = 'return',
                                        type = 'log')

The line below is only to merge all returns in a single place.

    ret <- left_join(ret_ibov, ret_asset, by = c("ref.date" = "ref.date"))

We need to calculate the market's variance and the covariance between the stock's and market's returns. For convenience, at each point in time, let's use the previous 252 days to calculate the variance and covariance. The choice for 252 days is arbitrary.


    window <-252
    ret$var <- roll_cov(ret$return.x, ret$return.x, width = window)
    ret$cov <- roll_cov(ret$return.x, ret$return.y, width = window)
    ret$beta <- ret$cov / ret$var
    
Just exclude the rows where we do not calculate variance and covariance.
    
    ret <- subset(ret, ret$beta != "NA" )
    
Then, plot the graph.
    
    p <- ret %>%
    ggplot(aes(x = ref.date, y = beta)) +
    geom_line(color="darkblue") +
    theme_classic()+
    labs( y = "", x="",title = "Beta ABEV3 through time")+
    theme(plot.title = element_text(color="darkblue", size=40, face="bold"),
         panel.background = element_rect(fill = "grey95", colour = "grey95"),
         axis.title=element_text(size=14,face="bold"),
         title=element_text(size=14,face="bold", color="darkblue"),
         axis.text.y = element_text(face = "bold", color = "darkblue", size = 30),
         axis.text.x = element_text(face = "bold", color = "darkblue", size = 30))
    ggplotly(p)
    
   
   
{{< figure src="abev3.png" width="100%" >}}



# What do we learn?       

We see that a stock's Beta varies through time quite significantly. In the case of ABEV3, Beta ranged from 0.40 to 0.77 (almost 2x) since 2016. This variation has a significant effect on valuations using CAPM (we shall discuss CAPM in a later post). 

The main takeaway of this graph is that Beta is not a constant dimension of a stock's return. Thus, when you read that a stock has a Beta X, always remember that it has this X Beta *at the moment it is calculated*.

Another thing to pay attention to is the window of days that is used. I am using 252 days here. This is arbitrary! If we use a different number of days, the calculated Beta is likely to change. 

So pay attention to interpret a stock's Beta correctly. Thanks for passing by!



    
    
    
    
    

    
