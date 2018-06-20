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
    
    #dividing the canvas into 4 pads
    op<-par(mfrow = c(2, 2)) # 2 x 2 pictures on one plot
    
    #Plotting
    #top left
    plot(x=epc$DT,y=epc$Global_active_power,type="l",xlab= "",ylab="Global Active Power",frame.plot = TRUE)

    #top right
    plot(x=epc$DT, y=epc$Voltage, xlab="datetime",ylab="Voltage",type="l" ,frame.plot = TRUE)

    #bottom left
    plot(epc$Sub_metering_1 ~ epc$DT, type="l", xlab="", ylab = "Energy sub metering", ylim = c(0, max(epc$Sub_metering_1, epc$Sub_metering_2, epc$Sub_metering_3)),frame.plot = TRUE)
    lines(epc$Sub_metering_2 ~ epc$DT, type = "l", col = "red")
    lines(epc$Sub_metering_3 ~ epc$DT, type = "l", col = "blue")

    legend("topright", lty=1, col = c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n",inset = c(0.02,0.01))
    
    
    # bottom right
    plot(x=epc$DT, y=epc$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",type="l" ,frame.plot = TRUE)
    
    #saving copy of the plots into a png file
    dev.copy(png, file = "plot4.png")
    dev.off()
    
}