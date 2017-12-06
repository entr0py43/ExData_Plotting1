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

#making this variable numeric instead of char
feb$Global_active_power<-as.numeric(feb$Global_active_power)

#plot code below here
###############################################
#recreating plot 1, outputting to PNG
png(filename = "plot1.png", width=480, height=480)

hist(feb$Global_active_power, 
      col="red", 
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)"
      )

#closing graphics device
dev.off()