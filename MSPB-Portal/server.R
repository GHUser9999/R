library(shiny)
library(qicharts)
library(RODBC)
library(ggplot2)
library(magrittr)

#setwd( 'C:/Users/132659/Main/Programming/R/DataQualityTools')

#source('Global.R',local = FALSE)

rData <- data.frame(
  Year=rData[,"Year"],
  HospitalName=rData[,"HospitalName"],
  ServiceType=rData[,"ServiceType"],
  StandardizedCost=rData[,"StandardizedCost"]
)
rData <- with(rData,rData[order(Year,ServiceType,HospitalName),])


StckBar <- ggplot(data=rData, aes(x=HospitalName, y=StandardizedCost,fill=ServiceType))+
  geom_bar(stat="identity")+ 
  facet_grid(~Year)+
  labs(title=paste("Spend Analysis ",min(d[,"Year"]), " - ",max(d[,"Year"]) ),x="",y="Cost Per Year", fill="Service Type")+
  theme(plot.title = element_text(size=16, margin=margin(t=20,b=20)))+
  theme(axis.text.x=element_text(face="bold", size=6,angle=45,hjust=1,vjust=1))#+

#scale_fill_manual(values=colors(7))+
#theme(?legend.justification=c(1,0), legend.position=c(1,0))
#View(data)

#p <- plot_ly(data, x = ~Women, y = ~Men, text = ~School, type = 'scatter', mode = 'markers',
#             marker = list(size = ~gap, opacity = 0.5)) %>%
#  layout(title = 'Gender Gap in Earnings per University',
 #        xaxis = list(showgrid = FALSE),
#         yaxis = list(showgrid = FALSE))

#odbcClose(channel)
#data <- reactive({qic(rnorm(24), chart = 'i')})

server <- function(input, output, session)
{
#selectedData <- reactive([])
  
 #output$hist <- renderPlot(
 #    {
 #      hist(rnorm(input$num),main = isolate(input$title))
 #    })
 #output$hist <- renderPlot(data())
 #output$stats <- renderPrint(data())
  
  output$stckBar <- renderPlot(StckBar)

  observeEvent(input$Link2Readmit, {
    newvalue <- "Readmit"
    updateTabsetItems(session, "Panels", newvalue)
  })
  observeEvent(input$Link2Spend, {
    newvalue <- "Spend"
    updateTabsetPanel(session, "Panels", newvalue)
  })
 
}


shinyServer(server)



