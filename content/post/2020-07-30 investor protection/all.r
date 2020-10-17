
    library(WDI)
    library(ggplot2)
    library(tidyverse)
    library(ggthemes) 
    library(cowplot)

search<-WDIsearch(string='Protecting minority investors')
    

protecall <- WDI(country="all", indicator=c("PROT.MINOR.INV.EXT.BUS.DISC.010.XD", 
                                           "PROT.MINOR.INV.IC.PRIN.EXT.DIR.LGL.010.XD",
                                           "PROT.MINOR.INV.EASE.SHARE.LGL.XD.010.DB1519",
                                           "PROT.MINOR.INV.EXT.SHARE.RTS.XD.010.DB1519",
                                           "PROT.MINOR.INV.EXT.OWNR.CONT.XD.0100.DB1519",	
                                           "PROT.MINOR.INV.EXT.CORP.TRANP.XD.0010.DB1519"
                                           ), start=2020, end=2020)


colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.EXT.BUS.DISC.010.XD'] <- 'index1'
colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.IC.PRIN.EXT.DIR.LGL.010.XD'] <- 'index2'
colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.EASE.SHARE.LGL.XD.010.DB1519'] <- 'index3'
colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.EXT.SHARE.RTS.XD.010.DB1519'] <- 'index4'
colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.EXT.OWNR.CONT.XD.0100.DB1519'] <- 'index5'
colnames(protecall)[colnames(protecall) == 'PROT.MINOR.INV.EXT.CORP.TRANP.XD.0010.DB1519'] <- 'index6'


 i1 <- ggplot(data=protecall,aes(x= reorder(country, index1),y=index1,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
        geom_bar(stat ="identity") +
        ggtitle("Extent of disclosure")+
        scale_fill_manual(name = "", values=c("darkred","grey75"))+ 
        labs(x = "", y = "")+
        theme(plot.title = element_text(colour="darkred", size=27, face="bold"), 
              legend.position = "none",
              panel.background = element_rect(fill = "white", colour = "white"),
              panel.border = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title=element_text(size=20,face="bold"))   
                              
i2<- ggplot(data=protecall,aes(x= reorder(country, index2),y=index2,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
  geom_bar(stat ="identity") +
  ggtitle("Extent of director liability")+
  scale_fill_manual(name = "", values=c("black","grey75"))+ 
  labs(x = "", y = "")+
  theme(plot.title = element_text(colour="black", size=27, face="bold"), 
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=20,face="bold"))   

i3<- ggplot(data=protecall,aes(x= reorder(country, index3),y=index3,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
  geom_bar(stat ="identity") +
  ggtitle("Ease of shareholders suit")+
  scale_fill_manual(name = "", values=c("darkviolet","grey75"))+ 
  labs(x = "", y = "")+
  theme(plot.title = element_text(colour="darkviolet", size=27, face="bold"), 
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=20,face="bold"))   

i4<- ggplot(data=protecall,aes(x= reorder(country, index4),y=index4,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
  geom_bar(stat ="identity") +
  ggtitle("Extent of shareholder rights")+
  scale_fill_manual(name = "", values=c("red","grey75"))+ 
  labs(x = "", y = "")+
  theme(plot.title = element_text(colour="red", size=27, face="bold"), 
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=20,face="bold"))   


i5<- ggplot(data=protecall,aes(x= reorder(country, index5),y=index5,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
  geom_bar(stat ="identity") +
  ggtitle("Extent of ownership and control")+
  scale_fill_manual(name = "", values=c("darkgreen","grey75"))+ 
  labs(x = "", y = "")+
  theme(plot.title = element_text(colour="darkgreen", size=27, face="bold"), 
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=20,face="bold"))   


i6<- ggplot(data=protecall,aes(x= reorder(country, index6),y=index6,fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
  geom_bar(stat ="identity") +
  ggtitle("Extent of corporate transparency")+
  scale_fill_manual(name = "", values=c("darkorange","grey75"))+ 
  labs(x = "", y = "")+
  theme(plot.title = element_text(colour="darkorange", size=27, face="bold"), 
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "white"),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=20,face="bold"))   

plot_grid(i1, i2, i3, i4, i5, i6)







    
    
    
# for linkedin protection of minority rights

protec <- WDI(country="all", indicator=c("PROT.MINOR.INV.DFRN.DB1519"), start=2020, end=2020)
    
colnames(protec)[colnames(protec) == 'PROT.MINOR.INV.DFRN.DB1519'] <- 'index'
  
ggplot(data=protec,aes(x= reorder(country, index), 
                          y=index, 
                          fill=factor(ifelse(country=="Brazil","Brazil","Others")))) +
          geom_bar(stat ="identity") +
          ggtitle("Protection of minority investors (2020)")+
          scale_fill_manual(name = "", values=c("darkgreen","lightgreen"))+ 
          labs(x = "", y = "")+
          theme(plot.title = element_text(colour="darkgreen", size=50, face="bold"), 
                legend.title = element_text(size=32), legend.text = element_text(size=15),
                panel.background = element_rect(fill = "white", colour = "white"),
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank(),
                axis.title=element_text(size=20,face="bold"))   
