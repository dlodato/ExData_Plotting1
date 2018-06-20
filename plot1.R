{
    # Reading the data, changing the Date from character to Date format and subsetting based on the days of interest
    epc<-read.csv("./household_power_consumption.txt",sep=";",na.strings = "?", stringsAsFactors = FALSE, header = TRUE)
    epc$Date<-as.Date(epc$Date,format="%d/%m/%Y")
    epc<-subset(epc, epc$Date > as.Date("2007-01-31") & epc$Date < as.Date("2007-02-03"))
    
    # plotting
    hist(epc$Global_active_power,xlab = "Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red", axes=TRUE, ylim=range(0,1200))

    #saving copy of the plot into a png file
    dev.copy(png, file = "plot1.png")
    dev.off()
}