---
authors:
- admin

categories: 

date: "2020-10-20T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/LfviizMGKaE
  focal_point: center
  preview_only: false

projects:

subtitle: Back to "normal"?

summary: 

tags:
- 

title: Google trends - Futebol vs. Covid 19

---

Just a quick trend analysis in Google search. Loot at the Google trends of the words "Futebol" and "Covid 19".

{{< figure src="gripefutebol.png" width="100%" >}}

It looks like we are back to "normal".

Below you can find the code I used. Thank you for stopping by!


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
    legend("topright", legend=c("Futebol", "Covid 19"),col=c("red", "darkgreen"), lty=1:1, cex=1.5)
    mtext(side=1, line=2, "Meses", col="black", font=2, cex=1.5)
    mtext(side=2, line=2, "Hits", col="black", font=2, cex=1.5)
    mtext(side=3, line=2, "Pesquisa das palavra 'Futebol' e 'Covid-19' nos últimos 12 meses", col="black",font=2,cex=2.25)
    axis(2, seq(0,100),las=2, font=2, col="black")


