
library(dplyr)
library(lubridate)

data<-read.csv("household_power_consumption.txt",sep = ";",nrows = 550000,na.strings = "?")

da<-as.Date(dmy(data$Date))

data<-mutate(data,Date=da)

newdata1<-filter(data,Date == "2007-02-01")
newdata2<-filter(data,Date == "2007-02-02")
newdata<-rbind(newdata1,newdata2)


wnda<-wday(newdata$Date)
tim<-strptime(newdata$Time,format = "")
x=paste(newdata$Date,newdata$Time)
sn<-strftime(x,format = "%d %m %y %T",tz="HST",usetz=FALSE)

png('plot2.png',480,480)


par(mfrow=c(1,1), mar=c(3.5,4,3.5,1.5), oma=c(0,0,0,0),cex.lab=1,cex.axis=1)
plot(dmy_hms(sn),as.numeric(newdata$Global_active_power),type = "l",xlab = "",ylab = "Global Active Power (Kilowatts)")

dev.off()