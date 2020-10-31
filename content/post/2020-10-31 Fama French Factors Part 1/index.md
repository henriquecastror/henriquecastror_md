---
authors:
- admin
- Gerson

categories: 

date: "2020-10-31T00:00:00Z"

draft: false

featured: false

gallery_item:

image:
  caption: https://pixabay.com/pt/photos/estoque-negocia%C3%A7%C3%A3o-monitor-neg%C3%B3cios-1863880/
  focal_point: center
  preview_only: false

projects:

summary: 

tags:
- Open Data
- Open Science
- Brazil 
- Finance 
- Research

title: Fama and French - Part 1

subtitle: Can we calculate the FF portfolios?

---


This post is co-authored with [Gerson Junior](https://scholar.google.com/citations?user=bbgB49g0N2cC&hl=pt-BR).



## The goal

The goal of this post is simple: to learn how to calculate the [Fama and French](https://www.sciencedirect.com/science/article/abs/pii/0304405X93900235) portfolios' returns. Keep in mind that we begin from scratch, so we are not thinking about coding optmization. 

You can download [here](www.google.com) the data that we fabricated to learn with. **We hope you help us if we make any mistake.**

**Important: we are using the two-factor 3X2 portfolio, meaning we have two factors (Growth and Size) and six portfolios (sample is split into three groups of Growth against two groups of size).**

## First  step

To start the process, install and load the following packages.

    library(readxl)
    library(dplyr)
    library(tidyverse)
    library(writexl)

Clear your workspace.

    # Clean dataset
    rm(list = ls())

Then, you have to import our data. Again, this is fabricated by us. You can see we have 10 stocks in two years. We also have each firms' Return, Market-to-book (MtB), and Size. All these values are random.
    
    # import data
    data <- read_excel("FF Example.xlsx", sheet="Before")
  
The first important step is to create deciles for the first sorting based on MtB. The result is simply a column  with the decile the firm is using MtB as a sorting variable. We did that in both years.    
    
    # Create deciles by MtB
    data <- data  %>% 
            group_by(Year) %>%  
            mutate(MtB_deciles = ntile(MtB, 10))

Then, using these deciles, we can split firms into three groups: **Growth** (first within the first three deciles), **Neutral** (firms from the 4th decile to the 7th decile), and **Value** (firms from the 8th decile until the 10th).
    
    # Defining Growth, Neutral, and Value
    data$MtB_class = ifelse(data$MtB_deciles<=3 ,"Growth", ifelse(data$MtB_deciles>=8 ,"Value", "Neutral" ))
    
This step is a little tricky. Not sure we can explain well in words, perhaps you want to see the data.frame first. 

But the idea below is to sort firms within each of the three groups of MtB, and split them into **Small** or **Big**. So, for the group **Growth**, we split into **Small** or **Big**, then we did the same for the group **Neutral**, then for the group **Value**.
    

    # Create deciles by Size within MtB
    data <- data  %>% 
            group_by(Year, MtB_class) %>%  
            mutate(Size_deciles = ntile(Size, 2))
    
    # Defining Growth, Neutral and Value within Size
    data$Size_class = ifelse(data$Size_deciles<=1 ,"Small","Big")
    
    # Defining Growth, Neutral and Value within Size
    data$Size_class = ifelse(data$Size_deciles <= median(data$Size_deciles) ,"Small", "Big")
    
    
The product of these first rows is the definition of four new columns in the dataset, which we will use the two spliting the sample. 
    
## Defining Portfolios
    
The row below is to define the 2x3 portfolios.

    # Finding portfolios
    data$port <- paste0(data$MtB_class,data$Size_class)
    
Then, we calculate the weights of each firm in each portfolio in each year.
    
    # generate firm-level time- and portfolio-specific weights
    data <- data  %>% group_by(Year, port) %>% mutate (weight = MtB/sum(MtB))


    
## Final part    
    
Okay, now that we have the six portfolios in each year, we can calculate the return of the SmB (small minus big) and HmL (High minus Low) factors. 

First, you need to define which stocks you are buying and which you are selling. We use the structure below:

$$SmB =  \frac{1}{3}(Small Value + Small Neutral + Small Growth) - \frac{1}{3} (Big Value + Big Neutral + Big Growth)$$
    
$$HML = \frac{1}{2} (Small Value + Big Value) - \frac{1}{2} (Small Growth + Big Growth)$$


For more information about this decision, see the [French's site](https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/Data_Library/f-f_factors.html).
 

Ok, the code below calculates the return of each of the six portfolios, and store then in a new data.frame:


    # Six portfolios returns
    data$smb_ret <-  data$weight * data$Return
    
    ret <- as.data.frame(tapply(data$smb_ret,
                                    list(data$Year, 
                                         data$port), 
                                    FUN = sum))
    
Here, we calculate the return of the SmB portfolio.     

    # SMB return
    
    ret$smb_buy  <- as.data.frame((ret$GrowthSmall + ret$NeutralSmall + ret$ValueSmall)/1/3)
    ret$smb_sell <- as.data.frame((ret$GrowthBig   + ret$NeutralBig   + ret$ValueBig  )/1/3)
    
    ret$smb      <- ret$smb_buy - ret$smb_sell
    
And here, we calculate the return of the HmL portfolio.     
    
    # HML return
    
    ret$hml_buy  <- as.data.frame((ret$ValueSmall + ret$ValueBig)/1/2)
    ret$hml_sell <- as.data.frame((ret$GrowthSmall+ ret$GrowthBig)/1/2)
    
    ret$hml      <- ret$hml_buy - ret$hml_sell
    
You can print in the display the portfolios return in each year:    
    
    paste("The returns of the Small minus Big portfolios are, respectively," ,round(ret$smb * 100 ,3),"%")
    
    paste("The returns of the High minus Low portfolios are, respectively," , round(ret$hml * 100 ,3),"%")



You can save the file to learn more about how we did it.
    
    write_xlsx(data, "FF Example After.xlsx")
    
    
## What do we learn? 

It is not easy to calculate the factors' returns, but it is doable. Our next step is to calculate it using real data from Brazilian stocks. 

Thanks for passing by. See ya!
    
        