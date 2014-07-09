## Constants
# File was unzipped into the local directory
# Zip file was downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

FILE_LOCAL <- "..\\DATA\\household_power_consumption.txt"
SKIP_ROWS <- 66636 + 1 #Number of rows < "2010-02-01"
N_ROWS_LESS_THAN_MAX_DATE <- 69516 + 1 #Num of rows < "2010-02-03"
NROWS <- N_ROWS_LESS_THAN_MAX_DATE - SKIP_ROWS
TIMEZONE <- "GMT" #Unknown - assuming GMT

## Support functions

# Load data - Same as plot1 - included for to make independent
load_plot_data <- function() {
    # Get column names
    shortread <- read.table(file=FILE_LOCAL,
                            sep=";",
                            header=TRUE,
                            nrows=1)
    colnames <- colnames(shortread)
    
    # Read the file (only the rows of interest)
    data <- read.table(file=FILE_LOCAL,
                       sep=";",
                       header=FALSE,
                       na.strings="?",
                       skip=SKIP_ROWS,
                       nrows=NROWS,
                       col.names=colnames)
    
    # Convert Time and Date into more useful forms
    timestamp = paste(data$Date,data$Time)
    data$Time = strptime(timestamp,
                         format="%d/%m/%Y %H:%M:%S",
                         tz=TIMEZONE)
    
    data$Date <- as.Date(data$Date,format="%d/%m/%Y")
    
    return(data)
}

# Plot 4
plot4a <- function(data){
    plot(x=data$Time,
         y=data$Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power")
}

plot4b <- function(data){
    plot(x=data$Time,
         y=data$Voltage,
         type="l",
         xlab="datetime",
         ylab="Voltage")
}

plot4c <- function(data){
    plot(x=data$Time,
         y=data$Sub_metering_1,
         type="l",
         xlab="",
         ylab="Energy sub metering",
         col="black")    
    lines(data$Time,data$Sub_metering_2,col="red")
    lines(data$Time,data$Sub_metering_3,col="blue")
    legend("topright", 
           legend = c("Sub_metering_1", 
                      "Sub_metering_2", 
                      "Sub_metering_3"), 
           col=c("black","red","blue"), 
           lty=1,
           bty="n")
}

plot4d <- function(data){
    plot(x=data$Time,
         y=data$Global_reactive_power,
         type="l",
         xlab="datetime",
         ylab="Global_reactive_power")
}

plot4 <- function() {
    data <- load_plot_data()
    
    png(filename="plot4.png") #Defaults should work
    
    par(mfrow=c(2,2))
    plot4a(data)
    plot4b(data)
    plot4c(data)
    plot4d(data)
    
    dev.off()
}

plot4()