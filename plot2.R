data <- read.table(file = "household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   na.strings = "?",
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
data_subset <- data[grep("^(1|2)/2/2007)",data$Date),]
data_subset$Date <- as.Date (data_subset$Date, format = "%d/%m/%Y")
dateTime <- with (data_subset, strptime (paste (Date, Time), "%F %T"))
data_subset <- cbind (dateTime, data_subset)
png ("plot2.png", width = 480, height = 480)
with (data_subset, plot (Global_active_power ~ dateTime, 
                         type = "l",
                         xlab = "",
                         ylab="Global Active Power (kilowatts)"))
dev.off ()
