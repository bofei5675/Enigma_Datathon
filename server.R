library(RSQLite)
library(DBI)
source('helper.R')
server <- function(input, output, session) {
  session$onSessionEnded(function(){
    shiny::stopApp()
  })
}