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

## Remove 2+ million row table now that target rows are in their own table
rm(epc)

## Convert character to numeric types
dtEpc$Global_active_power <- as.numeric(dtEpc$Global_active_power)
dtEpc$Sub_metering_1 <- as.numeric(dtEpc$Sub_metering_1)
dtEpc$Sub_metering_2 <- as.numeric(dtEpc$Sub_metering_2)
dtEpc$Voltage <- as.numeric(dtEpc$Voltage)


png(filename = "plot4.png", width = 480, height = 480)

## Create 2 x 2 matrix for plots 
par(mfrow = c(2,2))

## Plot 1: DateTime vs Global Active Power
with(dtEpc, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

## Plot 2: DateTime vs Voltage
with(dtEpc, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

## Plot 3: DateTime vs Sub metering
with(dtEpc, {
  plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(DateTime, Sub_metering_2, type = "l", col = "Red")
  lines(DateTime, Sub_metering_3, type = "l", col = "Blue")
})
## Add legend to the upper right corner of plot
legend("topright", bty = "n", lty = c(1,1,1), col = c("black", "blue", "red"), cex = c(1)
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Plot 4: DateTime vs Global_reactive_power
with(dtEpc, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", lwd = 1))

dev.off()