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
shinyUI(navbarPage("TITLE",
    tabPanel("A TAB",
          # App title ----
          titlePanel("Singapore Tourism"),
          # Sidebar layout with input and output definitions ----
          column(4, wellPanel( 
              # Input: Selector for variable to plot against mpg ----
              selectInput("country","Country:",
                          choices=colnames(air[3:13])),

              # 选择年份
              radioButtons("year1", label = h3("Month"),
                choices = list("2007" = "2007", "2008" = "2008", "2009" = "2009", "2010" = "2010", 
                          "2011" = "2011", "2012" = "2012", "2013" = "2013", "2014" = "2014", 
                          "2015" = "2015", "2016" = "2016"), 
                selected = "2016")

            )
          ),
          column(8, 
            # Output: Formatted text for caption ----
            h3(textOutput("caption")),
            # Output: Plot of the requested variable against mpg ----
            plotOutput("tourPlot"),
            h4("Observations"),
            tableOutput("view")
          )
    ),

    tabPanel("A TAB",
          # App title ----
          titlePanel("Singapore Tourism"),
          # Sidebar layout with input and output definitions ----
          column(3, wellPanel( 
              # 选择国家
              checkboxGroupInput("country2", label = h3("Country"), 
                choices = list("Australia" = "Australia","China" = "China","Hong Kong SAR" = "Hong Kong SAR","India" = "India",
                              "Indonesia" = "Indonesia","Japan" = "Japan","Malaysia" = "Malaysia","Philippines" = "Philippines","South Korea" = "South Korea",
                              "Taiwan" = "Taiwan","Thailand" = "Thailand","UK" = "UK","USA" = "USA","Vietnam" = "Vietnam"),
                selected = c('Australia',"China","Hong Kong SAR","India")),
              # 选择月份
              radioButtons("month2", label = h3("Month"),
                choices = list("Total" = "Total","JAN" = "JAN", "FEB" = "FEB", "MAR" = "MAR", "APR" = "APR", "MAY" = "MAY", "JUN" = "JUN", 
                          "JUL" = "JUL", "AUG" = "AUG", "SEP" = "SEP", "OCT" = "OCT", "NOV" = "NOV", "DEC" = "DEC"), 
                selected = "Total")
            )
          ),
          column(9, 
            plotOutput("tourPlotTotalB"),
            plotOutput("tourPlotB"),
            tableOutput("viewB")
          )
    ),

    tabPanel("Pct_Change",
          # App title ----
          titlePanel("Singapore Tourism Pct_Change"),
          # Sidebar layout with input and output definitions ----
          column(3, wellPanel( 
              # 选择国家
              checkboxGroupInput("country3", label = h3("Country"), 
                choices = list("Australia" = "Australia","China" = "China","Hong Kong SAR" = "Hong Kong SAR","India" = "India",
                              "Indonesia" = "Indonesia","Japan" = "Japan","Malaysia" = "Malaysia","Philippines" = "Philippines","South Korea" = "South Korea",
                              "Taiwan" = "Taiwan","Thailand" = "Thailand","UK" = "UK","USA" = "USA","Vietnam" = "Vietnam"),
                selected = c('Australia',"China","Hong Kong SAR","India")),

              # 选择年份
              checkboxGroupInput("year3", label = h3("Month"),
                choices = list("2007" = "2007", "2008" = "2008", "2009" = "2009", "2010" = "2010", 
                          "2011" = "2011", "2012" = "2012", "2013" = "2013", "2014" = "2014", 
                          "2015" = "2015", "2016" = "2016"), 
                selected = c("2007","2008","2009","2009","2010","2010","2011","2012","2013","2014","2015","2016"))
            )
          ),

          column(9, 
            plotOutput("tourPlotTotalC"),
            plotOutput("tourPlotC"),
            tableOutput("viewC")
          )
    )

))
