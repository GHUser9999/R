library(shiny)
library(shinythemes)
library(shinyjs)
library(shinydashboard)

#SI.num      = sliderInput(inputId="num", label ="Choose Number",value = 25, min = 0, max = 100)
#PO.hist     = plotOutput("hist")
#vto.Stats   = verbatimTextOutput("stats")
#txtIn.title = textInput(inputId = "title", label = "Write a title", value = "Description")

po.StckBar    = plotOutput( outputId="stckBar"    )
po.BubbleChrt = plotOutput( outputId="BubbleChrt" )

tbPnl.Spend <- tabPanel("Spend",actionLink("Readmit", "Link2Readmit"),po.StckBar)

tbPnl.Readmit <- tabPanel("Readmit"
              
                    ,h3("Some Information")
                    ,tags$li("Item 1")
                    ,tags$li("Item 2")
                    ,actionLink("Link2Spend", "Link to Spend")
                    )

tbstPnl <- tabsetPanel( id = "Panels",tbPnl.Spend, tbPnl.Readmit )

#Build web page features only

ui <-  fluidPage(
  theme = shinytheme("lumen"),
  titlePanel("MSPB Portal"),
  mainPanel(tbstPnl)
)


shinyUI(ui)
