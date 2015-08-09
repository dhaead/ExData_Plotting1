
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
dsn<-dmy_hms(sn)

png('plot3.png',480,480)

par(mfrow=c(1,1), mar=c(3.5,4,3.5,1.5), oma=c(0,0,0,0),cex.lab=0.9,cex.axis=0.9)



sub1<-newdata$Sub_metering_1
plot(dsn,sub1,col="black",type="l",pch="l",xlab = "",ylab = "Energy Sub Metering")

sub2<-newdata$Sub_metering_2
sub2<-as.numeric(sub2)
lines(dsn,sub2,col="red",type="l",pch="l")


sub3<-newdata$Sub_metering_3
lines(dsn,sub3,col="blue",type = "l",pch="l")
par(lab=c(3,3,7))

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,horiz=FALSE,col = c("black","red","blue"),lty=c(1,1),cex=0.9)

dev.off()