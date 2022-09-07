
#read our data and skip first row cuz i 'll name it again
giving_data<-read.table("household_power_consumption.txt",sep = ';',skip = 1)
colnames(giving_data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#subset our data 
target_data<-giving_data[giving_data$Date %in% c("1/2/2007","2/2/2007") , ]
View(target_data)

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
Global_active_power<-as.numeric(target_data$Global_active_power)
Sub_metering_1<-as.numeric(target_data$Sub_metering_1)
Sub_metering_2<-as.numeric(target_data$Sub_metering_2)
Sub_metering_3<-as.numeric(target_data$Sub_metering_3)


#create png with specific dimensions
png("plot3.png", width=480, height=480)
#plot Graphs
#pls, don't forget to put sub_metering first and then Datetime as [Sub_metering_1~Datetime] here in ex 
with(target_data, {
      plot(Sub_metering_1~Datetime,xlab="Day", ylab="Energy sub metering",type = "l")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='blue')
      
})

#add legend
legend('topright',lty=1, lwd=2,col = c('black','red','blue'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

# close the PNG device
dev.off()



