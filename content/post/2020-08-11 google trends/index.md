---
authors:
- admin

categories: 


date: "2020-08-11T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/WiSizdeZHBI
  focal_point: center
  preview_only: false

projects:

subtitle: Searching for some finance words in Google

summary: 

tags:
- Open Data
- Open Code

title: Google trends and finance

---

_Disclosure: I apologize in advance for the errors when using Latin accents in the text below!_

Someone asked me if Brazilians are studying more finance and investments, or only those that already know about investments are investing in stocks these days. To give more context, we were discussing the number of active investors in Brazil.

I had no idea how to answer that question!

But, then I thought that Google trends might have something to tell us. Maybe we can look at whether Brazilians are searching in Google more finance-related words over the last few years. Let's try that!

First, load the following packages. 


    library(ggplot2)
    library(gtrendsR)

Then, let's search for some interesting finance terms. I searched the terms "Investmentos", "Finanças pessoais", "Ações", and "Poupança".

You can play with the code below using different terms.


    trends1<-gtrends(keyword = "investimentos",geo = "BR",time = "today+5-y",gprop = c("web"),category = 0,hl = "en-US",low_search_volume = FALSE,cookie_url = "http://trends.google.com/Cookies/NID",tz = 0,onlyInterest = FALSE)
    x1     <-trends1$interest_over_time$date 
    y1     <-trends1$interest_over_time$hits
    

Now, we include the four plots together in a single graph.

    par(mfrow=c(2,2))
    plot(y1~x1,type = "b",lty = 1,main = "Investimentos",xlab = "",ylab = "",col="darkblue", cex=1.5,pch=16,cex.main=2.5)
    plot(y2~x2,type = "b",lty = 1,main = "Finanças pessoais",xlab = "",ylab = "", col="darkgreen", cex=1.2,pch=16,cex.main=2.5)
    plot(y3~x3,type = "b",lty = 1,main = "Ações",xlab = "",ylab = "", col="darkviolet", cex=1.2,pch=16,cex.main=2.5)
    plot(y4~x4,type = "b",lty = 1,main = "Poupança",xlab = "",ylab = "", col="orange", cex=1.2,pch=16,cex.main=2.5)

This is what we find:

{{< figure src="all.png" width="100%" >}}


# What do we see? 

Well, it seems that Brazilians are studying more about "investments" and "stocks". Of course, we cannot assess the quality of the content people look at, but it is clear that the interest in these two terms is increasing. 

It is awkward to me that the term "personal finance" seems to be high since 2016. Notice that the peak is around late 2015. I was not expecting that!

It also seems awkward to me that the search for the word "Poupança" had a peak in early 2020. I have no idea how to explain this result, but it seems correlated with the turmoil that COVID brought to our economy.


What are your thoughts on this? Thank you for stopping by!

