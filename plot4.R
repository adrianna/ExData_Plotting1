#################################
##
## Exploratory Data Analysis
## File: plot4.R
## March 2015
##              
################################

library(dplyr)

# Set Directory to local (project) directory
setwd("~/School/coursera/ExploratoryDataAnalysis/project/wk1")

# Data for Household Power Consumption is found at: 
# URL: http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Compressed File: "household_power_consumption.zip"
# Extracted  File: "household_power_consumption.txt"

fileURL  <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile  <- "household_power_consumption.zip"

# Create Temporary directory for file extraction and Extract data into local directory
zipdir   <- tempfile() 
dir.create(zipdir)
download.file(fileURL, destfile=paste(zipdir, zipfile, sep="/"), method="curl")

# Extract to local directory and delete temp directory
unzip(paste(zipdir, zipfile, sep="/"), exdir="./")
unlink(zipdir)

# List File
unzipfile <- list.files(pattern="household_power_consumption.txt")

# Data being chunked in... 
data_2007 <- subset(read.csv(unzipfile, header=T, sep=";", na.strings="?"), 
                    (grepl("^[12]{1}\\/2\\/2007", Date) ))

# Write data to table - to check subsetting
#write.csv(data_2007, "test_data2007.txt", row.names=F, quote=F)

# Create new column Times - Date/Time \s[pace] separated as POSIXct
data_2007$Times <- as.POSIXct(strptime(paste(data_2007$Date, data_2007$Time), "%d/%m/%Y %H:%M:%S"))

# Print to png file
#png(file="plot4.png", width=480, height=480, bg="transparent")

# Plot Multiple graphs in Lattice
par(mfrow=c(2,2), mar=c(4,4,2,1), cex=0.75, bg=NA)
with(data_2007, {
  plot(Times, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(Times, Voltage, ylab="Voltage", type="l", xlab="datetime")
  plot(Times, Sub_metering_1, yaxt= "n", type="n", ylim=c(0,40), ylab="Energy Sub Metering", xlab="")
  lines(Times, Sub_metering_1, type="l")
  axis(2, c(0,10,20,30))
  lines(Times, Sub_metering_2, type="l", col="red")
  lines(Times, Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         cex=0.8, bty = "n")
  plot(Times,Global_reactive_power,type="l", yaxt= "n", ylab="Global_reactive_power", xlab="datetime")
  axis(2,c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
}
)

dev.copy(png, "plot4.png", width=480, height=480, units="px")
dev.off()
