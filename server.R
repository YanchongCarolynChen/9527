#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
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

  # We select data to plot based on which location type and location was chosen.  
  # The reactive function filters the data to return only rows from cdc data which correspond to either the state,
  # region, or country selected.  For some reason, need to put in extra error check for the "states within region" option to prevent ggplot error message 
  # 过滤条件，里面做了一些判断，如果条件不符合要求的时候，在下面output$plot1的render里面就会返回null（不输出视图）
  selectedData <- reactive({
    if(!is.null(input$month)){
      return(filter(air, Month == input$month))
      # return(subset(air, Month == input$month))
    }
  })
  
  # 
  # # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })

  # # Generate a plot of the requested variable against mpg ----
  # # and only exclude outliers if requested
   output$tourPlot <- renderPlot({
     
    # if(!is.null(input$country)){
    #   if()
      
    # }
    # info <- subset(air, as.Date(Year) > as.Date("2014-01-01"))
    
    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    ggplot(selectedData(),aes(Year,y=USA,group=Month,fill=Month))+geom_line()+geom_point()
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
   })
 
  
  output$view <- renderTable({
    head(datasetInput(), n = isolate(input$obs))
  })
  
})
