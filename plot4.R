# Exploratory Data Analysis Project #1
# Plot 4

# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
#
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#        
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
#
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
#
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
#
# Note that in this dataset missing values are coded as ?.

library(data.table)
library(datasets)

# read in data and filter to desired dates
fullTable <- fread("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
filteredTable <- subset(fullTable, (fullTable$Date == "2/2/2007" | fullTable$Date == "1/2/2007"))

# Set columns to correct types
filteredTable$Date <- as.IDate(filteredTable$Date, format = "%d/%m/%Y")
filteredTable$Time <- as.ITime(filteredTable$Time, format = "%H:%M:%S")
filteredTable$Global_active_power <- as.numeric(filteredTable$Global_active_power)
filteredTable$Global_reactive_power <- as.numeric(filteredTable$Global_reactive_power)
filteredTable$Voltage <- as.numeric(filteredTable$Voltage)
filteredTable$Global_intensity <- as.numeric(filteredTable$Global_intensity)
filteredTable$Sub_metering_1 <- as.numeric(filteredTable$Sub_metering_1)
filteredTable$Sub_metering_2 <- as.numeric(filteredTable$Sub_metering_2)
filteredTable$Sub_metering_3 <- as.numeric(filteredTable$Sub_metering_3)

# data.table cannot handle POSIxct, so convert for use in plots
# converting back as.POSIXct(filteredTable$Date, time = filteredTable$Time)


# plot 4
# four mini-graphs in one frame
# top left - plot #2
# top right - voltage v date time (black line graph)
# bottom left - plot #3
# bottom right -  global reactive power vs datetime (black line graph)

png("plot4.png", 480, 480)

# set up the 2x2 plot area
par(mfrow = c(2,2))

# plot all the graphs
with(filteredTable, {
        # top left 
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        
        # top right
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Voltage , type = "l", xlab = "datetime", ylab = "Voltage")
        
        # bottom left
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Sub_metering_1, ylim = range(filteredTable$Sub_metering_1), type = "l", xlab = "", ylab = "Energy sub metering")
        par(new = TRUE)
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Sub_metering_2, ylim = range(filteredTable$Sub_metering_1), type = "l", col = "red", xlab = "", ylab = "Energy sub metering")
        par(new = TRUE)
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Sub_metering_3, ylim = range(filteredTable$Sub_metering_1), type = "l", col = "blue", xlab = "", ylab = "Energy sub metering")
        legend("topright", lty = "solid", bty = "n",  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        # bottom right
        plot(as.POSIXct(filteredTable$Date, time = filteredTable$Time),filteredTable$Global_reactive_power , type = "l", xlab = "datetime", ylab = "Global_reactive_power")
        
})
dev.off()






