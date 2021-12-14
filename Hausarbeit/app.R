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

# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "blue",

    # Application title
    dashboardHeader(title = "COVID Risiko Rechner"),
    

      
      # Sidebar with a slider input
      dashboardSidebar(
        radioButtons(inputId = "WellenID", 
                                label = "Wähle die COVID Welle aus, für die du dein Risiko berechnen möchtest:", 
                                c("1. Welle" = 1, "2. Welle" = 2, "3. Welle" = 3, "4. Welle" = 4)),
        selectInput(inputId = "Impfstatus", label = "Ich bin", c("geimpft oder genesen" = "2G", "ungeimpft" = "0G")),
        selectInput(inputId = "Altersgruppe", label = "in der Altersgruppe", c("0-4", "5-14", "15-34", "35-59", "60-79", "80+")),
        
        selectInput(inputId = "Bundesland", label = "und lebe in dem folgenden Bundesland", c("Sachsen", "Sachsen-Anhalt", "Brandenburg", "Berlin", "Schleswig-Holstein", "Niedersachsen", "Bremen", "Hamburg", "Mecklemburg-Vorpommern", "Hessen", "Thüringen", "Baden-Würtemberg", "Nordrhein-Westfalen", "Bayern", "Saarland")),
        actionButton("Berechnen", icon("refresh"))
        ),
      
      # Show a plot of the generated distribution
      dashboardBody(
        infoBox("Einwohnerzahl", 10 * 2, icon = icon("users"), color = "navy"),
        infoBox("7-Tage-Inzidenz", 10 * 2, icon = icon("sort-amount-up"), color = "navy"),
        infoBox("Impfquote", 10 * 2, icon = icon("syringe"), color = "navy"),
        valueBox(30 * 5, "Risiko", icon = icon("biohazard"), color = "red"),
        infoBox("Hier wird ein Erklärungstext stehen", icon = icon("info"), color = "navy"),
        
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
