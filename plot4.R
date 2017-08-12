#########################################################################################################################################
##
##  Week 1 - Exploratory Data Analysis
## 
##  This script does the following:
##      - Reads in a data set from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##        that contains measurements of electric power consumption.
##        The measurements include electric power consumption in one household with a one-minute sampling rate
##        over a period of almost 4 years.
##
##        This script assumes that the data set is already downloaded and stored in the working directory as "household_power_consumption.txt.
##        The dataset has 2,075,259 rows and 9 columns. 
##        We will only be using data from the dates 2007-02-01 and 2007-02-02. 
##        One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
##        You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime()  and as.Date() functions.
##        Note that in this dataset missing values are coded as ? and the data values are separated by semi-colons.
##      
##      - Constructs a plot and saves the plot to a PNG file with a width of 480 pixels and a height of 480 pixels.
##      - The output plot file is named plot4.png.
##
#########################################################################################################################################

##  Load the lubridate package to manipulate date formats useful for extracting the days of the week.

    #library(lubridate)

##  Read the data set and assign a data frame variable (data_df) for the data set. 
##  Set header = TRUE since the raw data contain headers.  Also set sep = ; since the data is separated by semi-colons.
##  Also set stringsAsFactors = FALSE and na.strings = ?.  Also, set the colClasses to "numeric" for all columns except "Date" and "Time".

    data_df <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?", colClasses = c(NA,NA,rep("numeric",7)))
    
##  Use the as.date function to convert the format of the "Date" column from character class to "Date" class using the dd/mm/yyyy format.
    
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y") 
    
##  Create a new column in the data set using the strptime function that combines the Date and Time columns to be used as the x-axis in the plots.
    
    data_df$DateTime <- strptime(paste(data_df$Date, data_df$Time), format="%Y-%m-%d %H:%M:%S")
    
##  Set the date_1 and date_2 variables to the two dates of data that we are interested in plotting using the as.Date function.
    
    date_1 <- as.Date("2007-02-01")
    date_2 <- as.Date("2007-02-02") 
    
##  Set the filtered_df data frame variable...this is used to subset the two dates (date_1 and date_2) that we are interested in plotting.
    
    filtered_df <- data_df[data_df$Date >= date_1 & data_df$Date <= date_2,]

##  Create a new column in the data set using the wday function that extracts the workday to be used as the x-axis in the plots.
    
    #data_df$Day <- wday(filtered_df$DateTime, label=TRUE)
    
##  Open the PNG graphics device and set the following parameters:
##      -   filename:               plot4.png
##      -   width:                  480 pixels
##      -   height:                 480 pixels
##      -   background (bg):        white
    
    png(filename = "plot4.png", width = 480, height = 480, bg = "white")
    
##  Set the number of rows and columns using the par function and mfrow parameter to 2 each to display 4 plots.
    
    par(mfrow=c(2,2))
    
##  Generate a plot using the following parameters for the top-left plot:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Global Active Power (filtered_df$Global_active_power)
##      -   type:                   "n" (don't display any data, add lines incrementally)
##      -   x axis label (xlab):    "" (blank)
##      -   y axis label (xlab):    Global Active Power

    plot(filtered_df$DateTime,filtered_df$Global_active_power,type="n", xlab = "", ylab = "Global Active Power")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Global Active Power (filtered_df$Global_active_power)
##      -   line type (lty):        solid
    
    lines(filtered_df$DateTime,filtered_df$Global_active_power, lty="solid")    


    
    
##  Generate a plot using the following parameters for the top-right plot:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Voltage (filtered_df$Voltage)
##      -   type:                   "n" (don't display any data, add lines incrementally)
##      -   x axis label (xlab):    "datetime"
##      -   y axis label (xlab):    Voltage
    
    plot(filtered_df$DateTime,filtered_df$Voltage,type="n", xlab = "datetime", ylab = "Voltage")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Voltage (filtered_df$Voltage)
##      -   line type (lty):        solid
    
    lines(filtered_df$DateTime,filtered_df$Voltage, lty="solid")     
    
##  Generate a plot using the following parameters for the bottom-left plot:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Sub Metering 1 (filtered_df$Sub_metering_1)
##      -   type:                   "n" (don't display any data, add lines incrementally)
##      -   x axis label (xlab):    "" (blank)
##      -   y axis label (xlab):    Energy sub metering
    
    plot(filtered_df$DateTime,filtered_df$Sub_metering_1,type="n", xlab = "", ylab = "Energy sub metering")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Sub Metering 1 (filtered_df$Sub_metering_1)
##      -   line type (lty):        solid
##      -   line color (col):       black
    
    lines(filtered_df$DateTime,filtered_df$Sub_metering_1, lty="solid", col="black")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Sub Metering 2 (filtered_df$Sub_metering_2)
##      -   line type (lty):        solid
##      -   line color (col):       red
    
    lines(filtered_df$DateTime,filtered_df$Sub_metering_2, lty="solid", col="red")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Sub Metering 3 (filtered_df$Sub_metering_3)
##      -   line type (lty):        solid
##      -   line color (col):       blue
    
    lines(filtered_df$DateTime,filtered_df$Sub_metering_3, lty="solid", col="blue")    
    
##  Add a legend using the following parameters:
##      -   orientation:            topright
##      -   line type (lty):        solid
##      -   colors (col):           black (for Sub_metering_1)
##      -   colors (col):           red (for Sub_metering_2)
##      -   colors (col):           blue (for Sub_metering_3)
    
    legend("topright",col=c("black","red","blue"),lty="solid",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
    
    
##  Generate a plot using the following parameters for the bottom-right plot:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Global Reactive Power (filtered_df$Global_reactive_power)
##      -   type:                   "n" (don't display any data, add lines incrementally)
##      -   x axis label (xlab):    "datetime"
##      -   y axis label (xlab):    Global_reactive_power
    
    plot(filtered_df$DateTime,filtered_df$Global_reactive_power,type="n", xlab = "datetime", ylab = "Global_reactive_power")
    
##  Add lines to the plot using the following parameters:
##      -   x data:                 data/time (filtered_df$DateTime)              
##      -   y data:                 Voltage (filtered_df$Voltage)
##      -   line type (lty):        solid
    
    lines(filtered_df$DateTime,filtered_df$Global_reactive_power, lty="solid")  
    
##  Close the graphics device with the dev.off() function.
    
    dev.off()

##  Write the filtered data frame to a file filtered.txt in the current working directory.  Used for debugging purposes.
    
    #write.table(filtered_df,"./filtered.txt",row.names = FALSE)