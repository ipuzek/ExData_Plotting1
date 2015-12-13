### exdata project blah ###   rm(list=ls()[!grepl('^power',ls())]) #removing all except grep pattern (beginning with "data")

library(lubridate)
library(dplyr)
# read in data # # We will only be using data from the dates 2007-02-01 and 2007-02-02
# Note that in this dataset missing values are coded as ?.

temp <- read.csv2(file = "data/household_power_consumption.txt", na.strings = "?", dec = ".")
temp$lubri <- dmy_hms(paste(temp$Date, temp$Time))   #  lubridating dates/times
power <- filter(temp, lubri >= "2007-02-01 01:00:00 UTC" & lubri <= "2007-02-03 00:59:00 UTC") # filter is odd, because of my timezone

#summary(power$lubri) #summary(power$Global_active_power) # str(power)
### SREĐENI DATUMI - PROBLEM JE BIO U VREMENSKOJ ZONI - VIDI ČUDNI FILTER #


# plot 1 = global active power
png(file = "ExData_Plotting1/plot1.png")
hist(power$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()




# plot 2 = global active power (y axis) by date - line
png(file = "ExData_Plotting1/plot2.png")
plot(power$lubri, power$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()

# plot 3 = global active power (y axis) by date - line
png(file = "ExData_Plotting1/plot3.png")

plot(power$lubri, power$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy Sub Metering")

lines(power$lubri, power$Sub_metering_2, 
      type = "l",
      col = "red")

lines(power$lubri, power$Sub_metering_3, 
      type = "l",
      col = "blue")

legend("topright", legend = names(power[7:9]), lwd = 1, col = c("black", "red", "blue"))
dev.off()


# plot 4 - grid "
png(file = "ExData_Plotting1/plot4.png")
par(mfrow = c(2, 2)) # start with defining grid #
# 1
plot(power$lubri, power$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# 2
plot(power$lubri, power$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# 3
plot(power$lubri, power$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy Sub Metering")

lines(power$lubri, power$Sub_metering_2, 
      type = "l",
      col = "red")

lines(power$lubri, power$Sub_metering_3, 
      type = "l",
      col = "blue")

legend("topright", legend = names(power[7:9]), lwd = 1, col = c("black", "red", "blue"))

# 4
plot(power$lubri, power$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
