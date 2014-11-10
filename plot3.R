# Requirement: set the current working directory to this folder directory.
#
# setProject checks whether the necessary files are available in working directory, if not download them.
source("setProject.R")
sourceFiles <- c("summarySCC_PM25.rds", "Source_Classification_Code.rds")

# Read data files. Stop script if error. 
if(sourceFiles[1] %in% dir()){
  NEI <- readRDS(sourceFiles[1])
}else{
  stop(paste("Can't find ", sourceFiles[1], " in current working directory.\nTry setting the right working directory."))
}

if(sourceFiles[2] %in% dir()){
  SCC <- readRDS(sourceFiles[2])
}else{
  stop(paste("Can't find ", sourceFiles[2], " in current working directory.\nTry setting the right working directory."))
}

years <- unique(NEI$year)
NEI_Baltimore <- NEI[NEI$fips == "24510",]

# plot3 data
plot3Data <- with(NEI_Baltimore, tapply(Emissions,list(type,year),sum))
plot3Data <- data.frame(emissions = as.vector(plot3Data),year=rep(as.integer(colnames(plot3Data)), each=4),type=row.names(plot3Data))

# Load ggplot2 library
library("ggplot2")

# Write to png file
png(file="plot3.png",width=600,height=600, bg="transparent")
ggplot(plot3Data,aes(y=emissions,x=year, color=type)) + geom_line(size=1) + geom_point(size=3) + xlab("Year") + ylab("Total Emissions") + ggtitle("Sources of the PM2.5 emissions in Baltimore City, Maryland from 1999 to 2008") + theme(plot.title = element_text(lineheight=.8, face="bold"))
dev.off()