#################################
##
## Exploratory Data Analysis
## File: plot3.R
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

# Extract to local directory
unzip(paste(zipdir, zipfile, sep="/"), exdir="./")

# List File
unzipfile <- list.files(pattern=".txt")

# Data being chunked in... 
data_2007 <- subset(read.csv(unzipfile, header=T, sep=";", na.strings="?"), 
                    (grepl("^[12]{1}\\/2\\/2007", Date) ))

write.csv(data_2007, "test_data2007.txt", row.names=F, quote=F)
# Create new column Times - Date/Time \s[pace] separated as POSIXct

data_2007$Times <- as.POSIXct(strptime(paste(data_2007$Date, data_2007$Time), "%d/%m/%Y %H:%M:%S"))

# Print to png file
png(file="plot2.png", width=480, height=480, bg="transparent")

# Overlay multiple plots in one graph
par(mar=c(2,4,3,2), cex=0.75, bg=NA)
with(data_2007, plot.window(xlim=range(Times), ylim=c(0,35) ))
with(data_2007, plot(Times, Sub_metering_1, ylab="Energy Sub Metering", xlab="", yaxt= "n", type="n", ylim=c(0,40)))
with(data_2007, lines(Times, Sub_metering_1, type="l", col="black"))
#with(d07, lines(Times, Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="", col="black"))
axis(2, c(0,10,20,30))
with(data_2007, lines(Times, Sub_metering_2, type="l", col="red"))
with(data_2007, lines(Times, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.7
)

dev.off()
