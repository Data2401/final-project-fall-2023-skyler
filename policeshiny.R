# Load necessary libraries
library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
  titlePanel("Exploratory Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("var", 
                  "Select Variable:", 
                  choices = names(stopsdf))
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Check if the column is numeric
    if(is.numeric(stopsdf[[input$var]])) {
      # Plot a histogram for numeric data
      ggplot(stopsdf, aes_string(input$var)) +
        geom_histogram(binwidth = 30, fill = "lightblue", color = "black") +
        theme_minimal() +
        labs(title = paste("Histogram of", input$var), x = input$var, y = "Count")
    } else {
      # Plot a bar chart for categorical data
      ggplot(stopsdf, aes_string(input$var)) +
        geom_bar(fill = "lightblue", color = "black") +
        theme_minimal() +
        labs(title = paste("Bar Chart of", input$var), x = input$var, y = "Count")
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
