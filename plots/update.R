library(RODBC)
startzeitScript<-Sys.time()
#sqlQuery.1<-"select * from normalized_readings;"
sqlQuery.1<-"select device, mac, read_at from normalized_readings;"
chanel<-odbcConnect(dsn="traxstage")
startzeit<-Sys.time()
dat<-sqlQuery(chanel, sqlQuery.1)
odbcClose(chanel)
laufzeit<-Sys.time()-startzeit
print(laufzeit)
dat$day<-format(dat$read_at, "%y-%m-%d")
#str(dat)
##########################################################################
##########################################################################
##########################################################################

table(dat$device)
table(strftime(dat$read_at, "%Y-%m-%d"),dat$device)


source('C:/Traxity/BasicReports/plots/ten_days/ten_days.R')


source('C:/Traxity/BasicReports/plots/frequent_manufact/frequent_manufact.R')
source('C:/Traxity/BasicReports/plots/last_update/last_update.R')

laufzeitScript<-Sys.time()-startzeitScript
print(laufzeitScript)

#library(RCurl)
#?ftpUpload
#ftpUpload(what, to, asText = inherits(what, "AsIs") || is.raw(what), ..., curl = getCurlHandle())