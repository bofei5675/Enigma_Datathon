source('helper.R')
library(dplyr)
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
      m <- list(
        l = 50,
        r = 50,
        b = 100,
        t = 100,
        pad = 4
      )
      plotly::plot_ly(
        data = data,
        labels = ~Var1,
        values = ~Freq,
        textposition = 'inside',
        textinfo = 'label+percent',
        width = 400, height = 400,
        type = 'pie'
      ) %>% layout(
        title = 'Complain Or Commendation',
        autosize = F,  margin = m)
    })
  })
  
  output$complainType <- plotly::renderPlotly({
    options <- input$selectLineInput
    customer_data <- read.csv('data/customer_review_with_id.csv',stringsAsFactors = FALSE)
    isolate({
      if(options != 'ALL'){
        data <- customer_data[customer_data$id == options,]
      } else {
        data <- customer_data
      }
      data <- data.frame(table(data$Subject_Matter) / nrow(data) )
      
      m <- list(
        l = 50,
        r = 50,
        b = 100,
        t = 100,
        pad = 4
      )
      
      plotly::plot_ly(
        data = data,
        labels = ~Var1,
        values = ~Freq,
        textposition = 'inside',
        textinfo = 'label+percent',
        showlegend = FALSE,
        width = 500, height = 500,
        type = 'pie'
      ) %>% layout(
        title = 'Complain Categories',
        autosize = F,  margin = m)
    })
  })
  
  output$subjectDetail <- shiny::renderDataTable({
    options <- input$selectLineInput
    customer_data <- read.csv('data/customer_review_with_id.csv',stringsAsFactors = FALSE)
    isolate({
      if(options != 'ALL'){
        data <- customer_data[customer_data$id == options,]
      } else {
        data <- customer_data
      }
      df <- data[c('Subject_Matter','Subject_Detail')]
      
      
      df <- count(df,Subject_Matter,Subject_Detail)
      
      df <- as.data.frame(df)
      
      df <- df[order(df$n,decreasing = T),]
      
      df[1:10,]
    })
  })
  
  output$lineComparator<- shiny::renderUI({
    options <- unique(customer_data$Subject_Detail)
    shiny::selectInput('complainTypeSelector',label = 'Select a complain types:',
                       choices = options)
  })
    
  output$subjectDetail <- shiny::renderDataTable({
    options <- input$complainTypeSelector
    
    isolate({
      if(options != 'ALL'){
        data <- customer_data[customer_data$Subject_Detail == options,]
      } else {
        data <- customer_data
      }
      df <- data[c('Branch_Line_Route','Subject_Detail')]
      
      
      df <- count(df,Branch_Line_Route,Subject_Detail)
      
      df <- as.data.frame(df)
      
      df <- df[order(df$n,decreasing = T),]
      
      df[1:10,]
    })
  })
  
}