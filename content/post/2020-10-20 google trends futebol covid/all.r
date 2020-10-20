
# https://cran.r-project.org/web/packages/gtrendsR/gtrendsR.pdf       


# gprop = c("web", "news", "images", "froogle", "youtube"),

# "now 1-H" Last hour
# "now 4-H" Last four hours
# "now 1-d" Last day
# "now 7-d" Last seven days
# "today 1-m" Past 30 days
# "today 3-m" Past 90 days
# "today 12-m" Past 12 months
# "today+5-y" Last five years (default)
# "all" Since the beginning of Google Trends (2004)
# "Y-m-d Y-m-d" Time span between two dates (ex.: "2010-01-01 2010-04-03")





library(gtrendsR)
library(ggplot2)




fut<-gtrends(keyword = "Futebol",geo = "BR",time = "today 12-m",gprop = c("web"),
                category = 0,hl = "en-US",low_search_volume = FALSE,
                cookie_url = "http://trends.google.com/Cookies/NID",
                tz = 0,onlyInterest = FALSE)

covid<-gtrends(keyword = "covid 19",geo = "BR",time = "today 12-m",gprop = c("web"),
             category = 0,hl = "en-US",low_search_volume = FALSE,
             cookie_url = "http://trends.google.com/Cookies/NID",
             tz = 0,onlyInterest = FALSE)




x     <-fut$interest_over_time$date 
fut   <-fut$interest_over_time$hits
covid <-covid$interest_over_time$hits



plot(covid~as.Date(x),type = "b",lty = 1,main = "",xlab = "",ylab = "",yaxt="none",
     col="darkgreen", cex=1.5,pch=16)
par(new=TRUE)
plot(fut~as.Date(x), type = "b",lty = 1,main = "",xlab = "",ylab = "",yaxt="none",
     col="red",cex=1.5,pch=16)
legend("topright", legend=c("Futebol", "Covid 19"),col=c("red", "darkgreen"), lty=1:1, cex=1.4)
mtext(side=1, line=2, "Meses", col="black", font=2, cex=1.5)
mtext(side=2, line=2, "Hits", col="black", font=2, cex=1.5)
mtext(side=3, line=2, "Pesquisa de 'Futebol' e 'Covid-19' nos últimos 12 meses", col="black",font=2,cex=2)
axis(2, seq(0,100),las=2, font=2, col="black")





