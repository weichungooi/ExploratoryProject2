# The following codes will generate plots to answer the 6 questions below, using dataset from: 
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip 

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

Xlab="Year"
Ylab="PM2.5 tons"

#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
Baltdata<-SCC[SCC$fips=="24510",]
BaltAgg<-aggregate(Baltdata$Emissions,by=list(Year=Baltdata$year), FUN=sum)
plot(BaltAgg,xlab=Xlab,ylab=Ylab,main="Emission in Baltimore City from 1999 to 2008")
png(file = "./EDAProj2/plot2.png", width = 480, height = 480, units = "px")
plot(BaltAgg,xlab=Xlab,ylab=Ylab,main="Emission in Baltimore City from 1999 to 2008")
dev.off()