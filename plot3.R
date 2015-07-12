## Project1, Plot 3
## "Individual household electric power consumption Data Set"
## Dataset: Electric power consumption [20Mb]
## Description: Measurements of electric power consumption in one household with a one-minute 
##              sampling rate over a period of almost 4 years. 
##              Different electrical quantities and some sub-metering values are available.
##Path : E:\Cousera\Exploratory Data Analysis\Project\Project1\Data\household_power_consumption.txt
##  Loading the data
##  When loading the dataset into R, please consider the following:
##  1. The dataset has 2,075,259 rows and 9 columns. 
##  First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
##  We will only be using data from the dates 2007-02-01 and 2007-02-02. 
##  One alternative is to read the data from just those dates rather 
##  than reading in the entire dataset and subsetting to those dates.
##  You may find it useful to convert the Date and Time variables to Date/Time classes in R 
##  using the strptime() and as.Date() functions.
##  Note that in this dataset missing values are coded as ?.
##  Goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 

###################################################
## Part 1: Load data and convert data time format.
## Load Data
## Read the txt file into a data frame
setwd("E:/Cousera/Exploratory Data Analysis/Project/Project1");
ElectricPowerConsumptionDataFull <- read.csv("./Data/household_power_consumption.txt",sep=";", dec=".", header=TRUE,
                                         na.strings="?",nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"');
head(ElectricPowerConsumptionDataFull);

## Convert Date field to yyyy-mm-dd format.
ElectricPowerConsumptionDataFull$Date <- as.Date(ElectricPowerConsumptionDataFull$Date, format="%d/%m/%Y");

## Subsetting the data from the dates 2007-02-01 and 2007-02-02.
ElectricPowerConsumptionData <- subset(ElectricPowerConsumptionDataFull, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"));
rm(ElectricPowerConsumptionDataFull);

## datetime <- paste(ElectricPowerConsumptionData$Date, ElectricPowerConsumptionData$Time);
## Combine date and time variables in dataframe ElectricPowerConsumptionData.
## Convert datetime object to Date/Time class and store it as new variable Datetime
ElectricPowerConsumptionData <- mutate(ElectricPowerConsumptionData,
                                       Datetime = as.POSIXct(paste(ElectricPowerConsumptionData$Date, ElectricPowerConsumptionData$Time)));
head(ElectricPowerConsumptionData)

################################################
## Part 2 : Plot graph.
## Plot 3
## Formula : Sub_metering_1~Datetime
## Add-on  : Sub_metering_1~Datetime
## Add-on  : Sub_metering_2~Datetime
## Start with Sub_metering_1, default color black.
## Add, using function lines, Sub_metering_2 and Sub_metering_3.
################################################
with(ElectricPowerConsumptionData,{
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime, col = 'Red')  
  lines(Sub_metering_3~Datetime, col = 'Blue')
  });
## Add note to graph.
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480);
dev.off();
################################################
