power_src <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
power_src$Date <- as.Date(power_src$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
power_src <- subset(power_src,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
power_src <- power_src[complete.cases(power_src),]

## Combine Date and Time column
dateTime <- paste(power_src$Date, power_src$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
#t <- t[ ,!(names(t) %in% c("Date","Time"))]

power_src <- cbind(dateTime, power_src)

## Format dateTime Column
power_src$dateTime <- as.POSIXct(dateTime)

with(power_src, {plot(Sub_metering_1~dateTime,type="l",ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col="red")
  lines(Sub_metering_3~dateTime,col="blue")
legend("topright",col=c("black","red","blue"),lwd=c(1,1,1),bty="n",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))})

dev.copy(png, file="plot3.png", height=480, width=480)
#dev.off()