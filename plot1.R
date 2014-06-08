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

############### Step 2 - Replicate Prototype Plot1 #################

png(file="plot1.png")
hist(dt$Global_active_power, col = "red", 
     main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()
