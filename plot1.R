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

# plot1 data
plot1Data <- aggregate(Emissions ~ year, data=NEI, sum)

# Write to png file
png(file="plot1.png",width=600,height=600, bg="transparent")
plot(plot1Data$Emissions/10^6, type="l", xaxt="n", main="Total emissions from PM2.5 in the United States from 1999 to 2008", xlab="Year", ylab="PM2.5 emission (in 10^6 tons)")
axis(side=1,labels=as.character(years),at=1:length(years))
dev.off()