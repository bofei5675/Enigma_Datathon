library(shiny)
library(shinydashboard)
library(plotly)
header <-shinydashboard::dashboardHeader(title = "NetworkTool", 
                                         titleWidth = 230
)

sideBar <-shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    shinydashboard::menuItem(
      "Customer_Feedback",
      tabName = "Customer_Feedback",
      icon = icon("fa fa-superpowers")
    ),
    shinydashboard::menuItem(
      'Entertainment',
      tabName = 'Entertainment',
      icon = icon('fa fa-superpowers')
    ),
    width = 350)
)

customer_feedback <- shinydashboard::tabItem(
  tabName = 'Customer_Feedback',
  shinydashboard::box(
    width = 12,
    shiny::fluidRow(
      column(
        width = 4,
        shiny::uiOutput('selectLine'),
        plotly::plotlyOutput('complainRatio')
       ),
      column(
        width = 4,
        plotly::plotlyOutput('complainType')
      )
    ),
    shiny::fluidRow(
      
      shinydashboard::box(
        width = 12,
        HTML('<h1>Subject Detail</h1>'),
        shiny::dataTableOutput('subjectDetail')
      )
    )
    
  )
)

entertainment <- shinydashboard::tabItem(
  tabName = 'Entertainment',
  shinydashboard::box(
    width = 12)
)


body <- shinydashboard::dashboardBody(
  shinydashboard::tabItems(
    customer_feedback,
    entertainment
  )
) 

ui <- shinydashboard::dashboardPage(header, sideBar, body)