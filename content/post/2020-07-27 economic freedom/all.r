library(ggplot2)
library(lubridate)



data <- read.csv("data.csv")
data <- subset(data, Index.Year>=2000)


ggplot(data) +  
  geom_point(aes(x=Index.Year, y=Overall.Score)) + 
  geom_line( aes(x=Index.Year, y=Overall.Score) , group = 1 ,size=3, color="darkblue") +
  xlab("") + ylab("") + ylim(50,65) +
  ggtitle("Liberdade Econômica (Heritage Foundation)")+
  theme(plot.title = element_text(color="darkblue", size=60, face="bold"),
        panel.background = element_rect(fill = "white", colour = "white"),
        axis.text.y = element_text(face = "bold", color = "darkblue", size = 30),
        axis.text.x = element_text(face = "bold", color = "darkblue", size = 30)) +
        geom_rect(data=data,mapping=aes(xmin=2016, xmax=2020, ymin=50, ymax=65), color='grey', alpha=0.01)        




data <- subset(data, Index.Year>=2016)


ggplot(data) +  
  geom_point(aes(x=Index.Year, y=Overall.Score)) + 
  geom_line( aes(x=Index.Year, y=Overall.Score) , group = 1 ,size=3, color="darkblue") +
  xlab("") + ylab("") + ylim(50,57) +
  ggtitle("Liberdade Econômica (Heritage Foundation)")+
  theme(plot.title = element_text(color="darkblue", size=60, face="bold"),
        panel.background = element_rect(fill = "white", colour = "white"),
        axis.text.y = element_text(face = "bold", color = "darkblue", size = 30),
        axis.text.x = element_text(face = "bold", color = "darkblue", size = 30))
