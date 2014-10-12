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


# create png for plot 4
png(filename = "plot4.png", width = 480, height = 480)

# set 2x2 grid for plots
par(mfrow=c(2,2))

# top left plot
plot(plotdata$DateTime, plotdata$Global_active_power, type="l",
     xlab="", ylab = "Global Active Power")

# top right plot
plot(plotdata$DateTime, plotdata$Voltage, type="l",
     xlab="datetime", ylab = "Voltage")

# bottom left plot
plot(plotdata$DateTime, plotdata$Sub_metering_1, type="n",
     xlab="", ylab = "Energy sub metering")
points(plotdata$DateTime, plotdata$Sub_metering_1, type="l")
points(plotdata$DateTime, plotdata$Sub_metering_2, type="l", col="red")
points(plotdata$DateTime, plotdata$Sub_metering_3, type="l", col="blue")
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=1, bty = "n")

# bottom right plot
plot(plotdata$DateTime, plotdata$Global_reactive_power, type="l",
     xlab="datetime", ylab = "Global_reactive_power")

dev.off()
