####################### Required Files #############################

# Download and unzip the file from the following URL:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Place "household_power_consumption.txt" in the R Working Directory

############### Step 1 - read data from the input file #################

# Read the input file into R as a data frame.
# Note, a Warning message is given by colClasses argument in line 1.
# Not sure why, but ok to ignore it
dt <- read.table("household_power_consumption.txt",
                 sep=";", header=TRUE, 
                 nrows=2075259, 
                 na.strings="?", 
                 comment.char = "", 
                 colClasses = list(character=1:2,numeric=3:9),
                 stringsAsFactors = FALSE)

# Create a new data column combining date and time
dt$datetime <- paste(dt$Date, dt$Time)
dt$datetime <- strptime(dt$datetime, format = "%d/%m/%Y %H:%M:%S")

# Subset and keep data from Feb 1-2, 2007
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt <- subset(dt, Date == "2007-02-01" | Date == "2007-02-02")

############### Step 2 - Replicate Prototype Plot3 #################

png(file="plot3.png")
plot(dt$datetime, dt$Sub_metering_1,
     xlab = "", type="l",
     ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_2,
     xlab = "", type="l", col = "red",
     ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_3,
      xlab = "", type="l", col = "blue",
      ylab = "Energy sub metering")
legend("topright", inset = 0, lwd = 1, col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

