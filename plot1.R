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

png(filename= "plot1.png",width=480, height=480)     #Save it to a png file
hist(DT[,V3],main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency", col= "red")
dev.off()
