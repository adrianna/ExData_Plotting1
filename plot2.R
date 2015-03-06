library(dplyr)

setwd("School/coursera/ExploratoryDataAnalysis/project/wk1/")

# Data being chunked in... 
d07 <- subset(read.csv("household_power_consumption.txt", header=T, sep=";"), 
              (grepl("^[12]{1}\\/2\\/2007", Date) ))

# Create new column Times - Date/Time \s[pace] separated as POSIXct
d07$Times <- as.POSIXct(strptime(paste(d07$Date, d07$Time), "%d/%m/%Y %H:%M:%S"))

# Plot Global Active Power vs Times
par(cex=0.75, bg=NA)
with(d07, plot(Times,Global_active_power,type="l", 
               ylab="Global Active Power (kilowatts)", xlab=""))
png(file="plot2.png", width=480, height=480)
dev.off(dev.list()["RStudioGD"])