library(RSQLite)
library(DBI)
source('helper.R')
server <- function(input, output, session) {
  session$onSessionEnded(function(){
    shiny::stopApp()
  })
  
  customer_data <- read.csv('data/customer_review_with_id.csv',stringsAsFactors = FALSE)
  
  output$selectLine <- renderUI({
    
    options <- unique(customer_data$id)
    options <- c(options,'ALL')
    
    shiny::selectInput(inputId = 'selectLineInput',label = 'Select a line for pie chart',choices = options,
                       selected = 'ALL')
    
  })
  output$complainRatio <- plotly::renderPlotly({
    options <- input$selectLineInput
    
    isolate({
      if(options != 'ALL'){
        data <- customer_data[customer_data$id == options,]
        
      } else {
        data <- customer_data
      }
      data <- data.frame(table(data$Commendation_or_Complaint) / nrow(data) )
      
      plotly::plot_ly(
        data = data,
        labels = ~Var1,
        values = ~Freq,
        textposition = 'inside',
        textinfo = 'label+percent',
        type = 'pie'
      )
    })
  })
    
  output$complainType <- plotly::renderPlotly({
    options <- input$selectLineInput
    
    isolate({
      if(options != 'ALL'){
        data <- customer_data[customer_data$id == options,]
      } else {
        data <- customer_data
      }
      data <- data.frame(table(data$Subject_Matter) / nrow(data) )
      
      plotly::plot_ly(
        data = data,
        labels = ~Var1,
        values = ~Freq,
        textposition = 'inside',
        textinfo = 'label+percent',
        showlegend = FALSE,
        type = 'pie'
      )
    })
  })
  
    
  
}