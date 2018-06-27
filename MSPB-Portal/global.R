library(RODBC)
#library(qcc)
#library(ggvis)
library(dplyr)
library(ggplot2)
#library(plotrix)
library(RColorBrewer)

colors <- colorRampPalette(brewer.pal(7,"Paired"))

connection <- odbcDriverConnect("driver=SQL Server;server=CDAQS-T01",rows_at_time = 100,believeNRows = FALSE)

query <- {
  "  
    SELECT * FROM [BhwExternalPayer].[cms_mspb].[SpendFact]
  "
}

rData  <- sqlQuery(connection, gsub("\\n\\s+", " ", query), buffsize = 10000, believeNRows = FALSE) 


rData <- data.frame(
  Year=rData[,"Year"],
  HospitalName=rData[,"HospitalName"],
  ServiceType=rData[,"ServiceType"],
  StandardizedCost=rData[,"StandardizedCost"]
)

rData <- with(rData,rData[order(Year,ServiceType,HospitalName),])

ggplot(data=rData, aes(x=HospitalName, y=mean(StandardizedCost),fill=ServiceType))+
  geom_bar(stat="identity")+ 
  facet_grid(~Year)+
  labs(title=paste("Spend Analysis ",min(d[,"Year"]), " - ",max(d[,"Year"]) ),x="",y="Cost Per Year", fill="Service Type")+
  theme(plot.title = element_text(size=16, margin=margin(t=20,b=20)))+
  theme(axis.text.x=element_text(face="bold", size=6,angle=45,hjust=1,vjust=1))+
  scale_fill_manual(values=colors(7))
  #theme(?legend.justification=c(1,0), legend.position=c(1,0))

#View(data)
close
