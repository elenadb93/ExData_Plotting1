# PLOT 1

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
png('Plot1.png', width = 480, heigh = 480)

hist(data[, 'Global_active_power'],
     main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', 
     col = 'red')

dev.off()