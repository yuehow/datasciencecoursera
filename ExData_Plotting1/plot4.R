##
##ExData_Plotting1 project
##
## Plot 4 - 4 plots in a diagram

## 
## Load data -- Data had been downloaded into the working directory
## 
plot4 <- function() {
## check if the file exist
if(!file.exists('Data')) {
	dir.create('Data') 
	Url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
	download.file(Url, destfile = './Data/household_power_consumption.zip')
	unzip('./Data/household_power_consumption.zip', exdir = './Data')
}

	

# read data into R
files <- file('./Data/household_power_consumption.txt')
db <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

## open the png device
png(filename = './Plot4.png', width = 480, height = 480, units='px')

## partition the screen into 4 part 
## 
par(mfrow=c(2,2), mar=c(4,4,2,1))

## History plot to screen
## First plot
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Global_active_power), 
	 ylab="Global Active Power (kilowwatts)", xlab="", type="l")

## Second Plot
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Voltage), 
	 ylab="Voltage", xlab="datetime", type="l")
	 
## Third plot
## History plot to screen#hist(as.numeric(db$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowwatts)")
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_1), ylab="Energy sub meterting", xlab="", type="l", )
lines( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_2), ylab="Energy sub meterting", xlab="", type="l", col="red")
lines( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_3), ylab="Energy sub meterting", xlab="", type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

## Forth Plot
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Global_reactive_power), 
	 ylab="Global reactive power", xlab="datetime", type="l")


## Close the png device
dev.off()
}