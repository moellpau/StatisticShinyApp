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
          "IQ (M=100, SD=15)" = 1,
          "Körpergrößen (M=170, SD=10)" = 2,
          "Rendite DAX (M=0, SD=0.05)" = 3,
          "Standard (M=0, SD=1)" = 4
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
        max = 200
      ),
      numericInput(
        inputId = "sd",
        label = "Standardabweichung",
        value = 15,
        min = 1,
        max = 20
      ),
      actionButton(
        "button", "Verteile mich!"
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
        plotOutput("intervalldiagram"),
        textOutput("quantile")
      ),
      infoBox(
        "Quellen",
        "https://jonasschemmel.shinyapps.io/Konfidenzintervall-Rechner/",
        icon = icon("quote-right"),
        color = "navy"
      ),
      
    )
    
  )
  
  #g_data <- NULL
  
  # Define server logic required to draw a histogram
  server <- function(input, output, session) {
    observeEvent(input$button, {
      n <- input$n
      ewert <- input$ewert
      sd <- input$sd
      xsd <- sd/sqrt(n)
      x <- rnorm(n, ewert, sd)
      niveau <- input$niveau
      alpha <- 1 - niveau
      z <- qnorm(1-(alpha/2), ewert, sd)
      aintervall <- mean(x) - z*(xsd)
      bintervall <- mean(x) + z*(xsd)
      data <- data.frame(x, y = dnorm(x, ewert, sd))
      print(aintervall)
      print(bintervall)
      t.test(x)
    
    
    output$datadiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(data = data,
             aes(x)) + geom_histogram (color="blue", fill = 'grey') + ylab("Häufigkeit") + xlab("Werte")
      # draw the histogram with the specified number of bins
      
    })
    output$intervalldiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(data = data,
             aes(x, y)) + geom_line() +
        geom_vline(aes(xintercept= aintervall), color="red", linetype="dashed", size=1) +
        geom_vline(aes(xintercept= bintervall), color="blue", linetype="dashed", size=1) + 
        #geom_area(data = data, aes(y = y), fill = 'cornflowerblue', color = NA, alpha = .3) + 
        ylab("Dichte") + xlab("Werte")

      # draw the histogram with the specified number of bins
      
    })
    output$quantile <- renderText("Verteilung von")
    
    })
    observeEvent(input$normierung, {
      if (input$normierung == 1) {
        updateNumericInput(session, "ewert", value = 100)
        updateNumericInput(session, "sd", value = 15)
      }
      else if (input$normierung == 2) {
        updateNumericInput(session, "ewert", value = 170)
        updateNumericInput(session, "sd", value = 10)
      }
      else if (input$normierung == 3) {
        updateNumericInput(session, "ewert", value = 0)
        updateNumericInput(session, "sd", value = 0.05)
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
