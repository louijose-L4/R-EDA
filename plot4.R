power_src <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
power_src$Date <- as.Date(power_src$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
power_src <- subset(power_src,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))



## Combine Date and Time column
dateTime<- paste(power_src$Date, power_src$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")



power_src <- cbind(dateTime, power_src)

## Format dateTime Column
power_src$dateTime <- as.POSIXct(dateTime)

par(mfrow=c(2,2),mar=c(2,2,0.5,0.5),oma=c(0,0,2,0))

with(power_src, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
