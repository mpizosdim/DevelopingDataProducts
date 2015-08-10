Plot1Manipulate <- function(data){
    require(doBy)
    Date <- summaryBy(Age~Date,data=Data,FUN=c(length))
    Date$Date<-as.Date(Date$Date,'%Y-%m-%d')
    Year2015N <- Date[year(Date$Date)==2015,]
    Year2015N$Week <- week(Year2015N$Date)
    Year2014N <- Date[year(Date$Date)==2014,]
    Year2014N$Week <- week(Year2014N$Date)
    Year2013N <- Date[year(Date$Date)==2013,]
    Year2013N$Week <- week(Year2013N$Date)
    Weekly2014 <- summaryBy(Age.length~Week,data=Year2014N,FUN=sum,na.rm=TRUE)
    Weekly2015 <- summaryBy(Age.length~Week,data=Year2015N,FUN=sum,na.rm=TRUE)
    Weekly2013 <- summaryBy(Age.length~Week,data=Year2013N,FUN=sum,na.rm=TRUE)
    WeekTemp1 <- merge(Weekly2013,Weekly2014,by='Week',all=TRUE)
    WeekData <- merge(WeekTemp1,Weekly2015,by='Week',all=TRUE)
    colnames(WeekData) <- c("Week", "2013",'2014','2015')
    WeekData
}
