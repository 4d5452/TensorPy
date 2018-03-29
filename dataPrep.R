rm(list=ls())

data<-read.csv("air_Jan17-Jan18.csv")

#convert date to day of year
days<-format(as.Date(data$DATE), "%j")

tempF<-as.numeric(data$HOURLYDRYBULBTEMPF)
tempC<-as.numeric(data$HOURLYDRYBULBTEMPC)

totalRows<-2*nrow(data)
df<-as.data.frame(matrix(nrow = totalRows, ncol = 3))
names(df)<-c("day", "temp", "label")

tmp<-1
for(i in 1:nrow(data)) {
    df[tmp,]<-c(days[i], tempC[i], 1)
    df[tmp+1,]<-c(days[i], tempF[i], 0)
    tmp<-tmp+2
}
df<-na.omit(df)
df<-df[sample(1:nrow(df)), ]

#send 1/4 to test
#send 3/4 to train
bound<-floor((nrow(df)/4)*3)
df.train<-df[1:bound, ]
df.test<-df[(bound+1):nrow(df), ]

write.csv(df, file="data.csv", na="", row.names=FALSE)
write.csv(df.train, file="train.csv", na="", row.names=FALSE)
write.csv(df.test, file="test.csv", na="", row.names=FALSE)

#3/4 split of set: the set has all *C readings duplicated
#   as a new entry for *F.  Each *C record is 1, and
#   each *F record is 0.
#train<-date, temp, label
#test<-date, temp, label

