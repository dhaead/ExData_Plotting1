
library(dplyr)
library(lubridate)

data<-read.csv("household_power_consumption.txt",sep = ";",nrows = 550000,na.strings = "?")

da<-as.Date(dmy(data$Date))

data<-mutate(data,Date=da)

newdata1<-filter(data,Date == "2007-02-01")
newdata2<-filter(data,Date == "2007-02-02")
newdata<-rbind(newdata1,newdata2)
png('plot1.png',480,480)

par(mfrow=c(1,1), mar=c(4.5,4,3.5,1.5), oma=c(0,0,0,0),cex.main=1,cex.lab=0.9,cex.axis=0.9)
yrange=c(0,1200)
ticks <- pretty(yrange)
labels <- format(ticks, scientific=FALSE)
hist(as.numeric(newdata$Global_active_power),#*2.11/1000,
     col = "red",main = "Global Active Power"
     ,xlab = "Global Active Power (Kilowatts)",yaxt="n")

axis(2, at = ticks, labels = labels, las = 0)#, cex.axis=0.8)
dev.off()