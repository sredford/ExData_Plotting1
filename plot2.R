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
png("plot2.png", width=480, height=480)

# Make plot
plot(df$DateTime2, df$Global_active_power, type="l",
     xlab = "",
     main = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()