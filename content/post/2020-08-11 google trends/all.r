
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






# other graphs

#Investmentos
trends1<-gtrends(keyword = "investimentos",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x1     <-trends1$interest_over_time$date 
y1     <-trends1$interest_over_time$hits

#Finanças
trends2<-gtrends(keyword = "finanças pessoais",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x2     <-trends2$interest_over_time$date 
y2     <-trends2$interest_over_time$hits

#Bolsa
trends3<-gtrends(keyword = "ações",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x3     <-trends3$interest_over_time$date 
y3     <-trends3$interest_over_time$hits

#Dinheiro
trends4<-gtrends(keyword = "poupança",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x4     <-trends4$interest_over_time$date 
y4     <-trends4$interest_over_time$hits




par(mfrow=c(2,2))
plot(y1~x1,type = "b",lty = 1,main = "Investimentos",xlab = "",ylab = "",col="darkblue", cex=1.5,pch=16,cex.main=2.5)
plot(y2~x2,type = "b",lty = 1,main = "Finanças pessoais",xlab = "",ylab = "", col="darkgreen", cex=1.2,pch=16,cex.main=2.5)
plot(y3~x3,type = "b",lty = 1,main = "Ações",xlab = "",ylab = "", col="darkviolet", cex=1.2,pch=16,cex.main=2.5)
plot(y4~x4,type = "b",lty = 1,main = "Poupança",xlab = "",ylab = "", col="orange", cex=1.2,pch=16,cex.main=2.5)




#como investir
trends5<-gtrends(keyword = "como investir",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x5     <-trends5$interest_over_time$date 
y5     <-trends5$interest_over_time$hits

#investir no exterior
trends6<-gtrends(keyword = "Fundo de investimento",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x6     <-trends6$interest_over_time$date 
y6     <-trends6$interest_over_time$hits

par(mfrow=c(1,2))
plot(y5~x5,type = "b",lty = 1,main = "Como investir",xlab = "",ylab = "",col="darkblue", cex=1.5,pch=16,cex.main=2.5)
plot(y6~x6,type = "b",lty = 1,main = "Fundo de investimento",xlab = "",ylab = "", col="darkgreen", cex=1.2,pch=16,cex.main=2.5)







# single plot
trends1<-gtrends(keyword = "investimentos",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
x1     <-trends1$interest_over_time$date 
y1     <-trends1$interest_over_time$hits

par(mfrow=c(1,1))
plot(y1~x1,type = "b",lty = 1,main = "Procuras no Google do termo 'Investimentos'",xlab = "",ylab = "",col="darkblue", cex=1.5,pch=16,cex.main=3, cex.axis=2.5)

