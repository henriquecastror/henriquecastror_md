---
authors:
- admin

categories: 


date: "2020-07-23T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/dQLgop4tnsc
  focal_point: "right"
  preview_only: false

projects:

subtitle: Are we doing better?

summary: 

tags:
- Research
- Open Data
- Brazil

title: Brazilian corruption Index (WGI)

---

There is one dataset that I like a lot: the [Worldwide Governance Indicators (WGI)](https://info.worldbank.org/governance/wgi/) project. It contains data since 1996 about the governance of all countries. Governance here is measured by the six following variables:


1. Voice and Accountability
2. Political Stability and Absence of Violence
3. Government Effectiveness
4. Regulatory Quality
5. Rule of Law
6. Control of Corruption

Before we continue, it is important to know what these variables are measuring: they measure Brazilians' **perception** about governance, they do not measure governance per se. Thus, the Government Effectiveness variable, for instance, represents how effective Brazilians believe their Government are, not whether the Government is really effective or not. **Perception** here is the crucial word, so let's keep that in mind. 

Also, the six variables are measured on a scale from -2.5 to 2.5. The higher the number, the "better" or the more "optimistic" the society of that country is about that variable.

I am not aware of a package that downloads this data automatically (if you are aware, please let me know in the comments). But I know it is free, and you can download either the excel or the .dta (the native format of Stata) files. For your convenience, I put the direct links for download [here](https://info.worldbank.org/governance/wgi/Home/downLoadFile?fileName=wgidataset.xlsx) and [here](https://info.worldbank.org/governance/wgi/Home/downLoadFile?fileName=wgidataset_stata.zip), respectively. I prefer to load the data from the .dta because it is already in the long format. 


First, let's load the necessary packages and the data using the rows below.


    library(haven)
    library(ggplot2)
    library(cowplot)

    wgidataset <- read_dta("wgidataset.dta")

Notice that we have data available for all countries. Let's focus on Brazil and on the Control of Corruption variable. Also, let's use 2002 as the first year because there are missing years before 2002. 

    wgidataset <- subset(wgidataset, countryname=="Brazil")
    wgidataset <- subset(wgidataset, year>=2002)


Then, let's plot it in a graph.
    
    ggplot(wgidataset, aes(x=year, y=cce, fill=year)) + ggtitle("Control of Corruption (WGI)")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.55, 0.2) + 
      theme(plot.title = element_text(colour="blue", size=30, face="bold")) +
      theme(legend.title = element_text(size=32), legend.text = element_text(size=15))
      

This is the graph we find using the currently available data.

{{< figure src="cceLinkedin.png"  width="100%" >}}

If we create the same graph for the six variables, this is what we find.

{{< figure src="all.png"  width="100%" >}}


# What do we see?       
                 
The first graph shows that Brazilians had intermediate perceptions about the country's ability to control corruption. From 2002 until 2013, the index is close to zero. It could be better, but it is not bad on a scale from -2.5 to 2.5. 

Then, in 2014, the score dropped to -0.3, and the negative peak is 2017 with a score of around -0.5. My opinion is that this is a consequence of the Car Wash operation (i.e., the _Lava Jato_ operation) that started this year. Because so many scandals have been discovered since 2014, Brazilians' perception is that corruption is everywhere. Thus, the score decreased.


Again, we need to interpret this data, knowing it measures the **perception** of Brazilians. The fact that the score dropped does not mean that corruption increased, it means that the **perception** of corruption increased.

Thanks for stopping by!


