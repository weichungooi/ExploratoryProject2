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
Scc_onroad<-NEI$SCC[NEI$Data.Category=="Onroad"]
Balt_Scc_onroad<-Baltdata[Baltdata$SCC %in% Scc_onroad,]
Balt_onroad_agg<-aggregate(Balt_Scc_onroad$Emissions, by=list(Year=Balt_Scc_onroad$year), FUN=sum)

#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
#Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
LAdata<-SCC[SCC$fips=="06037",]
LA_Scc_onroad<-LAdata[LAdata$SCC %in% Scc_onroad,]
LA_onroad_agg<-aggregate(LA_Scc_onroad$Emissions, by=list(Year=LA_Scc_onroad$year), FUN=sum)

s<-numeric(4) #dummp variable

calPer<-function(x){#Calculates increase from 1999 emission. 
  #positive number means increase, and -ve for decrease 
  s[1]=0
  for(i in 2:4)
    s[i]=(x[i,2]-x[1,2])
  return(s)
}
Balt<-as.numeric(calPer(Balt_onroad_agg))
LA<-as.numeric(calPer(LA_onroad_agg))

cmp<-cbind(Balt,LA)
library(reshape)
cmp2<-melt(cmp)
cmp2$Year<-c("1999","2002","2005","2008")
names(cmp2)<-c("index","Location","percent","Year")
qplot(Year,percent, data=cmp2, 
      color=Location,
      shape=Location,
      ylab="PM2.5 increase in ton from 1999 emission",
      main="PM2.5 emission increase comparison from 1999 to 2008")+
  geom_point(size=2,alpha=0.3,)
png(file = "./EDAProj2/plot6.png", width = 480, height = 480, units = "px")
qplot(Year,percent, data=cmp2, 
      color=Location,
      shape=Location,
      ylab="PM2.5 increase in ton from 1999 emission",
      main="PM2.5 emission increase comparison from 1999 to 2008")+
  geom_point(size=2,alpha=0.3,)
dev.off()