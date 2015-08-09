
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


png('plot4.png',480,480)

#par(mar=c(0,0,3,3))
par(cex.lab=.9)
par(cex.axis=.9)
#par(mfrow=c(2,2))
#par(omi=c(.1,.2,.1,.2))
#par(oma=c(1,1,.1,.1))
par(mfrow=c(2,2), mar=c(4,4,3,.5), oma=c(0,0,0,1))


wnda<-wday(newdata$Date)
tim<-strptime(newdata$Time,format = "")
x=paste(newdata$Date,newdata$Time)
sn<-strftime(x,format = "%d %m %y %T",tz="HST",usetz=FALSE)

plot(dmy_hms(sn),as.numeric(newdata$Global_active_power),ylab = "Global Active Power",xlab="",type = "l",pch="l")

#par(mai=c(1,1,1,1))

datetime<-dmy_hms(sn)
Voltage<-as.numeric(newdata$Voltage)

yrange=c(234,246)
par(cex.axis=.7)
ticks <- pretty(yrange)
labels <- format(ticks, scientific=FALSE)

plot(datetime,Voltage,type = "l")
axis(2, at = ticks, labels = labels, las = 0)#, cex.axis=0.7)



sub1<-newdata$Sub_metering_1
plot(dmy_hms(sn),sub1,col="black",type="l",pch="l",xlab = "",ylab = "Energy Sub Metering")

#par(mai=c(1,1,1,1))

sub2<-newdata$Sub_metering_2
sub2<-as.numeric(sub2)
lines(dmy_hms(sn),sub2,col="red",type="l",pch="l")


sub3<-newdata$Sub_metering_3
lines(dmy_hms(sn),sub3,col="blue",type = "l",pch="l")
par(lab=c(3,3,7))

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,horiz=FALSE,bty = "n",col = c("black","red","blue"),lty=c(1,1),cex=0.9)


datetime<-dmy_hms(sn)
reac<-as.numeric(newdata$Global_reactive_power)

yrange=c(0,0.5)
par(cex.axis=.9)
ticks <- pretty(yrange)
labels <- format(ticks, scientific=FALSE)


plot(datetime,reac,type = "l",ylab="Global_Reactive_Power",yaxt="n")
axis(2, at = ticks, labels = labels, las = 0)#, cex.axis=0.7)


dev.off()