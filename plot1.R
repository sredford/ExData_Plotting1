# Load useful libraries
library(sqldf)

# Load data only for the data we are interested in
datafile <- file("household_power_consumption.txt")
df <- sqldf("select * from datafile where Date in ('1/2/2007','2/2/2007')",
            file.format = list(header = TRUE, sep = ";"))
close(datafile)

# Set up PNG
png("plot1.png", width=480, height=480)

# Make plot
hist(df$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power",
     col = "red")

dev.off()