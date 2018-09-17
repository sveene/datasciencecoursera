##Load Plotting Libraries
library(ggplot2)


##Load Data sets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate - limit to coal cumbustion-related sources
SCCCoal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
MergeCoal <- merge(NEI, SCCCoal, by = 'SCC')
MergeCoal$Emissions <- MergeCoal$Emissions / 1000
CoalSum <- aggregate(Emissions ~ year + type, MergeCoal, sum)

##Open Graphics Device
png("plot4.png", width = 600)

##Create Plot
PlotData <- ggplot(CoalSum, aes(year, Emissions, color = type))
PlotData + geom_line()+xlab("Year") + ylab("Emissions in Tons ('000s')")  + ggtitle ("Emissions by Coal Source from 1999 - 2008") +labs(color = "Type")

##Close Graphics Device
dev.off()
