# This R-script creates the plot "plot4.png" in the working directory
# It is standalone as it gets the data subsets them and makes the plot in a png file
# The first part consist of getting the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filenamezip <- "exdata_data_household_power_consumption.zip"
download.file( fileUrl, destfile = filenamezip )
unzip( filenamezip )
# Read all the data from the file
data_all <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings= "?", dec=".")
#Data subsetting, only two days are considered
data <- data_all[data_all$Date == "1/2/2007" | data_all$Date == "2/2/2007",]
# a new datetime variable is defined in the subset data
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
# The complete data are removed from memory, they are no longer needed
rm(data_all)
# The plotting part
# (the x axis locale is in Spanish)
png(file="plot4.png", width = 480, height = 480)
# This plot consists of 4 plots
par(mfrow = c( 2, 2))
#Plot 1
with (data, plot(datetime, Global_active_power, type= "l", ylab="", xlab=""))
title( ylab="Global Active Power" )
#Plot 2
with (data, plot(datetime, Voltage, type= "l", ylab="", xlab=""))
title( ylab="Voltage" , xlab = "datetime" )
#Plot 3
with (data, plot(datetime, Sub_metering_1, type= "l", ylab="", xlab=""))
title( ylab="Energy sub metering" )
with (data, lines(datetime, Sub_metering_2, col="red"))
with (data, lines(datetime, Sub_metering_3, col="blue"))
#Plot 4
with (data, plot(datetime, Global_reactive_power, type= "l", ylab="", xlab=""))
title( ylab="Global_reactive_power" , xlab = "datetime" )

dev.off()