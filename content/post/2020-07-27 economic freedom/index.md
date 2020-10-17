---
authors:
- admin

categories: 


date: "2020-07-27T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/tncsQE63ENU
  focal_point: "left"
  preview_only: false

projects:

subtitle: Are we doing better?

summary: 

tags:
- 

title: Economic Freedom of Brazil

---

I read this article [here](https://www.heritage.org/international-economies/report/has-brazil-turned-the-corner-toward-greater-economic-freedom) that made me think about the Economic Freedom of Brazil. The article discusses the increase in Economic Freedom over the last few years. After reading the article, I needed a better perspective over a longer period. Let's do that.

First, load the following package.


    library(ggplot2)
    
I don't think [The Heritage Foundation](https://www.heritage.org/) has an R package, so we need to download an excel file with the data. Let's download ([here](https://www.heritage.org/index/explore?view=by-region-country-year&u=637312995746942503)). You need to select Brazil and all years.

After you have the file in your folder, load it to R.
    
    data <- read.csv("data.csv")
    
For simplicity, let's use the last 20 years.

    data <- subset(data, Index.Year>=2000)

Plot the graph.

      ggplot(data) +  
      geom_point(aes(x=Index.Year, y=Overall.Score)) + 
      geom_line( aes(x=Index.Year, y=Overall.Score) , group = 1 ,size=3, color="darkblue") +
      xlab("") + ylab("") + ylim(50,65) +
      ggtitle("Economic Freedom (Heritage Foundation)")+
      theme(plot.title = element_text(color="darkblue", size=60, face="bold"),
            panel.background = element_rect(fill = "white", colour = "white"),
            axis.text.y = element_text(face = "bold", color = "darkblue", size = 30),
            axis.text.x = element_text(face = "bold", color = "darkblue", size = 30))+
        geom_rect(data=data,mapping=aes(xmin=2016, xmax=2020, ymin=50, ymax=65), color='grey', alpha=0.01)        
  
This is the graph we find, using the code above.

{{< figure src="site.png" width="60%" >}}


# What do we see?       

The shaded part contains the years discussed in the article with more emphasis. It is clear that we got better over the last two years, but we are way below the period 2000-2005, and still below the period 2006-2015. So I guess we improved but we have been better in the past.

To give you more context, we are in the 144th position of Economic Freedom in the globe. Not good at all! This heat map gives more context about how Brazil is doing  ([here](https://www.heritage.org/index/heatmap?version=1386)).

Let's hope we keep improving the economic freedom in our country, which is so necessary to create jobs and wealth.

Please let me know what you think about this dataset in the comments. Thanks for passing by!

