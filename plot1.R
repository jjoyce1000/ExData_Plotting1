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
##      - The output plot file is named plot1.png.
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
##      -   filename:               plot1.png
##      -   width:                  480 pixels
##      -   height:                 480 pixels
##      -   background (bg):        white
    
    png(filename = "plot1.png", width = 480, height = 480, bg = "white")
    
##  Generate a histogram plot using the following parameters:
##      -   data:                   Global Active Power (filtered_df$Global_active_power)
##      -   hist color (col):       red
##      -   x axis label (xlab):    Global Active Power (kilowatts)
##      -   main title (main):      Global Active Power
    
    hist(filtered_df$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
    
##  Close the graphics device with the dev.off() function.
    
    dev.off()

##  Write the filtered data frame to a file filtered.txt in the current working directory.  Used for debugging purposes.
    
    #write.table(filtered_df,"./filtered.txt",row.names = FALSE)