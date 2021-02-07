setwd("~/EDA/exdata_data_household_power_consumption")
library(readr)

data <- read.csv("household_power_consumption.txt", ";", 
                                          header=TRUE, na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F
                 )

## Create column in table with date and time merged together
FullTimeDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, FullTimeDate)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

subsetdata <- subset(data, Date == "2007-02-01" | Date =="2007-02-02")

#Plot 1
png("plot1.png")

 hist(subsetdata$Global_active_power,
     main = "Global active power",
     col = 'red',
     xlab= "Global active power (kilowatts)")

dev.off()

#Plot 2
png("plot2.png")

with(subsetdata, plot(FullTimeDate, Global_active_power, type='l', xlab="",ylab= "Global active power (kilowatts)"))

dev.off()

#Plot 3
png("plot3.png")

with(subsetdata, {
  plot(FullTimeDate, Sub_metering_1,type='l', ylab= "Global active power (kilowatts)", xlab="")
  lines(FullTimeDate, Sub_metering_2,type='l', col='red')
  lines(FullTimeDate, Sub_metering_3,type='l', col='blue')
}
)
legend('topright', col=c('black', 'red', 'blue'),
       lty=1, lwd = 2,
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

dev.off()

#Plot 4
png("plot4.png")

par(mfrow=c(2,2), mar=c(4,4,2,1))
with(subsetdata, plot(FullTimeDate, Global_active_power, type='l', xlab="", ylab= "Global active power (kilowatts)"))

with(subsetdata, plot(FullTimeDate, Voltage, type='l', xlab="",ylab= "Voltage (Volt)"))

with(subsetdata, {
  plot(FullTimeDate, Sub_metering_1,type='l', ylab= "Global active power (kilowatts)", xlab="")
  lines(FullTimeDate, Sub_metering_2,type='l', col='red')
  lines(FullTimeDate, Sub_metering_3,type='l', col='blue')
}
)
legend('topright', col=c('black', 'red', 'blue'),
       lty=1, lwd = 2, bty='n',
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

with(subsetdata, plot(FullTimeDate, Global_reactive_power, type='l', ylab= "Global Reactive Power (Kilowatts"))

dev.off()

