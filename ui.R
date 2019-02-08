library(shiny)
library(shinydashboard)
header <-shinydashboard::dashboardHeader(title = "NetworkTool", 
                                         titleWidth = 230
)

sideBar <-shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    shinydashboard::menuItem(
      "About",
      tabName = "About",
      icon = icon("fa fa-superpowers")
    ),
    shinydashboard::menuItem(
      'Function1',
      tabName = 'network',
      icon = icon('fa fa-superpowers')
    ),
    width = 350)
)

about <- shinydashboard::tabItem(
  tabName = 'About',
  shinydashboard::box(
    width = 12,
    HTML('<h1>Some Introduction Text</h1>')
  )
)

func1 <- shinydashboard::tabItem(
  tabName = 'network',
  shinydashboard::box(
    width = 12,
    shiny::fluidRow(
      shiny::column(
        width = 6,
        HTML('<div>'),
        HTML('<h3>Upload SIF file if you have</h3>'),
        shiny::fileInput('species1',label = 'Input the first species sif file'),
        shiny::selectInput('sifFileType',label = 'Select your file types',
                           c('Multinetwork','Homology')),
        shiny::actionButton(inputId = 'uploadNetwork',label = 'Upload'),
        HTML('</div>')
      ),
      shiny::column(
        width = 6,
        HTML('<div><h3> Select the database:</h3>'),
        shiny::uiOutput('sqliteDatabaseSelect'),
        shiny::actionButton('showDatabase',label = 'Show'),
        HTML('</div>')
      )
    )
  ),
  shinydashboard::box(
    width = 12,
    shiny::column(
      width = 4,
      shiny::dataTableOutput('visDatabase1')
    ),
    shiny::column(
      width = 4,
      shiny::dataTableOutput('visDatabase2')
    ),
    shiny::column(
      width = 4,
      shiny::dataTableOutput('visDatabase3')
    )
  )
)


body <- shinydashboard::dashboardBody(
  shinydashboard::tabItems(
    about,
    func1
  )
) 

ui <- shinydashboard::dashboardPage(header, sideBar, body)