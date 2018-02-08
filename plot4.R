## download file:
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
	       destfile="powerc.zip", method="auto")
## unpack it:
unzip ("powerc.zip")
## get header row to use as colnames later:
cn <- as.character (read.table ( "household_power_consumption.txt",
				sep=";", nrow=1, stringsAsFactors = FALSE ) 
		)
## only read the rows we need:
twodays <- read.table (	"household_power_consumption.txt",
			sep=";", skip=66637, nrow=2880, stringsAsFactors = F )
## assign the column names gotten before, then discard cn:
colnames(twodays) <- cn
rm (cn)
## create a new column with combined date and time info (paste it together):
twodays$DateTime <- paste (twodays$Date, twodays$Time)
## reformat the new DateTime column to be actually understood as date&time:
twodays$DateTime <- strptime (twodays$DateTime, format="%d/%m/%Y %H:%M:%S")
## connect png file device to write graphics to:
png (filename="plot4.png", width=480, height=480)
## initialise 2x2 plot grid:
par (mfrow=c(2,2))
## make plot top left:  
plot    (twodays$DateTime, twodays$Global_active_power,
         type="l", xlab="", ylab="Global Active Power", col="black"
        )
## make plot top right:
plot    (twodays$DateTime, twodays$Voltage,
	 type="l", xlab="datetime", ylab="Voltage", col="black"
	)
## initialize empty plot bottom left, then add points and legend to it:
plot	(twodays$DateTime, twodays$Sub_metering_1,
	 type="n", xlab="", ylab="Energy sub metering")
points (twodays$DateTime, twodays$Sub_metering_1, type="l", col="black")
points (twodays$DateTime, twodays$Sub_metering_2, type="l", col="red")
points (twodays$DateTime, twodays$Sub_metering_3, type="l", col="blue")
legend  ("topright", lty=1, bty="n",
	 col=c("black","red","blue"),
	 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
        )
## make plot bottom right:
plot	(twodays$DateTime, twodays$Global_reactive_power,
	 type="l", xlab="datetime", ylab="Global_reactive_power", col="black" )
## disconnect png device (png has been written):
dev.off()
## discard the data frame
rm(twodays)