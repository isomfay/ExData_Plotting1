#downloading and unpacking data
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileurl,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")
unlink(temp)

#subsetting data
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
datetime <- paste(data$Date,data$Time)
data$Date_time <- strptime(datetime,"%Y-%m-%d %H:%M:%S")

#plotting
png(file = "plot4.png")
par(mfrow = c(2,2))
with(data,{
        plot(Date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power")
        plot(Date_time, Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(Date_time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
                points(Date_time, Sub_metering_1, type="l", col="black")
                points(Date_time, Sub_metering_2, type="l", col="red")
                points(Date_time, Sub_metering_3, type="l", col="blue")
                legend("topright", lwd=1, col = c("black","red", "blue"), legend = names(data)[7:9])
        plot(Date_time, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()