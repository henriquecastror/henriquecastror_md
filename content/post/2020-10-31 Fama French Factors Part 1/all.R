
library(readxl)
library(dplyr)
library(tidyverse)
library(xlsx)

# Clean dataset
rm(list = ls())

# import data
data <- read_excel("FF Example.xlsx", sheet="Before")


# Create deciles by MtB
data <- data  %>% 
        group_by(Year) %>%  
        mutate(MtB_deciles = ntile(MtB, 10))

# Defining Small and Big
data$MtB_class = ifelse(data$MtB_deciles<=3 ,"Growth", ifelse(data$MtB_deciles>=8 ,"Value", "Neutral" ))

# Create deciles by Size within MtB
data <- data  %>% 
        group_by(Year, MtB_class) %>%  
        mutate(Size_deciles = ntile(Size, 2))

# Defining Growth, Neutral and Value within Size
data$Size_class = ifelse(data$Size_deciles<=1 ,"Small","Big")

# Defining Growth, Neutral and Value within Size
data$Size_class = ifelse(data$Size_deciles <= median(data$Size_deciles) ,"Small", "Big")




##############################################################################################

# Finding portfolios
data$port <- paste0(data$MtB_class,data$Size_class)

# generate firm-level time- and portfolio-specific weights
data <- data  %>% group_by(Year, port) %>% mutate (weight = Size/sum(Size))


# Observe that weights in the 6 portfolios are summing 1 in each year
port_sum <- as.data.frame(tapply(data$weight,list(data$Year, data$port), FUN = sum))

round(print(port_sum),3)

# There are the unweighted average returns of each portfolio
port_ret <- as.data.frame(tapply(data$Return,list(data$port), FUN = mean))

print(round(port_ret,3))







##############################################################################################

# Six portfolios returns
data$smb_ret <-  data$weight * data$Return

ret2 <- as.data.frame(tapply(data$smb_ret,
                                list(data$Year, 
                                     data$port), 
                                FUN = sum))

# SMB return

ret2$smb_buy  <- as.data.frame((ret$GrowthSmall + ret$NeutralSmall + ret$ValueSmall)/1/3)
ret2$smb_sell <- as.data.frame((ret$GrowthBig   + ret$NeutralBig   + ret$ValueBig  )/1/3)

ret2$smb      <- ret$smb_buy - ret$smb_sell



# HML return

ret2$hml_buy  <- as.data.frame((ret$ValueSmall + ret$ValueBig)/1/2)
ret2$hml_sell <- as.data.frame((ret$GrowthSmall+ ret$GrowthBig)/1/2)

ret2$hml      <- ret$hml_buy - ret$hml_sell



paste("The returns of the Small minus Big portolios are, respectively," ,round(ret$smb * 100 ,3),"%")

paste("The returns of the High minus Low portolios are, respectively," , round(ret$hml * 100 ,3),"%")



################################################################################################
library(writexl)

write_xlsx(data  , "FF Example After2.xlsx")

