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

#5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
Scc_onroad<-NEI$SCC[NEI$Data.Category=="Onroad"]
Balt_Scc_onroad<-Baltdata[Baltdata$SCC %in% Scc_onroad,]
Balt_onroad_agg<-aggregate(Balt_Scc_onroad$Emissions, by=list(Year=Balt_Scc_onroad$year), FUN=sum)
qplot(Year,x, data=Balt_onroad_agg,geom=c("line","point"),
      ylab="PM2.5 tons",main="MotorVehicle-related PM2.5 Emission in Baltimore from 1999 to 2008")

png(file = "./EDAProj2/plot5.png", width = 480, height = 480, units = "px")
qplot(Year,x, data=Balt_onroad_agg,geom=c("line","point"),
      ylab="PM2.5 tons",main="MotorVehicle-related PM2.5 Emission in Baltimore from 1999 to 2008")
dev.off()