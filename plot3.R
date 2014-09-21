# The following codes will generate plots to answer the 6 questions below, using dataset from: 
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 

setwd('C:/Users/Ooi_Desktop/R/dataset/Ooi/Class/Exploratory')


projectFolder<-"EDAProj2"
if (!file.exists(projectFolder)){
  dir.create(projectFolder)
}
# dataset addresss. Data is on PM2.5 also know as National Emissions Inventory (NEI)

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

zipFile=sprintf("./%s/%s",projectFolder,"temp.zip")

if(!file.exists(zipFile)){
  download.file(url = fileURL, destfile = zipFile)
  dateDownloaded<-date() 
}

if (!exists(zipFile)){
  file<-unzip(zipFile)
  NEI <- readRDS(file[1])
  SCC <- readRDS(file[2])
}

Baltdata<-SCC[SCC$fips=="24510",]
#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
library(ggplot2)
BaltAgg_Type<-aggregate(Baltdata$Emissions,by=list(Year=Baltdata$year, Type=Baltdata$type), FUN=sum)
qplot(Year,x, data=BaltAgg_Type,color=Type,shape=Type,geom=c("line","point"),
      ylab="PM2.5 tons",main="Emission in Baltimore City from 1999 to 2008")
png(file = "./EDAProj2/plot3.png", width = 480, height = 480, units = "px")
qplot(Year,x, data=BaltAgg_Type,color=Type,shape=Type,geom=c("line","point"),
      ylab="PM2.5 tons",main="Emission in Baltimore City from 1999 to 2008")
dev.off()
