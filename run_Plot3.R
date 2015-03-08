# The run_Plot3.R script reads the data file in the current working 
# directory and creates a line plot in a png file plot3.png

# Key Assumption
# The required data file "household_power_consumption.txt" is in the 
# current working directory

# Functions have been utilized from following packages have been used for 
# different steps in this program

require(data.table)

# This section will perform the task of reading the data from the 
# "household_power_consumption.txt" file in the current working directory

# STEP ONE :
# Read the entire data set from the household_power_Consumption file. The "?" 
# values are to be considered equivalent to "NA". The stringsAsFactors is set
# to false to prevent conversion of date strings to factors

  consumptionData <- read.table("household_power_consumption.txt",
                                  header=TRUE,
                                  sep=";",
                                  dec=".",
                                  na.strings=c("NA","?"), 
                                  stringsAsFactors=FALSE)
  consumptionData_tbf <- data.table(consumptionData)

# STEP TWO :
# Add a date/time column to the data table to convert the date and time 
# character string to POSIXct variable that lends itself to easier date/time
# manipulation 

  consumptionData_tbf[,DateTime := as.POSIXct(paste(consumptionData_tbf$Date,consumptionData_tbf$Time), format="%d/%m/%Y %T")]

# STEP THREE :
# Pickup relevant data from the consumptionData table. The relevant data here
# is data between Feb 01 2007 and Feb 02 2007

  consumptionData_tbf <- consumptionData_tbf[consumptionData_tbf$DateTime >= strptime("2007/2/1 00:00:00","%Y/%m/%d %T") & 
                                           consumptionData_tbf$DateTime <= strptime("2007/2/2 23:59:59","%Y/%m/%d %T")]

# STEP FOUR : 
# This step creates the png device as the graphics device and outputs the
# graph to the png device and then closes the png device.

# STEP FOUR (a)
# setup the png device per project requirements i.e. "plot3.png" filename
# Other parameters such as size=480 appear to be the default value for png device.
# IMPORTANT : The plot3.png file is created in the current working directory
  png(filename="plot3.png")

# STEP FOUR (b) 
# Create the plot and setup the appropriate labels and axis headings. Type = "l"
# ensures a line is drawn through the different points instead of displaying points
# First plot sets up the plot with Sub_metering_1 values
  with(consumptionData_tbf,plot(DateTime,Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab=""))

# STEP FOUR (c)
# Adds lines for Sub_metering_2 and Sub_metering_3 values to the plot with
# line colors red and blue respectively
  
  with(consumptionData_tbf,lines(DateTime,Sub_metering_2,type="l",col="red"))
  with(consumptionData_tbf,lines(DateTime,Sub_metering_3,type="l",col="blue"))

# STEP FOUR (d)
# Adds the legends on the top right hand corner as specified in the requirement
  legend("topright",lty="solid", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# STEP FOUR (e)
# Close the png device
  dev.off()



