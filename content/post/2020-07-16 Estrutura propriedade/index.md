---
authors:
- admin
categories: []

date: "2020-07-16T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://unsplash.com/photos/gY4vFNK5ky8
  focal_point: "top"
  preview_only: false

projects: []

subtitle: Graphing concentration of ownership 

summary: 

tags:
- 

title: Brazilian Ownership Concentration

---

Let's create a quick graph to see how concentrated is the ownership of Brazilian listed firms. Because of their importance, let's focus on the largest 100 firms. The analysis is based on shares with Voting rights (ON).

First, install and load these packages.

    library(readxl)
    library(ggplot2)
    

Then, let's upload the data. Download the file [here](https://doi.org/10.7910/DVN/OCSFBV).

    prop <- read_excel("conc.xlsx",range = "B4:D104")

Here, we are creating the five groups of firms based on the largest shareholder ownership.

    prop$ON2 <-cut(prop$ON, c(0,20,40,60,80,100))

This row shows us the percentage of firms in each group.

    table(prop$ON2)/length(prop$ON2)
    
Then, let's graph it.  
    
    par(bg="gray") 
    pie(table(prop$ON2)/length(prop$ON2),
                 col=c("darkred", "darkorange", "darkblue", "red","darkgreen") , 
                 labels=c("\nEm 22 empresas, \no maior acionista possui \nentre 0% e 20% das ações \ncom direito a voto" ,
                          "\nEm 23 empresas, \no maior acionista possui \nentre 21% e 40% das ações\ncom direito a voto \n" ,
                          "\nEm 31 empresas, \no maior acionista possui \nentre 41% e 60% das ações \ncom direito a voto " ,
                          "\nEm 15 empresas, \no maior acionista possui \nentre 61% e 80% das ações \ncom direito a voto" ,
                          "\nEm 9 empresas, \no maior acionista possui \nentre 81% e 100% das ações \ncom direito a voto" ), 
                 main="Percentual de ações com direito a voto \n100 maiores empresas (Julho 2020)",
                 font= 2)



    par(bg="gray") 
    pie(table(prop$ON2)/length(prop$ON2),
                   col=c("darkred", "darkorange", "darkblue", "red","darkgreen") , 
                   labels=c("\nIn 22 firms, \nthe largest shareholders owns \nbetween 0% and 20% of voting rights \n" ,
                            "\nIn 23 firms, \nthe largest shareholders owns \nbetween 21% and 40% of voting rights " ,
                            "\nIn 31 firms, \nthe largest shareholders owns \nbetween 41% and 60% of voting rights " ,
                            "\nIn 15 firms, \nthe largest shareholders owns \nbetween 61% and 80% of voting rights " ,
                            "\nIn 9 firms, \nthe largest shareholders owns \nbetween 81% and 100% of voting rights" ), 
                   main="Percentage of shareholdings with voting rights \n100 largers firms (July 2020)",
                   font= 2)

See below the summary statistics.

      summary(prop$ON)           


{{< figure src="en.jpg" lightbox="true" >}}



# What do we see?       
                 
This graph shows that Brazilian listed firms have highly concentrated ownership. The average of the top 100 firms is 43% of concentration, which is quite high when we compare with, for instance, the U.S. This level of concentration is similar to other countries in Latin America.

This is an important characteristic. It shows us that, on average, a firm has a concentrated shareholder that can "force" his/her decision. He/she "owns" the company. 

Some people would say this is good because this shareholder will take care of the whole company as much as he/she can, benefiting every minority shareholder will.

Other people would say this is bad because if this shareholder puts his/her interests above the company's, then minority shareholders will be hurt.


Theory and evidence are mixed but biased towards the second interpretation.

What do you think?

Thanks for stopping by! 


