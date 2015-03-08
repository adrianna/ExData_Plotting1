#################################
##
## Exploratory Data Analysis
## File: plot1.R
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
#png(file="plot1.png", width=480, height=480, bg="transparent")

# Plot Histogram of Global active power
par(cex=0.9, bg=NA)
hist(data_2007$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()
