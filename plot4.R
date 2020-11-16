# John Hopkins Exploratory Data Analysis plot 4

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

combust <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combustrelated <- (combust & coal)
combustSCC <- SCC[combustrelated, ]$SCC
combustNEI <- NEI[NEI$SCC %in% combustSCC, ]
head(combustNEI)
head(combustSCC)
combustrelated
combustSCC
library(ggplot2)

ggp <- ggplot(combustNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
print(ggp)

dev.copy(png, file = "plot4.png")
dev.off()




