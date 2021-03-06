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
    if(!is.null(input$year1)){
      return(filter(air, Year == input$year1))
      # return(subset(air, Month == input$month))
    }

    return(air)
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
          "USA"  =  {aesthetics1 = aes(x = Month,y = USA)},
          "Indonesia"  =  {aesthetics1 = aes(x = Month,y = Indonesia)},
          "Malaysia"  =  {aesthetics1 = aes(x = Month,y = Malaysia)},
          "Philippines"  =  {aesthetics1 = aes(x = Month,y = Philippines)},
          "Thailand"  =  {aesthetics1 = aes(x = Month,y = Thailand)},
          "Japan"  =  {aesthetics1 = aes(x = Month,y = Japan)},
          "China"  =  {aesthetics1 = aes(x = Month,y = China)},
          "Korea"  =  {aesthetics1 = aes(x = Month,y = Korea)},
          "India"  =  {aesthetics1 = aes(x = Month,y = India)},
          "UK"  =  {aesthetics1 = aes(x = Month,y = UK)},
          "Australia"  =  {aesthetics1 = aes(x = Month,y = USA)},
    )
    # info <- subset(air, as.Date(Year) > as.Date("2014-01-01"))

    # arrange y[order(y[,3]),]
    # result <- filter(air, Year == input$year1)
    # result <- result[order(result[,3]),]
    # if(!is.null(input$order1)){
    #   if(input$order1=="asc"){
    #     result <- arrange(selectedData(),USA) #将survived从小到大排序  
    #   }else if(input$order1=="desc"){
    #     result <- arrange(selectedData(),desc(input$country)) #将survived从大到小排序 
    #   }
    # }
    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    # aes(Year,y=USA,group=Month,fill=Month)
    ggplot(selectedData(),aesthetics1)+geom_bar(stat='identity',position='dodge')+
        scale_x_discrete(limits=c("JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"))+
        ggtitle(paste("Tourists ~", input$country))+ylab("Number Reported")+theme_wsj()+scale_fill_wsj()
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
  })

  output$view <- renderTable({
    selectedData()
    # head(datasetInput(), n = isolate(input$obs))
  })

  # START B
  selectedDataB <- reactive({
    # 跟据多选框的国家，筛选除特定国家的数据
    return(filter(total, Country %in% input$country2))
  })
 
  
  output$viewB <- renderTable({
    # 显示根据条件筛选后的数据
    selectedDataB()
    # head(datasetInput(), n = isolate(input$obs))
  })

  # 汇总图
  output$tourPlotTotalB <- renderPlot({
    # 根据选择的月份显示该月份列的数据
    switch(input$month2,
          "Total"  =  {aesthetics2 = aes(x = YEAR,y = Total,group=Country,fill=Country,colour=Country)},
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
    p <- ggplot(selectedDataB(),aesthetics2)+geom_line()+geom_point()+
        ylab("Number Reported")+ggtitle(paste("Tourists ~",input$month2, "Reports"))
    
    return(p)
  })

  # 多个图
  output$tourPlotB <- renderPlot({
    # Depending on whether the "Cumulative" checkbox is checked, set plot aesthetics to either weekly or cumulative counts
    switch(input$month2,
          "Total"  =  {aesthetics2 = aes(x = YEAR,y = Total,group=Country,fill=Country)},
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
    p <- ggplot(selectedDataB(),aesthetics2)+geom_line()+geom_point()+
        ylab("Number Reported")+ggtitle(paste("Tourists ~",input$month2, "Reports"))
    
    return(p + facet_wrap(~ Country, scales='free'))
    
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
  })
  # END B 

  # START C
  selectedDataC <- reactive({
    # 跟据多选框的国家，筛选除特定国家的数据
    # return(total)
    return(filter(total, Country %in% input$country3, YEAR %in% input$year3))
  })
 
  # 汇总图
  output$tourPlotTotalC <- renderPlot({

    p <- ggplot(selectedDataC(),aes(x = YEAR,y = Pct_Change,group=Country,fill=Country,colour=Country))+geom_line()+geom_point()+
        ylab("Pct_Change Reported")+ggtitle(paste("Tourists ~ Pct_Change", "Reports"))
    
    return(p)
  })

  # 多个图
  output$tourPlotC <- renderPlot({
    # USA, Indonesia,Malaysia,Philippines,Thailand,Japan,China,Korea,India,UK,Australia
    # aes(Year,y=USA,group=Month,fill=Month)
    p <- ggplot(selectedDataC(),aes(x = YEAR,y = Pct_Change,group=Country,fill=Country))+geom_line()+geom_point()+
        ylab("Pct_Change Reported")+ggtitle(paste("Tourists ~ Pct_Change", "Reports"))
    
    return(p + facet_wrap(~ Country, scales='free'))
    
    # ggplot(data=mydata, aes(x=Year, y=input$country, group=1),stat="identity") 
  })
  # END C 
  
})
