---
authors:
- admin

categories: 


date: "2020-07-22T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/_d9V1CNsa5g
  focal_point: "middle"
  preview_only: false

projects:

subtitle: Graphing Ibovespa in dollar using ipeadatar

summary: 

tags:
- Finance
- Open Data
- Open Code

title: Ibovespa vs. Ibovespa in dollar

---

I was wondering how to download data from Ipeadata to use in research. So let's use this post to learn how to create a graph with data from ipeadata. Start by installing and loading the following package. 

    library(ipeadatar)
    
Then, download the data. Like when we used data from the World Bank ([in this post](https://henriquemartins.net/post/2020-07-18-nr-listed-firms/)), we must know the indicator (i.e., the codes 'GM366_IBVSP366' and 'GM366_ERC366' below). It is easier here; you can use the row below to see the codes of all variables available.

    all_series <- available_series()

Then, after learning the codes, you download the data.  

    ibov  <- ipeadata(code = "GM366_IBVSP366")
    dolar <- ipeadata(code = "GM366_ERC366")

    
See that the period available is different between the two variables. So, lets use the last 5.000 observations. This will make our graph to start around May 2000.

    ibov  <- tail(ibov,5000)
    dolar <- tail(dolar,5000)

For convenience, let's delete some columns in Ibov and integrate the dollar to Ibov. 

    ibov<-subset(ibov, select=-c(tcode,uname))
    ibov$dolar <- dolar$value

Then, let's calculate the ratio between Ibovespa and dollar each day.     
    
    ibov$ibov_dolar <- (ibov$value/ibov$dolar)

    
Lastly, you are good to go, and you can create the plot below using the following rows.

    plot(ibov$ibov_dolar,
          ylab="",xlab="",
          type = "l", 
          col="blue",
          ylim=c(0, 120000))
    lines(ibov$value,col="green")
    legend("topleft",c("Ibovespa in dollar","Ibovespa"),fill=c("blue","green"),inset=.05, cex=2)
    title(main="Ibovespa in dollar vs. Ibovespa",
    ylab="Points", 
    xlab="Last 5.000 days as of July 21th 2020 (Period starts mid 2000)", cex.lab=1.5, cex.main=2.5)  
 

This is the graph you will find using the currently available data.

{{< figure src="ibov.png"  width="100%">}}



# What do we see?       
                 
This graph is simply a reminder of the value in dollar of our Stock market index. It shows that, at the moment, Ibovespa in dollar is not as high as one may think.

Thanks for passing by!

