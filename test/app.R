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

if (interactive()) {
  # Define UI for application that draws a histogram
  ui <- dashboardPage(
    skin = "blue",
    
    # Application title
    dashboardHeader(title = "KI Rechner"),
    
    
    
    # Sidebar with a slider input
    dashboardSidebar(
      sliderInput(
        inputId = "n",
        label = "Stichprobengröße:",
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
      numericInput(
        inputId = "ewert",
        label = "Erwartungswert",
        value = 100,
        min = 0,
        max = 100
      ),
      numericInput(
        inputId = "sd",
        label = "Standardabweichung",
        value = 15,
        min = 1,
        max = 20
      )
    ),
    
    # Show a plot of the generated distribution
    dashboardBody(
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
        icon = icon("comments"),
        color = "navy"
      ),
      
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
        plotOutput("intervaldiagram"),
        textOutput("quantile")
      ),
      infoBox(
        "Quellen",
        "Test",
        icon = icon("quote-right"),
        color = "navy"
      ),
      
    )
    
  )
  
  
  # Define server logic required to draw a histogram
  server <- function(input, output, session) {
   # observeEvent(input$niveau, {
      
   # })
    
  #  observeEvent(input$n, {
      
   # })
    
  #  observeEvent(input$ewert, {
      
     
   # })
    
   # observeEvent(input$sd, {
      
   # })
    
   # quantil1 <- qnorm((1 - niveau) / 2, ewert, sd / sqrt(n))
   # quantil2 <- qnorm(1 - (1 - niveau) / 2, ewert, sd / sqrt(n))
    
    output$datadiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      hist(rnorm(input$n, input$ewert, input$sd))
      
      # draw the histogram with the specified number of bins
      
    })
    output$intervalldiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      hist(rnorm(input$n, input$ewert, input$sd))

      # draw the histogram with the specified number of bins
      
    })
    output$quantile <- renderText("Verteilung von")
    
    observeEvent(input$normierung, {
      if (input$normierung == 1) {
        updateNumericInput(session, "ewert", value = 100)
        updateNumericInput(session, "sd", value = 15)
      }
      else if (input$normierung == 2) {
        updateNumericInput(session, "ewert", value = 50)
        updateNumericInput(session, "sd", value = 10)
      }
      else if (input$normierung == 3) {
        updateNumericInput(session, "ewert", value = 100)
        updateNumericInput(session, "sd", value = 10)
      }
      else if (input$normierung == 4) {
        updateNumericInput(session, "ewert", value = 0)
        updateNumericInput(session, "sd", value = 1)
      }
    })
  }
  
  # Run the application
  shinyApp(ui = ui, server = server)
}
