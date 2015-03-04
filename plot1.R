library(dplyr)

setwd("School/coursera/ExploratoryDataAnalysis/project/wk1/")

# Data subsetted outside of R -environment into new file
# Used grep -P -e "^[01]{1}\/2\/2007" filename > new_filename
# head -1 filename > headers; cat new_filename >> headers; mv headers new_filename
d07 <- read.csv("household_Feb2007.txt", header=T, sep=";")

# Create new column Times - Date/Time \s[pace] separated as POSIXct
d07$Times <- as.POSIXct(strptime(paste(d07$Date, d07$Time), "%d/%m/%Y %H:%M:%S"))

# Plot Histogram
hist(d07$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)"
     )
png("plot1.png")