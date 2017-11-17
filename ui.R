#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # App title ----
  titlePanel("Singapore Tourism"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for variable to plot against mpg ----
      selectInput("country","Country:",
                  choices=colnames(air[3:13])),

      # 选择月份
      radioButtons("month", label = h3("Month"),
        choices = list("JAN" = "JAN", "FEB" = "FEB", "MAR" = "MAR", "APR" = "APR", "MAY" = "MAY", "JUN" = "JUN", 
                  "JUL" = "JUL", "AUG" = "AUG", "SEP" = "SEP", "OCT" = "OCT", "NOV" = "NOV", "DEC" = "DEC"), 
        selected = "JAN"),
      
      # Input: Checkbox for whether outliers should be included ----
      numericInput("obs", "Number of observations to view:", 10),actionButton("update", "Update View")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("tourPlot"),
      h4("Observations"),
      tableOutput("view")
    )
  )
))
