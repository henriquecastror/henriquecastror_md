---
authors:
- admin

categories: 


date: "2020-07-18T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/MkIZ456qwPI
  focal_point: "right"
  preview_only: false

projects:

subtitle: Graphing the number of Brazilian listed firms

summary: 

tags:
- 

title: The number of Brazilian listed firms

---

Let's use this quick post to learn how to create a graph using the World Bank data. Start by installing and loading the following packages.


    library(wbstats)
    library(ggplot2)
    
Then, download the data. The crucial part here is to know the indicator (i.e., the code 'CM.MKT.LDOM.NO' used below). It would be best if you search for them online. The quickest way I know is to look at the World Bank site [here](https://data.worldbank.org/indicator). Just search the variable you want, then click on the "details" button, it will be there.

  
    firms <- wb(country = c("BR"), indicator = 'CM.MKT.LDOM.NO', startdate = 2000, enddate = 2020)

Then, let's plot it in a graph.    
    
    ggplot(firms) +  
        geom_point(aes(x=date, y=value)) + geom_line( aes(x=date, y=value) , group = 1 ) +
        xlab("Year") + ylab("") + 
        ggtitle("Number of listed Brazilian companies (World Bank)")+
        theme(plot.title = element_text(color="blue", size=18, face="bold"),
            axis.title.x = element_text(size=14, face="bold"),
            axis.title.y = element_text(size=14, face="bold"))
  
    
This is the graph you will find, using the currently available data.

{{< figure src="nrfims.png" width="60%" >}}



# What do we see?       
                 
This graph shows that the number of Brazilian listed firms was slightly over 320 (324 to be precise) in early 2020. The trend is negative. We had two increasing years (2006 and 2007), but then the number starts to decrease again.

Well, we definitively need more context to make sound interpretations about the Brazilian stock market, but this number does not seem good. What do you think?

Thanks for stopping by!

