#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("Tourists ~", input$country)
  })


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
    # Depending on whether the "Cumulative" checkbox is checked, set plot aesthetics to either weekly or cumulative counts
    switch(input$country,
          "USA"  =  {aesthetics1 = aes(x = Year,y = USA,group=Month,fill=Month)},
          "Indonesia"  =  {aesthetics1 = aes(x = Year,y = Indonesia,group=Month,fill=Month)},
          "Malaysia"  =  {aesthetics1 = aes(x = Year,y = Malaysia,group=Month,fill=Month)},
          "Philippines"  =  {aesthetics1 = aes(x = Year,y = Philippines,group=Month,fill=Month)},
          "Thailand"  =  {aesthetics1 = aes(x = Year,y = Thailand,group=Month,fill=Month)},
          "Japan"  =  {aesthetics1 = aes(x = Year,y = Japan,group=Month,fill=Month)},
          "China"  =  {aesthetics1 = aes(x = Year,y = China,group=Month,fill=Month)},
          "Korea"  =  {aesthetics1 = aes(x = Year,y = Korea,group=Month,fill=Month)},
          "India"  =  {aesthetics1 = aes(x = Year,y = India,group=Month,fill=Month)},
          "UK"  =  {aesthetics1 = aes(x = Year,y = UK,group=Month,fill=Month)},
          "Australia"  =  {aesthetics1 = aes(x = Australia,y = USA,group=Month,fill=Month)},
    )
    # info <- subset(air, as.Date(Year) > as.Date("2014-01-01"))
    
    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    # aes(Year,y=USA,group=Month,fill=Month)
    ggplot(selectedData(),aesthetics1)+geom_line()+geom_point()+ylab("Number Reported")
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
  })

  output$view <- renderTable({
    total
    # head(datasetInput(), n = isolate(input$obs))
  })

  # START B
  selectedDataI <- reactive({
    # 跟据多选框的国家，筛选除特定国家的数据
    return(filter(total, Country %in% input$country2))
  })
 
  
  output$viewB <- renderTable({
    # 显示根据条件筛选后的数据
    selectedDataI()
    # head(datasetInput(), n = isolate(input$obs))
  })

  # 汇总图
  output$tourPlotTotalB <- renderPlot({
    # 根据选择的月份显示该月份列的数据
    switch(input$month2,
          "JAN"  =  {aesthetics2 = aes(x = YEAR,y = JAN,group=Country,fill=Country,colour=Country)},
          "FEB"  =  {aesthetics2 = aes(x = YEAR,y = FEB,group=Country,fill=Country,colour=Country)},
          "MAR"  =  {aesthetics2 = aes(x = YEAR,y = MAR,group=Country,fill=Country,colour=Country)},
          "APR"  =  {aesthetics2 = aes(x = YEAR,y = APR,group=Country,fill=Country,colour=Country)},
          "MAY"  =  {aesthetics2 = aes(x = YEAR,y = MAY,group=Country,fill=Country,colour=Country)},
          "JUN"  =  {aesthetics2 = aes(x = YEAR,y = JUN,group=Country,fill=Country,colour=Country)},
          "JUL"  =  {aesthetics2 = aes(x = YEAR,y = JUL,group=Country,fill=Country,colour=Country)},
          "AUG"  =  {aesthetics2 = aes(x = YEAR,y = AUG,group=Country,fill=Country,colour=Country)},
          "SEP"  =  {aesthetics2 = aes(x = YEAR,y = SEP,group=Country,fill=Country,colour=Country)},
          "OCT"  =  {aesthetics2 = aes(x = YEAR,y = OCT,group=Country,fill=Country,colour=Country)},
          "NOV"  =  {aesthetics2 = aes(x = YEAR,y = NOV,group=Country,fill=Country,colour=Country)},
          "DEC"  =  {aesthetics2 = aes(x = YEAR,y = DEC,group=Country,fill=Country,colour=Country)},
    )

    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    # aes(Year,y=USA,group=Month,fill=Month)
    p <- ggplot(selectedDataI(),aesthetics2)+geom_line()+geom_point()+
        ylab("Number Reported")+ggtitle(paste("Tourists ~",input$month2, "Reports"))
    
    return(p)
  })

  # 多个图
  output$tourPlotB <- renderPlot({
    # Depending on whether the "Cumulative" checkbox is checked, set plot aesthetics to either weekly or cumulative counts
    switch(input$month2,
          "JAN"  =  {aesthetics2 = aes(x = YEAR,y = JAN,group=Country,fill=Country)},
          "FEB"  =  {aesthetics2 = aes(x = YEAR,y = FEB,group=Country,fill=Country)},
          "MAR"  =  {aesthetics2 = aes(x = YEAR,y = MAR,group=Country,fill=Country)},
          "APR"  =  {aesthetics2 = aes(x = YEAR,y = APR,group=Country,fill=Country)},
          "MAY"  =  {aesthetics2 = aes(x = YEAR,y = MAY,group=Country,fill=Country)},
          "JUN"  =  {aesthetics2 = aes(x = YEAR,y = JUN,group=Country,fill=Country)},
          "JUL"  =  {aesthetics2 = aes(x = YEAR,y = JUL,group=Country,fill=Country)},
          "AUG"  =  {aesthetics2 = aes(x = YEAR,y = AUG,group=Country,fill=Country)},
          "SEP"  =  {aesthetics2 = aes(x = YEAR,y = SEP,group=Country,fill=Country)},
          "OCT"  =  {aesthetics2 = aes(x = YEAR,y = OCT,group=Country,fill=Country)},
          "NOV"  =  {aesthetics2 = aes(x = YEAR,y = NOV,group=Country,fill=Country)},
          "DEC"  =  {aesthetics2 = aes(x = YEAR,y = DEC,group=Country,fill=Country)},
    )
    # info <- subset(air, as.Date(Year) > as.Date("2014-01-01"))
    
    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    # aes(Year,y=USA,group=Month,fill=Month)
    p <- ggplot(selectedDataI(),aesthetics2)+geom_line()+geom_point()+
        ylab("Number Reported")+ggtitle(paste("Tourists ~",input$month2, "Reports"))
    
    return(p + facet_wrap(~ Country, scales='free'))
    
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
  })

  # END B 
  
})
