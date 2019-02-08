library(shiny)
library(shinydashboard)
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
    HTML('<h1>Some Introduction Text</h1>')
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