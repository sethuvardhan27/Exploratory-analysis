data <- read.table (file = "household_power_consumption.txt",
                    header = TRUE,
                    sep = ";",
                    na.strings = "?",
                    colClasses = c ("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# subset to desired dates using regex
# 2007-02-01 and 2007-02-02

data_subset <- data [grep ("^(1|2)/2/2007", data$Date), ]

#data_subset <- data_subset[complete.cases(data_subset), ]

#convert to date, as specified in the assignment

data_subset$Date <- as.Date (data_subset$Date, format = "%d/%m/%Y")

#convert to time, as specified in the assignment and create X-axis

dateTime <- with (data_subset, strptime (paste (Date, Time), "%F %T"))

data_subset <- cbind (dateTime, data_subset)

# Now, open device to save plot

png ("plot3.png", width = 480, height = 480)

# create plot and add lines (interesting that can use just one "with")

with (data_subset, plot (Sub_metering_1 ~ dateTime, 
                         type = "l",
                         xlab = "",
                         ylab="Energy sub metering"))


with (data_subset, lines (Sub_metering_2 ~ dateTime, 
                          col  = "red"))

with (data_subset, lines (Sub_metering_3 ~ dateTime, 
                          col  = "blue"))

# add legend 
with (data_subset, legend ("topright", 
                           lwd = 2,
                           lty = 1,
                           cex = .8,
                           legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                           col = c ("black", "red", "blue")))

# remember to close device ;)
dev.off ()
