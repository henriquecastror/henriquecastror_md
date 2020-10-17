library(haven)
library(ggplot2)

library(cowplot)

wgidataset <- read_dta("wgidataset.dta")


wgidataset <- subset(wgidataset, countryname=="Brazil")
wgidataset <- subset(wgidataset, year>=2002)


    vae<-ggplot(wgidataset, aes(x=year, y=vae, fill=year)) + ggtitle("Voice & Accountability")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="darkblue", size=27, face="bold"),legend.position = "none")
      
    pve<-ggplot(wgidataset, aes(x=year, y=pve, fill=year)) + ggtitle("Political Stability & Absence of Violence")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="darkred", size=27, face="bold"), legend.position = "none")
    
    gee<-ggplot(wgidataset, aes(x=year, y=gee, fill=year)) + ggtitle("Government Effectiveness")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="darkgreen", size=27, face="bold"), legend.position = "none")
    
    rqe<-ggplot(wgidataset, aes(x=year, y=rqe, fill=year)) + ggtitle("Regulatory Quality")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="purple", size=27, face="bold"), legend.position = "none")
        
    rle<-ggplot(wgidataset, aes(x=year, y=rle, fill=year)) + ggtitle("Rule of Law")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="darkorange", size=27, face="bold"), legend.position = "none")
    
    cce<-ggplot(wgidataset, aes(x=year, y=cce, fill=year)) + ggtitle("Control of Corruption")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.6, 0.6) + theme(plot.title = element_text(color="blue", size=27, face="bold"), legend.position = "none")
    
    plot_grid(vae, pve, gee, rqe, rle , cce )
    
    ggplot(wgidataset, aes(x=year, y=cce, fill=year)) + ggtitle("Control of Corruption (WGI)")  + 
      geom_bar(stat = "identity") + xlab("") + ylab("") + ylim(-0.55, 0.2) + theme(plot.title = element_text(colour="blue", size=55, face="bold"))+
      theme(legend.title = element_text(size=32), legend.text = element_text(size=22))  