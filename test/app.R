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
      fluidRow (
      box(
        title = "Was sind Konfidenzintervalle?",
        "Unter Konfidenzintervallen (KI) sind ein statistische Intervalle zu verstehen, mit welchem man besser einschätzen kann, wo beispielsweise wie in diesem Fall der wahre Mittelwert eines Datensatzes liegt. Dieses Konzept wird angewendet, da in der Statistik berechnete Werte oft auf der Grundlage einer Stichprobe zustande kommen."
      ),
      box(
        title = "Erklärung der Berechnung",
        "Erklärung der Berechnung"
      )),
      fluidRow (
      infoBox(
        "Das Konfidenzniveau ist",
        textOutput("konfidenzniveau"),
        icon = icon("percentage"),
        color = "navy"
      ),
      infoBox(
        "Die Untergrenze des Konfidenzintervalls ist",
        textOutput("intervall_a"),
        icon = icon("step-backward"),
        color = "navy"
      ),
      infoBox(
        "Die Obergrenze des Konfidenzintervalls ist",
        textOutput("intervall_b"),
        icon = icon("step-forward"),
        color = "navy"
      )),
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
        plotOutput("intervalldiagram")
      )),
      fluidRow (
      box(
        title = "Verbale Erklärung",
        textOutput("verbal_erkl")
        ),
      box(
        title = "Quellen",
        "StudyFlix (2021): Konfidenzintervalle, in: https://studyflix.de/statistik/konfidenzintervall-1580, (Stand: 28.12.2021)
        Schemmel, J. & Ziegler, M. (2020). Der Konfidenzintervall-Rechner: Web-Anwendung zur Berechnung und grafischen Darstellung von Konfidenzintervallen für die testpsychologische Diagnostik. Report Psychologie, 45(1), 16-21."
      ))
      
    )
    
  )
  
  # Define server logic required to draw a histogram
  server <- function(input, output, session) {
    observeEvent(input$button, {
      n <- input$n
      ewert <- input$ewert
      sd <- input$sd
      x.values <- rnorm(n, ewert, sd)
      y.values <- dnorm(x.values, ewert, sd)
      niveau <- input$niveau
      niveau_percentage <- niveau * 100
      alpha <- 1 - niveau
      quantil <- 1-(alpha/2)
      z <- qnorm(quantil, 0, 1)
      f <- z * sd/sqrt(n)
      aintervall <- mean(x.values) - f
      bintervall <- mean(x.values) + f
    
    
    output$datadiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(NULL,
             aes(x = x.values)) + geom_histogram (color="blue", fill = 'grey') + ylab("Häufigkeit") + xlab("Werte")
      # draw the histogram with the specified number of bins
      
    })
    output$intervalldiagram <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(NULL,aes(x = x.values, y = y.values)) + geom_line() + labs(x="Werte", y=NULL) +
        scale_y_continuous(breaks = NULL) +
        scale_x_continuous(breaks = c(ewert - 2 * sd,
                                      ewert - sd, ewert,
                                      ewert + sd, ewert + 2 * sd)) +
        geom_vline(aes(xintercept = aintervall)) +
        geom_vline(aes(xintercept = bintervall))
        #geom_area(data = data, aes(y = y), fill = 'cornflowerblue', color = NA, alpha = .3) 

      # draw the histogram with the specified number of bins
      
    })
    output$intervall_a <- renderText(aintervall)
    output$intervall_b <- renderText(bintervall)
    output$konfidenzniveau <- renderText(niveau_percentage)
    
    output$verbal_erkl <- renderText({ 
      paste("Der wahre Mittelwert der Stichprobe von ", n, "Werten befindet sich mit einer Wahrscheinlichkeit von",  niveau_percentage, "% innerhalb des Intervalls", aintervall, "bis", bintervall) 
    })
  
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
