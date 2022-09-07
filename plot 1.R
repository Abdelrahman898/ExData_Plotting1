
#read our data and skip first row cuz i 'll name it again
giving_data<-read.table("household_power_consumption.txt",sep = ';',skip = 1)
colnames(giving_data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#take a look at our data
dim(giving_data)
head(giving_data,5)
names(giving_data)
ncol(giving_data)

#subset our data 
target_data<-giving_data[giving_data$Date %in% c("1/2/2007","2/2/2007") , ]

#take a look at our data
dim(target_data)
head(target_data)
range(target_data$Global_active_power)
class(target_data$Global_active_power)

#convert it to numeric so i can plot it
x<-as.numeric(target_data$Global_active_power)
#create png with specific dimensions
png("plot1.png", width=480, height=480)
#plot Graphs
hist(x,col = 'red',main="Global Active Power")
# close the PNG device
dev.off()




