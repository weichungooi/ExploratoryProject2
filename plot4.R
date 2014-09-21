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
#4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
coalSCC<-NEI$SCC[grep("Coal$",NEI$EI.Sector)] #local coal rows in NEI
Scc_coal<-SCC[SCC$SCC %in% coalSCC,]
scc_coal_agg<-aggregate(Scc_coal$Emissions, by=list(Year=Scc_coal$year), FUN=sum)
qplot(Year,x, data=scc_coal_agg,geom=c("line","point"),
      ylab="PM2.5 tons",main="Coal-related PM2.5 Emission in USA from 1999 to 2008")
png(file = "./EDAProj2/plot4.png", width = 480, height = 480, units = "px")
qplot(Year,x, data=scc_coal_agg,geom=c("line","point"),
      ylab="PM2.5 tons",main="Coal-related PM2.5 Emission in USA from 1999 to 2008")
dev.off()