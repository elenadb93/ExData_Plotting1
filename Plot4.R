# PLOT 4

## Import data set from the working directory
data <- read.delim('household_power_consumption.txt', header = TRUE, sep = ';', colClasses = 'character')


## Create a single data/time column 
data <- cbind(paste(data[, 'Date'], data[, 'Time']), data[, names(data)[-c(1,2)]])
names(data)[1] <- 'Date_Time'

data[, 'Date_Time'] <- as.POSIXct(data[, 'Date_Time'], format = '%d/%m/%Y %H:%M:%S')


## Extract data for the period under analysis (from 2007-02-01 to 2007-02-02)
data <- data[grep('^2007-02-01|^2007-02-02', data[, 'Date_Time']), ]


## Change the data type of numeric columns 
data[, 2:dim(data)[2]] <- apply(data[, 2:dim(data)[2]], 2, as.numeric)


## Visualize the head of the data set and its structure
head(data, 10)
str(data)


## Construct and export the plot
png('Plot4.png', width = 480, heigh = 480)

par(mfcol = c(2,2))
plot(x = data[, 'Date_Time'], y = data[, 'Global_active_power'], 
     type = 'l', 
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

plot(x = data[, 'Date_Time'], y = data[, 'Sub_metering_1'],
     type = 'l', 
     xlab = '', ylab = 'Energy sub metering')
lines(x = data[, 'Date_Time'], y = data[, 'Sub_metering_2'], 
      col = 'red')
lines(x = data[, 'Date_Time'], y = data[, 'Sub_metering_3'], 
      col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'),
       lty = 1, 
       bty = 'n',
       cex = 0.75)

plot(x = data[, 'Date_Time'], y = data[, 'Voltage'], 
     type = 'l', 
     xlab = 'datetime', ylab = 'Voltage')


plot(x = data[, 'Date_Time'], y = data[, 'Global_reactive_power'], 
     type = 'l', 
     xlab = 'datetime', ylab = names(data)[3])

dev.off()
