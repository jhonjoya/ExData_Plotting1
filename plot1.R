householdPowerConsumption <- read.table("household_power_consumption.txt", header = T, sep = ";")

householdPowerConsumption$Date <- paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep = " ")
householdPowerConsumption <- householdPowerConsumption[,!(names(householdPowerConsumption) %in% c("Time"))]

householdPowerConsumption$Date <- strptime(householdPowerConsumption$Date, format = "%d/%m/%Y %H:%M:%S")

numericList <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

for(title in numericList){
      householdPowerConsumption[,title] <- as.numeric(householdPowerConsumption[,title])
}

date1 <- strptime("2007-02-01", "%Y-%m-%d")
date2 <- strptime("2007-02-02", "%Y-%m-%d")
subsetDate <- householdPowerConsumption[householdPowerConsumption$Date >= date1 & householdPowerConsumption$Date <= date2,]

hist(subsetDate$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.copy(png, file = "plo1.png", width=480, height=480)
dev.off()