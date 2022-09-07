
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
voltage<-as.numeric(target_data$Voltage)
Global_reactive_power<-as.numeric(target_data$Global_reactive_power)

#create png with specific dimensions
png("plot4.png", width=480, height=480)

#plot Graphs
par(mfrow=c(2,2),mar=c(4,4,0,1), oma=c(0,0,2,0))

with(target_data, {
      
      plot(Datetime,Global_active_power,ylab="Global Active Power",type = "l")
      plot(Datetime,voltage,xlab='Datetime',ylab='Voltage',type='l')
      plot(Sub_metering_1~Datetime,ylab="Energy sub metering",type = "l")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='blue')
      legend('topright',lty=1, lwd=2,bty="n",col = c('black','red','blue'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
      plot(Datetime,Global_reactive_power,xlab='Datetime',ylab='Global_reactive_power',type = "l")
      

})

# close the PNG device
dev.off()




