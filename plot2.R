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
    #merging date and time
    epc$DT <- as.POSIXct(paste(epc$Date, epc$Time), format="%Y-%m-%d %H:%M:%S")

    #plotting
    plot(x=epc$DT,y=epc$Global_active_power,type="l",xlab= "",ylab="Global Active Power (kilowatts)",frame.plot = TRUE)
    
    #saving copy of the plot into a png file
    dev.copy(png, file = "plot2.png")
    dev.off()
}