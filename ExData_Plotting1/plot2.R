##
##ExData_Plotting1 project
##
## Plot 2 - plot of Global Active Power against Date &T ime

## 
## Load data -- Data had been downloaded into the working directory
## 
plot2 <- function() {
## Check if the file exists
if(!file.exists('Data')) {
	dir.create('Data') 
	Url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
	download.file(Url, destfile = './Data/household_power_consumption.zip')
	unzip('./Data/household_power_consumption.zip', exdir = './Data')
}

	
## loading data into DB	and
## extract 1/2/2007 and 2/2/2007 data (2007/02/01 - 2007/02/02) to work on
# read data into R
files <- file('./Data/household_power_consumption.txt')
db <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

## open png device
png(filename = './Plot2.png', width = 480, height = 480, units='px')

##plot to screen
plot( strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S"),as.numeric(db$Global_active_power), 
	 ylab="Global Active Power (kilowwatts)", xlab="", type="l")

## Close the png device
dev.off()
}