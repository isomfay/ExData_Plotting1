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
png(file = "plot1.png")
with(data, hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()

