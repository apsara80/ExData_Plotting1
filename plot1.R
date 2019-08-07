# download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (url, destfile = "data.zip", method="curl")
temp <- "./data.zip"
unzip(temp, overwrite=TRUE)

# read in data
data <- read.table(file="./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# recognize date and time 
data$Date <- as.Date (data$Date, "%d/%m/%Y")
library(chron)
data$Time <- times (as.character(data$Time))

# subset data
plotdata <- subset (data, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))

# change factor variables to numeric 
cols <- 3:9
plotdata[cols] = as.numeric (unlist (plotdata[cols]))

# create a histogram of global active power
png ("plot1.png", width=480, height=480, units="px")
hist (plotdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
