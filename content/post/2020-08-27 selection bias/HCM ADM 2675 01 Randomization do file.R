
# remove everything
rm(list = ls())

library(data.table)
library(ggplot2)

# 
n = 10000
set.seed(100)


x <- rnorm(n)
y <- rnorm(n)

# generating data
data1 <- 1/(1+exp( 2 - x  -  y))
group  <- rbinom(n, 1, data1)

# all together
data_we_see     <- subset(data.table(x, y, group), group==1)
data_all        <- data.table(x, y, group)

# We see
g1 <- ggplot(data_we_see, aes(x = x, y = y)) + 
      geom_point(aes(colour = factor(-group)), size = 1) +
      geom_smooth(method=lm, se=FALSE, fullrange=FALSE)+
      labs( y = "", x="", title = "The observations we see")+
      xlim(-3,4)+ ylim(-3,4)+ 
      theme(plot.title = element_text(color="black", size=30, face="bold"),
            panel.background = element_rect(fill = "grey95", colour = "grey95"),
            axis.text.y = element_text(face="bold", color="black", size = 18),
            axis.text.x = element_text(face="bold", color="black", size = 18),
            legend.position = "none")
            
g1

# both
g2 <- ggplot(data_all, aes(x = x, y = y,  colour=group)) + 
      geom_point(aes(colour = factor(-group)), size = 1) +
      geom_smooth(method=lm, se=FALSE, fullrange=FALSE)+
      labs( y = "", x="", title = "All observations")+
      xlim(-3,4)+ ylim(-3,4)+ 
      theme(plot.title = element_text(color="black", size=30, face="bold"),
          panel.background = element_rect(fill = "grey95", colour = "grey95"),
          axis.text.y = element_text(face="bold", color="black", size = 18),
          axis.text.x = element_text(face="bold", color="black", size = 18),
          legend.position = "none")

g2


#https://www.r-bloggers.com/selection-bias-death-and-dying/
