
# Packages
library(dplyr)
library(lmtest)
library(sandwich)
library(readxl)
library(ggplot2)

# Clear
rm(list = ls())

# Data
data  <- read_excel("slides4-data-RDD.xlsx", sheet = "linear")

# Generate a line graph - one 
ggplot(data, aes(x, y))  + 
  geom_point( size=1.25) + 
  labs(y = "", x="", title = "Evolution of Y - Control and Treatment groups")+
  theme(plot.title = element_text(color="black", size=25, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.text.y = element_text(face="bold", color="black", size = 16),
        axis.text.x = element_text(face="bold", color="black", size = 16),
        legend.title = element_blank(),
        legend.key.size = unit(2, "cm")) +
  geom_smooth(method = "lm", fill = NA)

# Generate a line graph - two groups
ggplot(data, aes(x, y, group=group, color = factor(group)))  + 
  geom_point( size=1.25) + 
  labs(y = "", x="", title = "RDD example")+
  theme(plot.title = element_text(color="black", size=25, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.text.y = element_text(face="bold", color="black", size = 16),
        axis.text.x = element_text(face="bold", color="black", size = 16),
        legend.title = element_blank(),
        legend.key.size = unit(2, "cm")) +
  geom_smooth(method = "lm", fill = NA)




############ Defining CUT and BAND
# define cut
cut <- 50

# define the bandwidth
band <- 10
xlow = cut - band
xhigh = cut + band

# subset the data for the bandwidth
data <- subset(data, x > xlow & x <= xhigh, select=c(x, y,  group, treated))





############ RDD

# Regression  - not RDD
ols1 <- lm(y  ~ x   , data = data)
summary(ols1)

# Generating xhat
data$xhat <- data$x - cut

# Assuming same trends
ols2 <- lm(y  ~ xhat + treated  , data = data)
summary(ols2)



############ Average treatment effect
# Using averages in each side: 
# average treatment effect, using 10 units each side, is 44.3 - 38.9 = 5.4.
av <- data %>% group_by(treated) %>%   summarize(av = mean(y, na.rm = TRUE))
tapply(av$av, av$treated, mean)


# Using predicted values of control group
# average treatment effect, using the counterfactual of x = 1 and 10 units prior cut, is 49 - 35.6 = 13.4.
# 49 here comes from the Y of individual x = 51

ols_predict <- lm(y  ~ x   , data = subset(data, x<=50))
summary(ols_predict)

xpredict <-data.frame(x=c(51)) # predict counterfactual to x = 51

predict(ols_predict, xpredict)







################################
# Other examples

# Assuming different trends
data$trend <- data$xhat * data$treated

ols3 <- lm(y  ~ xhat + treated +trend , data = data)
summary(ols3)


# assuming non-linearities
data$xhatsq  <- data$xhat * data$xhat
data$trendsq <- data$xhatsq * data$treated

ols4 <- lm(y  ~ xhat + treated +xhatsq + trendsq , data = data)
summary(ols4)





# positive inclination example
data2  <- read_excel("data RDD.xlsx", sheet = "linear2")

# generating xhat and Xsquare
data2$xhat <- data2$x - cut

# assuming different trends
data2$trend <- data2$xhat * data2$treated
ols5 <- lm(y  ~ xhat + treated +trend , data = data2)
summary(ols5)

# Generate a line graph - two groups
ggplot(data2, aes(x, y, group=group, color = factor(group)))  + 
  geom_point( size=1.25) + 
  labs(y = "", x="", title = "RDD example")+
  theme(plot.title = element_text(color="black", size=25, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.text.y = element_text(face="bold", color="black", size = 16),
        axis.text.x = element_text(face="bold", color="black", size = 16),
        legend.title = element_blank(),
        legend.key.size = unit(2, "cm")) +
  geom_smooth(method = "lm", fill = NA)






# Nonlinear  example
data3  <- read_excel("data RDD.xlsx", sheet = "nonlinear")

# generating xhat
data3$xhat <- data3$x - cut
data3$xsq <- data3$x * data3$x

# assuming different trends
data3$trend <- data3$xhat * data3$treated
ols6 <- lm(y  ~ xhat + treated +trend , data = data3)
summary(ols6)

ols7 <- lm(y  ~ x + xsq  , data = data3)
summary(ols7)



# Generate a line graph - two groups
ggplot(data3, aes(x, y, group=group, color = factor(group)))  + 
  geom_point( size=1.25) + 
  labs(y = "", x="", title = "RDD example")+
  theme(plot.title = element_text(color="black", size=25, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.text.y = element_text(face="bold", color="black", size = 16),
        axis.text.x = element_text(face="bold", color="black", size = 16),
        legend.title = element_blank(),
        legend.key.size = unit(2, "cm")) +
  geom_smooth(method = "lm", fill = NA)


ggplot(data3, aes(x, y))  + 
  geom_point( size=1.25) + 
  labs(y = "", x="", title = "RDD example")+
  theme(plot.title = element_text(color="black", size=25, face="bold"),
        panel.background = element_rect(fill = "grey95", colour = "grey95"),
        axis.text.y = element_text(face="bold", color="black", size = 16),
        axis.text.x = element_text(face="bold", color="black", size = 16),
        legend.title = element_blank(),
        legend.key.size = unit(2, "cm")) +
  stat_smooth(method = "lm", formula = y ~ x + I(x^2))
