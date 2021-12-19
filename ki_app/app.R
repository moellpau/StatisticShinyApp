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
ui <- dashboardPage(skin = "blue",
                    
                    # Application title
                    dashboardHeader(title = "KI Rechner"),
                    
                    
                    
                    # Sidebar with a slider input
                    dashboardSidebar( 
                      sliderInput("integer", "Stichprobengröße:",
                                  min = 1, max = 1000,
                                  value = 500, step = 100),
                      selectInput(inputId = "Normierung", 
                                  label = "Wähle die Normierung aus:", 
                                  c("IQ-Werte (M=100, SD=15)" = 1, "T-Werte (M=50, SD=10)" = 2, "Standardwerte (M=100, SD=10)" = 3, "z-Werte (M=0, SD=1)" = 4)),
                      sliderInput("niveau", "Konfidenzniveau:",
                                  min =0.7, max = 0.99,
                                  value = 0.8, step = 0.01),
                      numericInput("wert", "Erwartungswert:", 100, min = 0, max = 100),
                      verbatimTextOutput("value"),
                      numericInput("wert", "Standardabweichung:", 15, min = 1, max = 20),
                      verbatimTextOutput("value"),
                      numericInput("wert", "Ich habe einen Wert von:", 120, min = 1, max = 200),
                      verbatimTextOutput("value")
                      #actionButton("Berechnen", icon("refresh"))
                    ),
                    
                    # Show a plot of the generated distribution
                    dashboardBody(
                      infoBox("Was sind Konfidenzintervalle (KI)", "Konfidenzintervalle sind", icon = icon("info"), color = "navy"),
                      infoBox("Erklärung der Berechnung", "Test", icon = icon("sort-amount-up"), color = "navy"),
                      infoBox("Verbale Erklärung ", "Test", icon = icon("syringe"), color = "navy"),
                      #valueBox(30 * 5, "Risiko", icon = icon("biohazard"), color = "red"),
                      #infoBox("Hier wird ein Erklärungstext stehen", icon = icon("info"), color = "navy"),
                      box(title = "Datensatz", solidHeader = TRUE, status = "primary",
                          plotOutput("plot"),
                          tableOutput("data")),
                      box(title = "Konfidenzintervall", solidHeader = TRUE, status = "primary",
                          plotOutput("plot"),
                          tableOutput("data"))
                    )
                    
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
