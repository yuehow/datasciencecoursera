##
##ExData_Plotting1 project
##
## Plot 3 - Plot Energy Sub metering data against Date & Time

## 
## Load data -- Data had been downloaded into the working directory
## 
plot3 <- function() {
## Check if the file exists
if(!file.exists('Data')) {
	dir.create('Data') 
	Url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
	download.file(Url, destfile = './Data/household_power_consumption.zip')
	unzip('./Data/household_power_consumption.zip', exdir = './Data')
}

## loading data into DB	and
## extract 1/2/2007 and 2/2/2007 data (2007/02/01 - 2007/02/02) to work on
files <- file('./Data/household_power_consumption.txt')
db <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

## open png device
png(filename = './Plot3.png', width = 480, height = 480, units='px')

## History plot to screen#hist(as.numeric(db$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowwatts)")
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_1), ylab="Energy sub meterting", xlab="", type="l", )
lines( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_2), ylab="Energy sub meterting", xlab="", type="l", col="red")
lines( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Sub_metering_3), ylab="Energy sub meterting", xlab="", type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

## close the png device
dev.off()
}