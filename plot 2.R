

#read our data and skip first row cuz i 'll name it again
giving_data<-read.table("household_power_consumption.txt",sep = ';',skip = 1)
colnames(giving_data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#subset our data 
target_data<-giving_data[giving_data$Date %in% c("1/2/2007","2/2/2007") , ]

#have a look
View(target_data)
class(target_data$Date)
class(target_data$Time)

#Set language
Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

#do date format
target_data$Date<-as.Date(target_data$Date,format = "%d/%m/%Y")
#we create new variable have our date and time
timedate<-paste(as.Date(target_data$Date), target_data$Time)
timedate
#call new variable in our table as POSIXct so we can plot it
target_data$Datetime <- as.POSIXct(timedate)
#check
class(target_data$Datetime)

#convert string to numeric
y<-as.numeric(target_data$Global_active_power)

#create png with specific dimensions
png("plot2.png", width=480, height=480)
#plot Graphs
with(target_data,plot(Datetime,y,xlab="Day", ylab="Global Active Power (kilowatts)",type = "l"))
# close the PNG device
dev.off()


