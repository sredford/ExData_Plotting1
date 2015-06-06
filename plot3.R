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
png("plot3.png", width=480, height=480)

# Make plot
with(df, plot(DateTime2, Sub_metering_1, type = "n", 
              ylab="Energy sub metering",
              xlab = ""))
with(df, lines(DateTime2, Sub_metering_1, col = "black"))
with(df, lines(DateTime2, Sub_metering_2, col = "red"))
with(df, lines(DateTime2, Sub_metering_3, col = "blue"))

# Legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black","red","blue"))

dev.off()