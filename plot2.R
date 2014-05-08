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
png("plot2.png", 504, 504, bg="transparent")
plot(data$Date, as.numeric(data$Global_active_power),type="l", 
     main="", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()