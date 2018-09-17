##Load Plotting Libraries
library(ggplot2)

##Load Data sets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate - limit to Baltimore, summarize emmissions data per year, divide emissions by 1000 do axis shows full numbers and not scientific notation
Balt <- subset(NEI, fips == "24510")
PM25PerYearinBalt <- tapply(Balt$Emissions / 1000, Balt$year, sum)

##Open Graphics Device
png("plot2.png")

##Create Plot
plot(names(PM25PerYear), PM25PerYear, type = "l", xlab = "Year", ylab = "PM 2.5 in Tons ('000s')",main = "PM2.5 Emissions in Baltimore from 1999 - 2008")

##Close Graphics Device
dev.off()
