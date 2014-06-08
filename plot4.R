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

############### Step 2 - Replicate Prototype Plot4 #################

png(file="plot4.png")

# Generate four plots in 2 rows by 2 columns
par(mfrow = c(2,2))

# First plot shows Global Active Power over the two days

plot(dt$datetime, dt$Global_active_power,
     xlab = "", type="l",
     ylab = "Global Active Power")

# Second plot shows Voltage over the two days

plot(dt$datetime, dt$Voltage,type="l",
     xlab="datetime",ylab="Voltage")

# Third plot shows the three types of sub-metering over the two days

plot(dt$datetime, dt$Sub_metering_1,
     xlab = "", type="l",
     ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_2,
     xlab = "", type="l", col = "red",
     ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_3,
      xlab = "", type="l", col = "blue",
      ylab = "Energy sub metering")
legend("topright", inset = 0, lwd = 1, bty = "n", 
       col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3"))

# Fourth plot shows Global Reactive Power over the two days

plot(dt$datetime, dt$Global_reactive_power, type="l",
     xlab="datetime",ylab="Global_reactive_power")

dev.off()

