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


## Create plot and save as png
png("plot2.png")
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()