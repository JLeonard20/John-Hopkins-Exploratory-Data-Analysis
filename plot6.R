# John Hopkins Exploratory Data Analysis plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"
# fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Gather the subset of the NEI data which corresponds to vehicles

vehicles <- grepl("vehicles", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]
head(vehiclesNEI)

# Subset the vehicles NEI data by each city's fip and add city name.

bal <- vehiclesNEI[vehiclesNEI$fips == "24510", ]
bal$city <- "Baltimore City"
head(bal)

la <- vehiclesNEI[vehiclesNEI$fips == "06037", ]
la$city <- "Los Angeles County"

balla <- rbind(bal,la)

library(ggplot2)

ggp <- ggplot(balla, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.copy(png, file = "plot6.png")
dev.off()

