power_cons <- read.table('data/household_power_consumption.txt',sep=";",header=TRUE,na.strings="?")
power_cons$Date <- as.Date(power_cons$Date,'%d/%m/%Y')
power_cons <- subset(power_cons,Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
power_cons <- power_cons[complete.cases(power_cons),]
hist(power_cons$Global_active_power,main="Global Active Power", xlab = "Global Active Power (kilowatts)",col='red')
dev.copy(png,"plot1.png",width=480,height=480)
dev.off()
