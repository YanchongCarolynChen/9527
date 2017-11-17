#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("Tourists ~", input$country)
  })
  datasetInput <- eventReactive(input$update, {
    switch(input$country,
           air)
  }, ignoreNULL = FALSE)
  
  # 
  # # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })

  # # Generate a plot of the requested variable against mpg ----
  # # and only exclude outliers if requested
   output$tourPlot <- renderPlot({
    # info <- subset(air, as.Date(Year) > as.Date("2014-01-01"))
    Jan <- subset(air, Month == 'Jan')
    ggplot(Jan,aes(Year,USA,group=Month,fill=Month))+geom_line()
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
   })
 
  
  output$view <- renderTable({
    head(datasetInput(), n = isolate(input$obs))})
  
})
