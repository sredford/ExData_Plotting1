# Load useful libraries
library(sqldf)

# Load data only for the data we are interested in
datafile <- file("household_power_consumption.txt")
df <- sqldf("select * from datafile where Date in ('1/2/2007','2/2/2007')",
            file.format = list(header = TRUE, sep = ";"))
close(datafile)

# merge Date and Time columns
df$DateTime <- with(df, paste0(Date, " ",Time))
df$DateTime2 <- as.POSIXct(strptime(df$DateTime, "%d/%m/%Y %H:%M:%S"))

# Set up PNG
png("plot4.png", width=480, height=480)

# Make plots
par(mfrow = c(2, 2))
with(df, {
  plot(df$DateTime2, df$Global_active_power, type="l",
       xlab = "",
       main = "",
       ylab = "Global Active Power")
  
  plot(df$DateTime2, df$Voltage, type="l",
       xlab = "datetime",
       main = "",
       ylab = "Voltage")
  
  plot(DateTime2, Sub_metering_1, type = "n", 
       ylab="Energy sub metering",
       xlab = "")
  lines(DateTime2, Sub_metering_1, col = "black")
  lines(DateTime2, Sub_metering_2, col = "red")
  lines(DateTime2, Sub_metering_3, col = "blue")
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty = 1,
         bty = "n",
         col = c("black","red","blue"))
  
  plot(df$DateTime2, df$Global_reactive_power, type="l",
       xlab = "datetime",
       main = "",
       ylab = "Global_reactive_power")
  
})

dev.off()