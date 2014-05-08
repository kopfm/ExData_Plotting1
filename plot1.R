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

# plot the relevant data using the hisogram function
png("plot1.png", 504, 504, bg="transparent")
hist(as.numeric(data$Global_active_power),col="red",
     bg="transparent", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()