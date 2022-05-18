# ShinyApp Project
# Author: Pape Seye & Karene Nana


library(tidyverse)
library(shiny)
library(shinyWidgets)


  
  worldcup <- read_csv("./world_cup_comparisons.csv")

teams_q <- c("Russia","Senegal", "Nigeria", "Belgium", "Germany", "England", "Spain", 
             "France", "Portugal", "Croatia", "South Korea", "Japan", "Nigeria",
             "Egypt", "Tunisia", "Morocco", "Brazil", "Uruguay", "Argentina",
             "Colombia", "Mexico")

worldcup %>%
  select(-player, -team) -> worldcup1

ui <- fluidPage(
  setBackgroundColor(color = c("#F7FBFF", "#2171B5"),
                     gradient = "radial",
                     direction = c("top", "left")),
  titlePanel("World Cup Stats"),
  sidebarLayout(
    sidebarPanel(
      selectInput("vars", "Select your stat", 
                  choices = names(worldcup1)),
      selectInput("vars2", "Select your second stat", 
                  choices = names(worldcup1)),
      checkboxGroupInput("team", "What teams are going to be in the semi finals of the next World Cup?", 
                         choices = teams_q)
      
    ),
    
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Histogram", plotOutput("plot1")),
                  tabPanel("Scatterplot", plotOutput("plot2")),
                  tabPanel("Summary" , dataTableOutput("dynamic"))
                  
      )
    )
  )
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(worldcup1, aes(x = .data[[input$vars]])) +
      geom_histogram(fill = "purple") +
      ggtitle("WORLD CUP HISTOGRAMS")
    
  })
  
  output$plot2 <- renderPlot({
    ggplot(worldcup1, aes(x = .data[[input$vars]], y = .data[[input$vars2]])) +
      geom_point() +
      ggtitle("WORLD CUP SCATTERPLOT")
    
  })
  
  
  output$dynamic <- renderDataTable({
    worldcup1
  })
  
  
  
}
shinyApp(ui = ui, server = server)


