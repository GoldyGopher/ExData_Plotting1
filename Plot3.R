# set the working directory
setwd("C:/Users/11855/Documents/0_FCS/R/Coursera/EDA Week1")

#read in the monster file.  Should find a way to only read in the two days of interest
mydata <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)

#show head and tail 
head(mydata)
tail(mydata)

#only wnat to analyze two specific days - put inot day1
day1 <- subset(mydata, mydata$Date=="1/2/2007" | mydata$Date=="2/2/2007")

#convert Date column from string to Date format - dd/mm/yyyy
day1$Date <- as.Date(day1$Date, format='%d/%m/%Y')

# add a DateTime column that is in POSIXlt format for plotting
day1 <- transform(day1,DateTime=interaction(Date,Time,sep=' '))
md1 <- day1
md1$DateTime <- strptime(md1$DateTime, format = "%Y-%m-%d %H:%M:%S")

# convert character values to real
md1$Global_active_power <- as.numeric(md1$Global_active_power)
md1$Global_reactive_power <- as.numeric(md1$Global_reactive_power)
md1$Voltage <- as.numeric(md1$Voltage)
md1$Global_intensity <- as.numeric(md1$Global_intensity)
md1$Sub_metering_1 <- as.numeric(md1$Sub_metering_1)
md1$Sub_metering_2 <- as.numeric(md1$Sub_metering_2)

##*******************************************************
## Create Plot #3 and save to PNG
##*******************************************************
png(filename = "Plot3.png", width = 480, height = 480)
plot(md1$DateTime,md1$Sub_metering_1, type="l", main="", ylab="Energy sub metering", xlab="")
lines(md1$DateTime,md1$Sub_metering_2, type="l", col="red", main="", ylab="Energy sub metering", xlab="")
lines(md1$DateTime,md1$Sub_metering_3, type="l", col="blue", main="", ylab="Energy sub metering", xlab="")
# create the legend
legend("topright", c(names(md1[7]),names(md1[8]),names(md1[9])), col=c("black","red","blue"), lty=c(1,1,1))
dev.off()
