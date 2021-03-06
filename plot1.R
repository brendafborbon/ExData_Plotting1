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

