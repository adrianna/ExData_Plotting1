library(dplyr)

setwd("School/coursera/ExploratoryDataAnalysis/project/wk1/")

# Data subsetted outside of R -environment into new file
# Used grep -P -e "^[01]{1}\/2\/2007" filename > new_filename
# head -1 filename > headers; cat new_filename >> headers; mv headers new_filename
d07 <- read.csv("household_Feb2007.txt", header=T, sep=";")

# Create new column Times - Date/Time \s[pace] separated as POSIXct
d07$Times <- as.POSIXct(strptime(paste(d07$Date, d07$Time), "%d/%m/%Y %H:%M:%S"))

# Overlay multiple plots in one graph
par(mar=c(2,2,3,2))
with(d07, plot.window(xlim=range(Times), ylim=c(0,35) ))
with(d07, plot(Times, Sub_metering_1, yaxt= "n", type="n", ylim=c(0,40)))
with(d07, lines(Times, Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="", col="black"))
axis(2, c(0,10,20,30))
with(d07, lines(Times, Sub_metering_2, type="l", col="red"))
with(d07, lines(Times, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.6
)
png("plot3.png")