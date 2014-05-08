# reads the data and stops after reading the relevant days
data <- read.table('household_power_consumption.txt', 
                   sep=";", header=TRUE, nrows=69516,
                   colClasses="character")

#extract the relevant days
data <- data[66637:nrow(data),]

# "?" is replaced by NA
data[data=="?"] <- NA

# date and time are pasted together, converted via strptime and
# saved under Date
data$Date <- strptime(paste(data$Date, data$Time,sep=" "), 
                      "%d/%m/%Y %H:%M:%S")

# the time variable is not needed anymore and deleted
data <- data[,!(names(data) %in% c("Time"))]

# plot the relevant data
png("plot3.png", 504, 504, bg="transparent")

# initialize the plot
plot(data$Date, as.numeric(data$Sub_metering_1),type="n", 
     main="", ylab="Energy sub metering", xlab="", 
     bg="transparent")
# add Sub_metering_1
points(data$Date, as.numeric(data$Sub_metering_1),type="l", 
     main="", ylab="Energy sub metering", xlab="", 
     bg="transparent")
# add Sub_metering_2
points(data$Date, as.numeric(data$Sub_metering_2),type="l", 
       col="red")
# add Sub_metering_3
points(data$Date, as.numeric(data$Sub_metering_3),type="l", 
       col="blue")
# add the legend
legend("topright", c("Sub_metering_1","Sub_metering_2", 
       "Sub_metering_3"), col=c("black","red","blue"),
       lty=1)
dev.off()