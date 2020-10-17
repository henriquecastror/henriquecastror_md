library(roll)
library(tidyr)
library(devtools)
library(magrittr)
library(tidyquant) 
library(plotly) 
library(timetk) 
library(dplyr)
library(BatchGetSymbols)
library(ggplot2)
library(date)

install.packages("date")


#Then, we need to define the period we want to download. Let's download 5 years.
    first.date  <- "2015-01-01"
    last.date   <- "2020-07-31"
    freq.data   <- 'daily'

    
#Then, we download the prices and calculate the returns. Let's use one stock that traditionally has a Beta below one: ABEV3. We also need to download the Index Bovespa to use as a benchmark for the market.
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


#The line below is only to merge all returns in a single place.
ret <- left_join(ret_ibov, ret_asset, by = c("ref.date" = "ref.date"))



#We need to calculate the market's variance and the covariance between the stock's and market's returns. For convenience, at each point in time, let's use the previous 252 days to calculate the variance and covariance. The choice for 252 days is arbitrary.
window <-252
ret$var <- roll_cov(ret$return.x, ret$return.x, width = window)
ret$cov <- roll_cov(ret$return.x, ret$return.y, width = window)
ret$beta <- ret$cov / ret$var




#Just exclude the rows where we do not calculate variance and covariance.
ret <- subset(ret, ret$beta != "NA" )


# select dataset
data_test<-subset(ret, ref.date > as.Date("2020-04-01"))
data_test<-subset(data_test, ref.date < as.Date("2020-05-30"))



# t-test
t.test(data_test$beta, mu = 1, data=data_test)


# ho: mu = 1
# h1: mu ~= 1



#Then, plot the graph.
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






ggplot(ret, aes(x=return.x, y=return.y)) + 
  geom_point()+
  geom_smooth(method=lm, se=FALSE)+
  labs( y = "Daily returns ABEV3", x="Daily returns IBOV",title = "Visualizing Beta")+
  theme(plot.title = element_text(color="darkgreen", size=20, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.title=element_text(size=18,face="bold"),
        title=element_text(size=15,face="bold", color="darkgreen"),
        axis.text.y = element_text(face = "bold", color = "darkgreen", size = 20),
        axis.text.x = element_text(face = "bold", color = "darkgreen", size = 20))+
  xlim(-0.2, 0.2) + ylim(-0.2, 0.2)




library("writexl")
write_xlsx(ret,"ret.xlsx")
