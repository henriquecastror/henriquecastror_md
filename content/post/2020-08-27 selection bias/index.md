---
authors:
- admin
categories: []

date: "2020-08-27T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://upload.wikimedia.org/wikipedia/commons/9/98/Survivorship-bias.png
  focal_point: right
  preview_only: false

projects: []

subtitle: An example of selection bias

summary: 

tags:
- Master
- PhD

title: Master class 2 - Selection bias

---

Let's create a quick visualization of selection bias and how it can lead us to wrong interpretations.

First, load the following packages.

    library(data.table)
    library(ggplot2)

Then, fabricate the data. I am fabricating data that fit what I have in mind. You can play with it. This is to mimic a possible dataset a researcher has.     

    n = 10000
    set.seed(100)
    
    x <- rnorm(n)
    y <- rnorm(n)

    data1 <- 1/(1+exp( 2 - x  -  y))
    group  <- rbinom(n, 1, data1)


Put all data together.

    data_we_see     <- subset(data.table(x, y, group), group==1)
    data_all        <- data.table(x, y, group)


Then, create the graphs.

    ggplot(data_we_see, aes(x = x, y = y)) + 
          geom_point(aes(colour = factor(-group)), size = 1) +
          geom_smooth(method=lm, se=FALSE, fullrange=FALSE)+
          labs( y = "", x="", title = "The observations we see")+
          xlim(-3,4)+ ylim(-3,4)+ 
          theme(plot.title = element_text(color="black", size=30, face="bold"),
                panel.background = element_rect(fill = "grey95", colour = "grey95"),
                axis.text.y = element_text(face="bold", color="black", size = 18),
                axis.text.x = element_text(face="bold", color="black", size = 18),
                legend.position = "none")
                
    ggplot(data_all, aes(x = x, y = y,  colour=group)) + 
      geom_point(aes(colour = factor(-group)), size = 1) +
      geom_smooth(method=lm, se=FALSE, fullrange=FALSE)+
      labs( y = "", x="", title = "All observations")+
      xlim(-3,4)+ ylim(-3,4)+ 
      theme(plot.title = element_text(color="black", size=30, face="bold"),
          panel.background = element_rect(fill = "grey95", colour = "grey95"),
          axis.text.y = element_text(face="bold", color="black", size = 18),
          axis.text.x = element_text(face="bold", color="black", size = 18),
          legend.position = "none")


{{< figure src="some.png" width="50%" >}}

{{< figure src="all.png" width="50%" >}}




# What do we see?       

Ok, here is the narrative. Imagine that you have a sample of individuals that you can observe the variables X and Y. You plot this data and find the first graph. Looks good! It looks like X and Y are negatively associated. Let's not say anything about causality right now. Let's simply take it as evidence of a negative relationship.

How accurate is your analysis?

Well, if your sample does not contain any bias in the selection process, you can assume that it represents the population. Then, probably you are good to infer the negative association.

Not in this case! See in the second graph that your sample is a biased representation of the population. It is evident in the second graph that the X~Y association is zero. So, concluding a negative association from the first graph is incorrect. This problem is called selection bias.

Two additional notes here. 

First, the researcher usually does not see the light green dots in the second graph (either because it is too expensive to collect data from all the individuals in a population, or because it is not possible to measure variables of these individuals). If this were only a matter of collecting the light green data, we'd be fine. But usually, this is not the case. So do not count on the idea of collecting the bright green data to your research.

Second, this selection bias can take many forms. Perhaps, the data you can access is from those in pink. Perhaps, those in pink are those that want to participate in your research (they kind of self-select into your research). Perhaps, those in light green are too shy or too busy to complete your research and to provide their data, or they are inaccessible to you. Many reasons could explain the fact that you only observe data in pink. 

Thus, more formally, Selection bias is the result of a non-random selection of who is going to participate in a research. It is evident from the second graph that those in pink have higher X and higher Y than the population. They were not taken randomly from the population!

So, before you start comparing groups in your analysis, ask yourself if your assignment mechanism (i.e., the process by which you select your sample) is truly random. 

By the way: there is a nice story about the airplane figure. Apparently, in WWII, the army collected data from the airplanes that returned from battles to verify where they were hit the most. The idea was to reinforce those places to increase the likelihood the airplane returns.

But then a statistician remembered: we only observe the hits of those airplanes that returned. What about those that didn't? They were probably hit in those places without the holes we observe as in those that returned.

Well, perhaps the smatest decision was to reinforce the places without the hits shown in the figure!

The main takeaway for you is the following: we only observe what we observe. We never observe those individuals that are hiding from us! 

Let me know if you have any questions.

Thanks for passing by.

