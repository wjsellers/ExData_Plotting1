# William Sellers - October 12, 2014
# Coursera - Exploratory Data Analysis
# Course Project 1


# set working directory
setwd("~/Repos/ExData_Plotting1")


# read in data for 2007-02-01 and 2007-02-02 using sqldf package
# original data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
library(sqldf)
day1 <- read.csv.sql("~/Documents/Data/Coursera/Exploratory Data Analysis/CourseProject1/household_power_consumption.txt", 
                     sql = 'select * from file where Date == "1/2/2007"', 
                     sep=";", stringsAsFactors=FALSE)
day2 <- read.csv.sql("~/Documents/Data/Coursera/Exploratory Data Analysis/CourseProject1/household_power_consumption.txt", 
                     sql = 'select * from file where Date == "2/2/2007"', 
                     sep=";", stringsAsFactors=FALSE)
plotdata <- rbind(day1,day2)


# create column merging date and time
plotdata$DateTime <- paste(plotdata$Date,plotdata$Time)
plotdata$DateTime <- strptime(plotdata$DateTime, "%d/%m/%Y %H:%M:%S")


# create png of plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(plotdata$DateTime, plotdata$Sub_metering_1, type="n",
     xlab="", ylab = "Energy sub metering")
points(plotdata$DateTime, plotdata$Sub_metering_1, type="l")
points(plotdata$DateTime, plotdata$Sub_metering_2, type="l", col="red")
points(plotdata$DateTime, plotdata$Sub_metering_3, type="l", col="blue")
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=1)
dev.off()

