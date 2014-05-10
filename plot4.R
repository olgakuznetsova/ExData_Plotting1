#Exploratory Data Analysis Week 1 Course Project 1

#Download data and unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./EDA_w1_pr1_elpowercons.zip")
list.files ()
dateDownloaded<-date()
unzip ("EDA_w1_pr1_elpowercons.zip")

#Load and extract data for 1-2.2.2007, save in a new file, remove old stuff from environment
powerConsumption<-read.table ("household_power_consumption.txt",header=TRUE,sep=";")
Feb1_2 <- powerConsumption[powerConsumption["Date"]=="1/2/2007"|powerConsumption["Date"]=="2/2/2007", ]
write.table(Feb1_2, file="household_power_consumption_Feb1-2.csv")
rm(list=ls())
Feb1_2 <-read.table ("household_power_consumption_Feb1-2.csv",header=TRUE,sep=" ")

#Convert Date and Time variables to Date/Time classes
tmp<-as.Date(Feb1_2[ ,"Date"],"%d/%m/%Y", tz="America/California")
Feb1_2[ ,"Date"]<-tmp #replace raw Date table with R-formatted

DateTime<-as.POSIXct(paste(Feb1_2$Date, Feb1_2$Time), format="%Y-%m-%d %H:%M:%S", "EST")
#Time_edited<-strptime(Feb1_2[ ,"Time"],"%T") +not used, initially for transforming Time

Feb1_2_new<-data.frame(Feb1_2,DateTime) #append to a new data frame (couldn't replace Time without R yelling(too many variables replacing too few) )

# Plot 4 Global Active Power over time
png (file="plot4.png",width=480,height=480,units = "px")
par(mfrow = c(2, 2))
with(Feb1_2_new,
{
  plot(DateTime, Global_active_power, type= "l", xlab = NA, ylab = "Global Active Power")
  plot(DateTime, Voltage, type= "l", xlab = "datetime", ylab = "Voltage")  
  plot(DateTime, Sub_metering_1, xlab = NA, ylab = "Energy sub metering",type="n")
  points(DateTime, Sub_metering_1, col = "black", type="l")
  points(DateTime, Sub_metering_2, col = "red", type="l")
  points(DateTime, Sub_metering_3, col = "blue", type="l")
  legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), lwd=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type= "l", xlab = "datetime", ylab = "Global_reactive_power")
}
)
dev.off()