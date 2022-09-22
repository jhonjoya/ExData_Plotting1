householdPowerConsumption <- read.table("household_power_consumption.txt", header = T, sep = ";")

householdPowerConsumption$Date <- paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep = " ")
householdPowerConsumption <- householdPowerConsumption[,!(names(householdPowerConsumption) %in% c("Time"))]

householdPowerConsumption$Date <- strptime(householdPowerConsumption$Date, format = "%d/%m/%Y %H:%M:%S")

numericList <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

for(title in numericList){
      householdPowerConsumption[,title] <- as.numeric(householdPowerConsumption[,title])
}

date1 <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
date2 <- strptime("2007-02-03 00:01:00", "%Y-%m-%d %H:%M:%S")

subsetDate <- householdPowerConsumption[householdPowerConsumption$Date >= date1 & householdPowerConsumption$Date < date2,]

library(lubridate)

par(mfrow=c(2,2))


with(subsetDate,{
      ## Plot topleft
      plot(x = Date, y = Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n")
      axis.POSIXct(1, at = seq(Date[1], Date[length(Date)], by = "day"), format = "%a")
      
      ## Plot topright
      plot(x = Date, y = Voltage, xlab = "", ylab = "Voltage", type = "l", xaxt = "n")
      axis.POSIXct(1, at = seq(Date[1], Date[length(Date)], by = "day"), format = "%a")
      
      ## Plot buttonleft
      plot(x = Date, y = Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n")
      axis.POSIXct(1, at = seq(Date[1], Date[length(Date)], by = "day"), format = "%a")
      lines(x = Date, y = Sub_metering_2, col = "red")
      lines(x = Date, y = Sub_metering_3, col = "blue")
      legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.2)
      
      ## Plot buttonright
      plot(x = Date, y = Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", xaxt = "n")
      axis.POSIXct(1, at = seq(Date[1], Date[length(Date)], by = "day"), format = "%a")
})

## Create a PNG copy
dev.copy(png, file = "plo4.png")
dev.off()
