---
authors:
- admin

categories: 


date: "2020-07-30T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/DfjJMVhwH_8
  focal_point: "middle"
  preview_only: false

projects:

subtitle: Graphing how well we protect our minority investors

summary: 

tags:
- Open Code
- Finance
- Governance

title: Minority Investor Protection

---

This is another post about collecting and graphing interesting data. 

There is another dataset from the World Bank that I like a lot (check [here](https://datacatalog.worldbank.org/dataset/wdi-database-archives)). We are going to use the WDI package today, which contains unique datasets. We start by installing and loading the following packages.


    library(WDI)
    library(ggplot2)
    library(tidyverse)
    
You will see there are several datasets in the WDI package. Let's first see all variables available. As you will see, the list is huge.

    search<-WDIsearch(string='')
    
My research is at the interface of corporate finance and governance. So let's search for some nice stuff about these topics. For instance, let's see if the word "investor" shows something interesting.

    search<-WDIsearch(string='investor')

Ok, we have a list with the indicators of all variables with "investor" in its name. It seems promising! Let's select the full index of Protecting Minority Investors (for that, we need to use the indicator below). If you want to understand how this index is measured, click [here](https://www.doingbusiness.org/en/methodology/protecting-minority-investors).

    protec <- WDI(country="all", indicator=c("PROT.MINOR.INV.DFRN.DB1519"), start=2020, end=2020)
    
    
For simplicity in making the graph, let's change the name of the variable.     
    
    colnames(protec)[colnames(protec) == 'PROT.MINOR.INV.DFRN.DB1519'] <- 'index'
    
Then, let's plot it in a graph.      
    
    ggplot(data=protec,aes(x= reorder(country, index), 
                          y=index, 
                          fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
          geom_bar(stat ="identity") +
          ggtitle("Protection of minority investors (2020)")+
          scale_fill_manual(name = "", values=c("darkgreen","grey75"))+ 
          labs(x = "", y = "")+
          theme(plot.title = element_text(colour="darkgreen", size=50, face="bold"), 
                legend.title = element_text(size=50), legend.text = element_text(size=15),
                panel.background = element_rect(fill = "white", colour = "white"),
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank(),
                axis.title=element_text(size=30,face="bold"))   
                              
                      
This is the graph we find, using the code above.

{{< figure src="protec.png" width="100%" >}}

The graph above contains the full index. It is composed of six sub-indexes combined. If we graph the six sub-indexes in separate graphs, this is what we have. The bottom three sub-indexes seem weird, but they are correct. They show that some countries have zero scores in it.

{{< figure src="protecall.png" width="100%" >}}



# What do we see?       
                 
My assessment of these graphs is the following: Brazil shows intermediate values of protecting the rights of minority investors. It could be better, but the full index of 62 is not bad (it may not be easy to see Brazil's score in the graph, but I assure it is 62).

The exciting part is in the second graph. It shows where we can improve (relatively to other countries). It seems that we could do better on Disclosure practices and Easy of suiting shareholders. Improving these two seems a good idea and an excellent way to enhance our stock markets in the near future.

Thanks for stopping by!

