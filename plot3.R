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

plot(x = subsetDate$Date, y = subsetDate$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n")
axis.POSIXct(1, at = seq(subsetDate$Date[1], subsetDate$Date[length(subsetDate$Date)], by = "day"), format = "%a")
lines(x = subsetDate$Date, y = subsetDate$Sub_metering_2, col = "red")
lines(x = subsetDate$Date, y = subsetDate$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.8)


dev.copy(png, file = "plo3.png")
dev.off()
