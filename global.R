air<-read.csv("./arrival_air.csv",header = TRUE,sep=",")

# 因为命名不统一，现在统一改成大写字母
air$Month <- toupper(air$Month)