library(chron)
{
    # Reading the data, changing the Date from character to Date format and subsetting based on the days of interest
    epc<-read.csv("./household_power_consumption.txt",sep=";",na.strings = "?", stringsAsFactors = FALSE, header = TRUE)
    epc$Date<-as.Date(epc$Date,format="%d/%m/%Y")
    epc<-subset(epc, epc$Date > as.Date("2007-01-31") & epc$Date < as.Date("2007-02-03"))

    #changing the Time from character to Time format (taking out the current day)
    epc$Time <- strptime(epc$Time,format="%H:%M:%S")
    epc$Time <- sub(".*\\s+", "",  epc$Time)
    epc$Time <- times(epc$Time)
    epc$DT <- as.POSIXct(paste(epc$Date, epc$Time), format="%Y-%m-%d %H:%M:%S")

    #plotting with associated formula
    plot(epc$Sub_metering_1 ~ epc$DT, type="l", xlab="", ylab = "Energy sub metering", ylim = c(0, max(epc$Sub_metering_1, epc$Sub_metering_2, epc$Sub_metering_3)),frame.plot = TRUE)
    lines(epc$Sub_metering_2 ~ epc$DT, type = "l", col = "red")
    lines(epc$Sub_metering_3 ~ epc$DT, type = "l", col = "blue")

    #adding a legend    
    legend("topright", lty=1, col = c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),seg.len = 3)
    
    #saving copy of the plot into a png file
    dev.copy(png, file = "plot3.png")
    dev.off()
}