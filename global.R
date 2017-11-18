library(shiny)
library(stringr)
library(dplyr)
library(scales)
library(grid)
library(ggplot2)
# 图标主题
library(ggthemes)

air<-read.csv("./data/arrival_air.csv",header = TRUE,sep=",")

# 读取数据
data_2007<-read.csv("./data/all-07.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2008<-read.csv("./data/all-08.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2009<-read.csv("./data/all-09.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2010<-read.csv("./data/all-10.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2011<-read.csv("./data/all-11.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2012<-read.csv("./data/all-12.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2013<-read.csv("./data/all-13.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2014<-read.csv("./data/all-14.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2015<-read.csv("./data/all-15.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)
data_2016<-read.csv("./data/all-16.csv",header = TRUE,sep=",",stringsAsFactors=FALSE)

data_2007$YEAR <- '2007'
data_2008$YEAR <- '2008'
data_2009$YEAR <- '2009'
data_2010$YEAR <- '2010'
data_2011$YEAR <- '2011'
data_2012$YEAR <- '2012'
data_2013$YEAR <- '2013'
data_2014$YEAR <- '2014'
data_2015$YEAR <- '2015'
data_2016$YEAR <- '2016'

# 重命名列
COLNAME <- c("Country","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG",
            "SEP","OCT","NOV","DEC","Total","Pct_Change","YEAR")
names(data_2007) <- COLNAME
names(data_2008) <- COLNAME
names(data_2009) <- COLNAME
names(data_2010) <- COLNAME
names(data_2011) <- COLNAME
names(data_2012) <- COLNAME
names(data_2013) <- COLNAME
names(data_2014) <- COLNAME
names(data_2015) <- COLNAME
names(data_2016) <- COLNAME

# 同一命名
total <- rbind(data_2007,data_2008,data_2009,data_2010,data_2011,data_2012,data_2014,data_2015,data_2016)
# 去掉空格
total$Country = str_trim(total$Country)
total$Country[total$Country == 'P R China'] = 'China'

total$JAN = as.numeric(gsub(",","", total$JAN))
total$FEB = as.numeric(gsub(",","", total$FEB))
total$MAR = as.numeric(gsub(",","", total$MAR))
total$APR = as.numeric(gsub(",","", total$APR))
total$MAY = as.numeric(gsub(",","", total$MAY))
total$JUN = as.numeric(gsub(",","", total$JUN))
total$JUL = as.numeric(gsub(",","", total$JUL))
total$SEP = as.numeric(gsub(",","", total$SEP))
total$OCT = as.numeric(gsub(",","", total$OCT))
total$NOV = as.numeric(gsub(",","", total$NOV))
total$DEC = as.numeric(gsub(",","", total$DEC))
total$Total = as.numeric(gsub(",","", total$Total))
total$Pct_Change = as.numeric(gsub(",","", total$Pct_Change))

# 因为命名不统一，现在统一改成大写字母
air$Month <- toupper(air$Month)
air$Month <- as.factor(air$Mont)