##Download and read the data
temp <- tempfile()
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,temp,method="curl")
data <- read.table(unz(temp,"household_power_consumption.txt"), sep=";",nrows=2880,skip=66637)
unlink(temp)

##Conver the data.frame into data.table and plot it
library(data.table)
DT <- data.table(data)
date_time <- paste(DT[,V1],DT[,V2])
DT[,V2:=as.numeric(as.POSIXct(strptime(date_time,'%d/%m/%Y %H:%M:%S')))] #Convert to second
DT[,V1:=weekdays(as.Date(DT[,V1],'%d/%m/%Y'))]   #Convert the date into weekdays

png(filename= "plot3.png",width=480, height=480)     #Save it to a png file
plot(DT[,V2],DT[,V7],xaxt = "n",type="n",xlab="",ylab="Energy sub metering")
points(DT[,V2],DT[,V7],type="l",lty=1, col="black")
points(DT[,V2],DT[,V8],type="l",lty=1, col="red")
points(DT[,V2],DT[,V9],type="l",lty=1, col="blue")
axis(1,at=c(1170313200,1170399570,1170485940),labels=c("Thu","Fri", "Sat"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
