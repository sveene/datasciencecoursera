##Load Plotting Libraries
library(ggplot2)

##Load Data sets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate - limit to Baltimore, summarize emmissions data per year and type
Balt <- subset(NEI, fips == "24510")
ByYearandTypeinBalt <- aggregate(Emissions ~ year + type, Balt, sum)

##Open Graphics Device
png("plot3.png")

##Create Plot
PlotData <- ggplot(ByYearandTypeinBalt, aes(year, Emissions, color = type))
PlotData + geom_line()+xlab("Year") + ylab("Emissions in Tons") + ggtitle("Emissions by Type in Baltimore from 1999 - 2008")


##Close Graphics Device
dev.off()
