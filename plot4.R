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

png ("plot4.png", width = 480, height = 480)

# configure to print 4 plots in one file

par (mfcol = c (2, 2))



# PLOT [0,0]

with (data_subset, plot (Global_active_power ~ dateTime, 
                         type = "l",
                         xlab = "",
                         ylab = "Global Active Power (kilowatts)"))



# PLOT [0,1]

with (data_subset, { 
  
  plot (Sub_metering_1 ~ dateTime, 
        type = "l",
        xlab = "",
        ylab = "Energy sub metering")
  
  lines (Sub_metering_2 ~ dateTime, 
         col  = "red")
  
  lines (Sub_metering_3 ~ dateTime, 
         col  = "blue")
  
})

# add legend 
legend ("topright", 
        bty = "n",
        lwd = 2,
        lty = 1,
        cex = .5,
        legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c ("black", "red", "blue"))

# PLOT [1,0]

with (data_subset, plot (Voltage ~ dateTime, 
                         type = "l",
                         xlab = "",
                         ylab = "Voltage  (volt)"))

# PLOT [1,1]

with (data_subset, plot (Global_reactive_power ~ dateTime, 
                         type = "l",
                         xlab = "",
                         ylab = "Global Reactive Power (kilowatts)"))


# remember to close device ;)
dev.off ()
