require(lubridate)
require(data.table)

## Load Data using fread
epc <- fread("data\\household_power_consumption.txt")

## Create DateTime column
epc$DateTime <- dmy_hms(paste(epc$Date, epc$Time))

## Convert Date column to Date type
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")

## Create data table for 2/1/07 and 2/2/07 observations only
dtEpc <- subset(epc, Date == "2007-02-01" | Date == "2007-02-02")
dtEpc$Global_active_power <- as.numeric(dtEpc$Global_active_power)

## Remove 2+ million row table now that target rows are in their own table
rm(epc)

## Construct Gloable Global Active Power vs Frequency plot
par(mar = c(4.1,4.1,3.1,2.1))
png(filename = "plot1.png", width = 480, height = 480)
hist(dtEpc$Global_active_power, col="Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
