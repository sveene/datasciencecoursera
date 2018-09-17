##Load Plotting Libraries
library(ggplot2)

##Load Data sets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate - limit to Motor Vehicle activities 
SCCVehicle = SCC[grepl("Vehicle", SCC$EI.Sector),]
MergeVehicle <- merge(NEI, SCCVehicle, by = 'SCC')

##Limit to Baltimore and Los Angeles County
SubSetData <- subset(MergeVehicle, (fips == "24510" | fips == "06037"))

##Add City instead of FIPS
SubSetData$City[SubSetData$fips == "24510"] <- "Baltimore City, MD"
SubSetData$City[SubSetData$fips == "06037"] <- " Los Angeles County, CA"
DataSum <- aggregate(Emissions ~ year + City, SubSetData, sum)


##Open Graphics Device + Made Graph wider than default
png("plot6.png", width = 600)

##Create Plot
PlotData <- ggplot(DataSum, aes(year, Emissions, color = City))
PlotData + geom_line()+xlab("Year") + ylab("Emissions from Motor Vehicles in Tons")  + ggtitle ("Baltimore Compared to Los Angeles County from 1999 - 2008") +labs(color = "City")

##Close Graphics Device
dev.off()
