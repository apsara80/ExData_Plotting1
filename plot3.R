# download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (url, destfile = "data.zip", method="curl")
temp <- "./data.zip"
unzip(temp, overwrite=TRUE)

# read in data
data <- read.table(file="./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

#recognize date and time 
data$Date <- as.Date (data$Date, "%d/%m/%Y")
library(chron)
data$Time <- times (as.character(data$Time))
data$datetime <- as.POSIXct (paste (data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# subset data
plotdata <- subset (data, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))

# change factor variables to numeric 
cols <- 3:9
plotdata[cols] = as.numeric (unlist (plotdata[cols]))

# plot energy sub-metering by day
png ("plot3.png", width=480, height=480, units="px")
plot (plotdata$datetime, plotdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab=" ")
        lines (plotdata$datetime, plotdata$Sub_metering_2, type="l", col="red")
        lines (plotdata$datetime, plotdata$Sub_metering_3, type="l", col="blue")
        legend ("topright", colnames(plotdata[7:9]), col=c("black", "red", "blue"), lty=1, xpd=TRUE)
dev.off()
