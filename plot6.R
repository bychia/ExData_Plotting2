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

# plot6 data
emissions_motorVeh <- grep("Highway Veh", x=SCC$Short.Name, ignore.case = TRUE)
SCC_Index <- SCC[emissions_motorVeh,]$SCC 
plot6Cities <- c("06037","24510")
plot6Data <- NEI[(NEI$SCC %in% SCC_Index)& (NEI$fips %in% plot6Cities),]
plot6Data$City <- ""
plot6Data[plot6Data$fips=="06037",]$City <- "Los Angeles County, California"
plot6Data[plot6Data$fips=="24510",]$City <- "Baltimore City, Maryland"
plot6Data <- aggregate(formula=Emissions~year + City, data=plot6Data, FUN=sum)

# Loal ggplot2 library
library(ggplot2)

# Write to png
png(file="plot6.png",width=600,height=600, bg="transparent")
ggplot(plot6Data,aes(y=Emissions,x=year, color=City)) + geom_line(size=1) + geom_point(size=3)  +  xlab("Year") + ylab("PM2.5 emission") + ggtitle("PM2.5 emissions from motor vehicle sources in Baltimore & LA") + theme(plot.title = element_text(lineheight=.8, face="bold"))
dev.off()