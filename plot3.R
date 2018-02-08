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
png (filename="plot3.png", width=480, height=480)
## initialize plot, don't put lines in yet:
plot    (twodays$DateTime, twodays$Sub_metering_1,
         type="n", xlab="", ylab="Energy sub metering")
## put in differently-coloured lines for the different measurements:
points (twodays$DateTime, twodays$Sub_metering_1, type="l", col="black")
points (twodays$DateTime, twodays$Sub_metering_2, type="l", col="red")
points (twodays$DateTime, twodays$Sub_metering_3, type="l", col="blue")
## put in legend documenting the above:
legend ("topright", lty=1, 
        col=c("black","red","blue"), 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
        )
## disconnect png device:
dev.off()
## discard the data frame:
rm(twodays)