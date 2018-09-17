##Load Plotting Libraries
library(ggplot2)

##Load Data sets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate - limit to Motor Vehicle in Baltimore

Balt <- subset(NEI, fips == "24510")
SCCVehicle = SCC[grepl("Vehicle", SCC$EI.Sector),]
BaltMotorVehicle <- subset(Balt, Balt$SCC %in% SCCVehicle$SCC)
BaltSum <- aggregate(Emissions ~ year + type, BaltMotorVehicle, sum)

##Open Graphics Device
png("plot5.png", width = 600)

##Create Plot
PlotData <- ggplot(BaltSum, aes(year, Emissions, color = type))
PlotData + geom_line()+xlab("Year") + ylab("Emissions from Motor Vehicles in Tons")  + ggtitle ("Emissions From Motor Vehicles in Baltimore from 1999 - 2008") +labs(color = "Type")

##Close Graphics Device
dev.off()
