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

# plot4 data
emissions_coal <- grep("coal", x=SCC[,"Short.Name"], ignore.case=TRUE)
SCC_Index <- SCC[emissions_coal,]$SCC
plot4Data <- NEI[NEI$SCC %in% SCC_Index,]
plot4Data <- aggregate(Emissions ~ year, data=plot4Data, sum)

# Load ggplot2 library
library(ggplot2)

# Write to png file
png(file="plot4.png",width=600,height=600, bg="transparent")
ggplot(plot4Data,aes(y=Emissions,x=year)) + geom_line(size=1) + geom_point(size=3) +  xlab("Year") + ylab("PM2.5 emission") + ggtitle("PM2.5 emissions from coal combustion-related sources from 1999 to 2008") + theme(plot.title = element_text(lineheight=.8, face="bold"))
dev.off()