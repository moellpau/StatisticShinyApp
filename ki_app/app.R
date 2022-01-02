#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- dashboardPage(
  skin = "blue",
  
  # Application title
  dashboardHeader(title = "KI Rechner"),
  
  # Sidebar with a slider input
  dashboardSidebar(
    sliderInput(
      "n",
      "Stichprobengröße:",
      min = 1,
      max = 1000,
      value = 500,
      step = 100
    ),
    selectInput(
      inputId = "normierung",
      label = "Triff eine Vorauswahl der Normierung:",
      c(
        "IQ-Werte (M=100, SD=15)" = 1,
        "T-Werte (M=50, SD=10)" = 2,
        "Standardwerte (M=100, SD=10)" = 3,
        "z-Werte (M=0, SD=1)" = 4
      )
    ),
    sliderInput(
      "niveau",
      "Konfidenzniveau:",
      min = 0.7,
      max = 0.99,
      value = 0.8,
      step = 0.01
    ),
    #updateNumericInput(session = getDefaultReactiveDomain(), inputId = )
    numericInput(
      "ewert",
      "Erwartungswert:",
      100,
      min = 0,
      max = 100
    ),
    verbatimTextOutput("value"),
    numericInput(
      "sdwert",
      "Standardabweichung:",
      15,
      min = 1,
      max = 20
    ),
    verbatimTextOutput("value"),
    numericInput(
      "pwert",
      "Ich habe einen Wert von:",
      120,
      min = 1,
      max = 200
    ),
    verbatimTextOutput("value")
  ),
  
  # Show a plot of the generated distribution
  dashboardBody(fluidRow(
    infoBox(
      "Was sind Konfidenzintervalle (KI)",
      "text",
      icon = icon("info"),
      color = "navy"
    ),
    infoBox(
      "Erklärung der Berechnung",
      "Test",
      icon = icon("calculator"),
      color = "navy"
    ),
    infoBox(
      "Verbale Erklärung",
      "Test",
      icon = icon("quote-right"),
      color = "navy"
    ),
    plotOutput("datadiagram")
  ),
  fluidRow(
    box(
      title = "Datensatz",
      solidHeader = TRUE,
      status = "primary",
      plotOutput("datadiagram")
    ),
    
    box(
      title = "Konfidenzintervall",
      solidHeader = TRUE,
      status = "primary",
      plotOutput("intervalldiagram"),
    ),
  ))
  
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  print(input)
  output$datadiagram <- renderPlot({
    hist(rnorm(input$n))
  })
  output$intervalldiagram <- renderPlot({
    hist(rnorm(input$n, input$ewert, input$sdwert))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
