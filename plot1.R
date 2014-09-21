# The following codes will generate plots to answer the 6 questions below, using dataset from: 
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 
#1999, 2002, 2005, and 2008.

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

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
aggdata<-aggregate(SCC$Emissions,by=list(Year=SCC$year), FUN=sum)
plot(aggdata,xlab="Year",ylab="PM2.5 tons",main="Emission in United States from 1999 to 2008")

Xlab="Year"
Ylab="PM2.5 tons"
Main="Emission in United States from 1999 to 2008"
png(file = "./EDAProj2/plot1.png", width = 480, height = 480, units = "px")
plot(aggdata,xlab=Xlab,ylab=Ylab,main=Main)
dev.off()  