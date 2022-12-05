---
authors:
- admin
categories: []

date: "2020-07-14T00:00:00Z"

draft: true

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/Z9arfr0f248
  focal_point: ""
  preview_only: false

projects: []

subtitle: Graphing Brazil Economic Policy Uncertainty

summary: 

tags:
- Open Code
- Open Data
- Brazil
- Research

title: Brazil Economic Policy Uncertainty

---

In this post, I will show how to create a graph about the Brazilian Economic Policy Uncertainty index. For more information about this index, click [here](https://www.policyuncertainty.com/). Shortly, it is an index that calculates economic policy uncertainty by searching for specific words in Brazilian newspapers.


First, install and load the following packages:

    library(epuR)
    library(dygraphs)
    library(ggplot2)
    library(zoo)
    library(xts)

Then, we have to download the data using the epuR package. You can download all available countries, as in the first row below. But, since we want Brazilian data, let's focus on it.

    epu_all         <- get_EPU()

    epu_brazil      <- get_EPU(region = "Brazil")


I am not sure why, but the last four months were not downloaded. So, let's download the excel spreadsheet, available [here](https://www.policyuncertainty.com/brazil_monthly.html), to find the values of these months.

    data  <- c(368.8998413,
               312.1482849,
               308.7680969,
               116.8758011)

    dates <- seq(as.Date("2020-03-01"), length=4, by="month")
    
    add   <- xts(x=data, order.by=dates)
    
Then, let's append this information.


    epu_brazil <- rbind(epu_brazil,add)

Finally, let's create a graph:

    dygraph(epu_brazil, 
            main = "Economic Policy Uncertainty - Brazil")%>%
            dySeries(color = "darkblue")%>%
            dyAxis("x", label = "Year")%>%
            dyOptions(axisLineWidth = 3, 
                      fillGraph = TRUE, 
                      drawGrid = FALSE)%>%
            dyAxis("y", valueRange = c(0, 700)) %>%
            dyEvent("2015-9-15", "Dirceu's and Vaccari's lawsuit", labelLoc = "bottom", color="green") %>%
            dyEvent("2016-3-16", "Lava Jato Leaks", labelLoc = "bottom", color="green") %>%
            dyEvent("2017-3-17", "Joesley day", labelLoc = "bottom", color="green") %>%
            dyEvent("2020-3-16", "COVID-19 social distancing begins in Brazil", labelLoc = "bottom", color="green") %>%
            dyRangeSelector(dateWindow = c("2015-01-01", "2020-07-01"))



Here is the graph. Notice that I included the events that I believe explain the peaks of this graph.

{{< figure src="Rplot04.png" lightbox="true" >}}


# What is the lesson?

Well, it seems that the economic uncertainty of Brazil related to the COVID-19 crisis is decreasing. At the moment, uncertainty is far from the peak, which is near the "Joesley day" in 2017.

Let's hope this crisis passes soon!

Thanks for stopping by! 


