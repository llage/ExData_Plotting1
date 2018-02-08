## download file
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
	       destfile="powerc.zip", method="auto")
## unpack it
unzip ("powerc.zip")
## get header row to use as colnames later:
cn <- as.character (read.table ( "household_power_consumption.txt",
				sep=";", nrow=1, stringsAsFactors = FALSE ) 
		)
## only read the rows we need:
twodays <- read.table (	"household_power_consumption.txt",
			sep=";", skip=66637, nrow=2880, stringsAsFactors = F )
## assign the column names gotten before, then discard cn
colnames(twodays) <- cn
rm (cn)
## create a new column with combined date and time info (paste it together):
twodays$DateTime <- paste (twodays$Date, twodays$Time)
## reformat the new DateTime column to be actually understood as date&time:
twodays$DateTime <- strptime (twodays$DateTime, format="%d/%m/%Y %H:%M:%S")
## connect png file device to write graphics to:
png (filename="plot2.png", width=480, height=480)
## create lines plot
plot	(twodays$DateTime, twodays$Global_active_power,
	 type="l", xlab="", ylab="Global Active Power (kilowatts)")
## disconnect png device (png has been written):
dev.off()
## discard the data frame
rm (twodays)