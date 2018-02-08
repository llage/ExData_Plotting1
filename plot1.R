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
## connect png file device to write graphics to:
png (filename="plot1.png", width=480, height=480)
## create histogram:
hist	(twodays$Global_active_power, main="Global Active Power", 
	 xlab="Global Active Power (kilowatts)", col="red")
## disconnect png device (png has been written):
dev.off()
## discard the data frame:
rm(twodays)