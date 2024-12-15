data <- read.table (file = "household_power_consumption.txt",
                    header = TRUE,
                    sep = ";",
                    na.strings = "?",
                    colClasses = c ("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
data_subset <- data [grep ("^(1|2)/2/2007", data$Date), ]
data_subset$Date <- as.Date (data_subset$Date, format = "%d/%m/%Y")
png ("plot1.png", width = 480, height = 480)
hist (data_subset$Global_active_power, 
      col = "red", 
      xlab = "Global Active Power (kilowatts)",
      main = "Global Active power")

# remember to close device ;)
dev.off ()
