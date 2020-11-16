# Johns Hopkins Exploratory Data Analysis

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

dim(NEI)
str(NEI)
names(NEI)

# Aggregate by sum the total emissions by year.

aggTotal <- aggregate(Emissions ~ year, NEI, sum)

head(aggTotal)

png("plot1.png", width = 480, height = 480, units = "px", bg = "transparent")

barplot(height = aggTotal$Emissions/10^6, names.arg = aggTotal$year,
        xlab = "Year", ylab = "Total PM2.5 Emissions (Tons 10^6)",
        main = "Total PM2.5 Emissions From All US Sources")

dev.off()
