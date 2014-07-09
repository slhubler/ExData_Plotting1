## Constants
# File was unzipped into the local directory
# Zip file was downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

FILE_LOCAL <- "..\\DATA\\household_power_consumption.txt"
SKIP_ROWS <- 66636 + 1 #Number of rows < "2010-02-01"
N_ROWS_LESS_THAN_MAX_DATE <- 69516 + 1 #Num of rows < "2010-02-03"
NROWS <- N_ROWS_LESS_THAN_MAX_DATE - SKIP_ROWS
TIMEZONE <- "GMT" #Unknown - assuming GMT

## Support functions

# Load data
load_plot_data <- function() {
    shortread <- read.table(file=FILE_LOCAL,
                            sep=";",
                            header=TRUE,
                            nrows=1)
    colnames <- colnames(shortread)
    data <- read.table(file=FILE_LOCAL,
                       sep=";",
                       header=FALSE,
                       na.strings="?",
                       skip=SKIP_ROWS,
                       nrows=NROWS,
                       col.names=colnames)
    timestamp = paste(data$Date,data$Time)
    data$Time = strptime(timestamp,
                         format="%d/%m/%Y %H:%M:%S",
                         tz=TIMEZONE)
    
    data$Date <- as.Date(data$Date,format="%d/%m/%Y")
    
    return(data)
}
    
# Plot 1
plot1 <- function() {
    data <- load_plot_data()
    
    png(filename="plot1.png") #Defaults should work
    hist(data$Global_active_power,
         col="red",
         xlab="Global Active Power (kilowatts)",
         main="Global Active Power")
    dev.off()
}

plot1()