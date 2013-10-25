library(RODBC)

sqlQuery.1<-"select count(*) as num_readings, count(distinct mac) as num_mac,min(read_at) as mintime, max(read_at) as maxtime from normalized_readings;"

chanel<-odbcConnect(dsn="traxstage")
startzeit<-Sys.time()
dat<-sqlQuery(chanel, sqlQuery.1)
odbcClose(chanel)
laufzeit<-Sys.time()-startzeit
print(laufzeit)

dat$update_time<-Sys.time()

setwd("C:\\Traxity\\BasicReports\\plots\\last_update")
write.table(dat, file = "last_update.csv", append = FALSE, quote = F, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = T,
            col.names = F, qmethod = c("escape", "double"),
            fileEncoding = "")