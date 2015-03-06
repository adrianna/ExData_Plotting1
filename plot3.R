library(dplyr)

setwd("~/School/coursera/ExploratoryDataAnalysis/project/wk1/")

#d07 <- read.csv("household_Feb2007.txt", header=T, sep=";")

# Data being chunked in... 
d07 <- subset(read.csv("household_power_consumption.txt", header=T, sep=";"), 
                        (grepl("^[12]{1}\\/2\\/2007", Date) ))

# Create new column Times - Date/Time \s[pace] separated as POSIXct
d07$Times <- as.POSIXct(strptime(paste(d07$Date, d07$Time), "%d/%m/%Y %H:%M:%S"))

# Overlay multiple plots in one graph
par(mar=c(2,4,3,2), cex=0.75, bg=NA)
with(d07, plot.window(xlim=range(Times), ylim=c(0,35) ))
with(d07, plot(Times, Sub_metering_1, ylab="Energy Sub Metering", xlab="", yaxt= "n", type="n", ylim=c(0,40)))
with(d07, lines(Times, Sub_metering_1, type="l", col="black"))
#with(d07, lines(Times, Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="", col="black"))
axis(2, c(0,10,20,30))
with(d07, lines(Times, Sub_metering_2, type="l", col="red"))
with(d07, lines(Times, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.7
)
png(file="plot3.png", width=480, height=480)
dev.off()
#dev.off(dev.list()["RStudioGD"])
