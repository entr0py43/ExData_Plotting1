library(data.table)
library(dplyr)
library(lubridate)

#checking for directory indicating dataset is present
if(!file.exists("./household_power_consumption.txt")){
      #proceeds if absent with download, and unzip
      temp<-tempfile("./temp.zip")
      fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl,destfile = "./temp.zip")
      unzip("./temp.zip")
      unlink("./temp.zip")
}  #creates data directories in default wd

#read in file
pwr<-fread("household_power_consumption.txt")

#convert dates to Date variable class
pwr$Date<-dmy(pwr$Date)
#filter out two dates for assignment
feb<-filter(pwr, pwr$Date %in% as.Date(c("2007-2-2","2007-2-1")))

#creating a POSIXct datetime variable
feb<-within(feb,{datetime=as.POSIXct(paste(Date, Time))})

#making variables numeric instead of char
feb$Global_active_power<-as.numeric(feb$Global_active_power)
feb$Sub_metering_1<-as.numeric(feb$Sub_metering_1)
feb$Sub_metering_2<-as.numeric(feb$Sub_metering_2)
feb$Sub_metering_3<-as.numeric(feb$Sub_metering_3)


#plot code below here
###############################################
#recreating plot 3, outputting to PNG
png(filename = "plot3.png", width=480, height=480)

plot(y = feb$Sub_metering_1,x = feb$datetime, xlab = " ", 
     ylab = "Energy sub metering", type = "n")
lines(y = feb$Sub_metering_1, x = feb$datetime, col = "black")
lines(y = feb$Sub_metering_2, x = feb$datetime, col = "red")
lines(y = feb$Sub_metering_3, x = feb$datetime, col = "blue")
legend("topright", lwd = c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()