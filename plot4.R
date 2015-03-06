library(dplyr)

setwd("~/School/coursera/ExploratoryDataAnalysis/project/wk1/")

# Data being chunked in... 
d07 <- subset(read.csv("household_power_consumption.txt", header=T, sep=";"), 
              (grepl("^[12]{1}\\/2\\/2007", Date) ))

# Create new column Times - Date/Time \s[pace] separated as POSIXct
d07$Times <- as.POSIXct(strptime(paste(d07$Date, d07$Time), "%d/%m/%Y %H:%M:%S"))

# Plot Multiple graphs in Lattice
par(mfrow=c(2,2), mar=c(4,4,2,1), cex=0.75, bg=NA)
with(d07, {
  plot(Times, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(Times, Voltage, ylab="Voltage", type="l", xlab="datetime")
  plot(Times, Sub_metering_1, yaxt= "n", type="n", ylim=c(0,40), ylab="Energy Sub Metering", xlab="")
  lines(Times, Sub_metering_1, type="l")
  axis(2, c(0,10,20,30))
  lines(Times, Sub_metering_2, type="l", col="red")
  lines(Times, Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         cex=0.6, bty = "n")
  plot(Times,Global_reactive_power,type="l", yaxt= "n", ylab="Global_reactive_power", xlab="datetime")
  axis(2,c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
}
)
png(file="plot4.png", width=480, height=480)
dev.off(dev.list()["RStudioGD"])
