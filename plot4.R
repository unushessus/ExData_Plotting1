## Read the data from February 1st and 2nd, 2007
data <- read.csv("household_power_consumption.txt", sep = ";", header = F,
                 col.names = c("Date", "Time", "Global_active_power",
                               "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1",
                               "Sub_metering_2", "Sub_metering_3"),
                 skip = 66637, nrows = 2880)

## Re-format dates and times in a new variable DateTime of class POSIXlt
library(tidyr)
data<-unite(data, DateTime, Date, Time, sep = "_", remove = TRUE)
data$DateTime<-strptime(data$DateTime, format = "%d/%m/%Y_%H:%M:%S")


## Create plots and save as png
png("plot4.png")
par(mfcol = c(2,2), pin = c(1.7, 1.25), mar = c(4,4,4,2))

plot(data$DateTime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

plot(data$DateTime, data$Sub_metering_1, type = "n", xlab="",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", cex = 0.7)

plot(data$DateTime, data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

plot(data$DateTime, data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
