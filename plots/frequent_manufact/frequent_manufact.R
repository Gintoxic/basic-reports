# library(RODBC)
# 
# sqlQuery.1<-"select * from normalized_readings;"
# 
# chanel<-odbcConnect(dsn="traxstage")
# startzeit<-Sys.time()
# dat<-sqlQuery(chanel, sqlQuery.1)
# odbcClose(chanel)
# laufzeit<-Sys.time()-startzeit
# print(laufzeit)

mactab<-table(dat$mac)
macframe<-as.data.frame(mactab)
colnames(macframe)<-c("mac", "freq")

macframe$oui<-substr(macframe$mac, 1,8)
#macframe[1:10,]


setwd("C:\\Traxity\\BasicReports\\plots\\frequent_manufact")
load(file="ouilist.Rdata")

indices<-match(as.character(macframe$oui), rs$t)

macframe$manufact<-rs$r[indices]
#str(macframe)




ind<-which(macframe$oui %in% c("d8:9e:3f", "dc:2b:61",
                               "40:a6:d9",
                               "f0:cb:a1",
                               "58:1f:aa",
                               "7c:11:be",
                               "50:ea:d6",
                               "cc:08:e0",
                               "78:a3:e4",
                               "28:e0:2c",
                               "e0:f8:47",
                               "14:5a:05",
                               "f8:1e:df",
                               "48:60:bc",
                               "3c:d0:f8",
                               "14:8f:c6",
                               "0c:74:c2",
                               "5c:95:ae",
                               "04:1e:64",
                               "ec:85:2f","7c:c5:37","6c:3e:6d","64:b9:e8","60:c5:47","10:9a:dd"," 24:ab:81",
                               "04:f7:e4","68:a8:6d","24:ab:81", " f4:f1:5a", "d0:23:db", "40:b3:95", "f4:f1:5a",
                               "e0:c9:7a","60:fa:cd","d8:9e:3f","dc:2b:61", "5c:59:48","44:d8:84", "88:c6:63","18:9e:fc",
                               "0c:77:1a", "c0:9f:42", "78:6c:1c", "34:15:9e","34:c0:59", "98:fe:94",
                               "98:03:d8","bc:3b:af","d8:d1:cb","00:26:b0","30:f7:c5"," b4:f0:ab","c8:6f:1d","8c:2d:aa",
                               "b4:f0:ab"," e8:8d:28","f0:d1:a9","f0:dc:e2","e8:8d:28","e4:ce:8f",
                               "00:f4:b9","40:d3:2d","44:4c:0c","60:33:4b","84:fc:fe","d8:a2:5e", 
                               "98:d6:bb","28:cf:da","7c:c3:a1","98:b8:e3","9c:04:eb","c4:2c:03",
                               "cc:78:5f","a8:fa:d8","58:55:ca","e4:8b:7f","90:27:e4",
                               "78:ca:39","74:e2:f5","04:0c:ce", "6c:c2:6b","64:a3:cb",
                               "3c:e0:72","e8:06:88", "b8:ff:61", "90:84:0d"
                               ))
                                                           
                               
macframe$manufact[ind] <- rep("Apple", length(ind))

ind<-which(macframe$oui %in% c("e8:99:c4","1c:b0:94","a0:f4:50", "7c:61:93"))
macframe$manufact[ind] <- rep("HTC", length(ind))

ind<-which(macframe$oui %in% c("00:00:F0", "38:aa:3c", "90:18:7c", "5c:0a:5b","88:32:9b","50:cc:f8","cc:3a:61",
                               "98:0c:82","a0:0b:ba","78:d6:f0"))
macframe$manufact[ind] <- rep("Samsung", length(ind))

ind<-which(macframe$oui %in% c("88:30:8a", "20:02:af", "60:21:c0"))
macframe$manufact[ind] <- rep("Murata", length(ind))

ind<-which(macframe$oui=="10:68:3f")
macframe$manufact[ind] <- rep("LG", length(ind))


#table(macframe$manufact)

knownManufact<-c("Apple","Samsung", "HTC", "Sony", "Research in Motion", "Asus",  "Motorola","Murata", "LG")
knownManufake<-c("Rohkost","Sunsing", "HowToC", "Sorry", "Researchers", "Assi", "MuttaRolla","Murata", "LifeGr")
macframe$manufact_short<-"Other"
macframe$manufact_short[which(is.na(macframe$manufact))]<-"NA"

for (i in 1:length(knownManufact))
{print(knownManufact[i])
 ind=grep(tolower(knownManufact[i]),tolower(macframe$manufact))
 #macframe$manufact_short[ind]<-knownManufake[i]
 macframe$manufact_short[ind]<-knownManufact[i]
}

mantab<-table(macframe$manufact_short)

#manufact_short_frame<-aggregate(macframe$freq, list(macframe$manufact_short), length)
#colnames(manufact_short_frame)<-c("manufact_short", "freq")


mantabs<-sort(mantab, decreasing=T)
#rm("manframe")
manframe<-as.data.frame(mantabs)
colnames(manframe)<-c("freq")

rownames(manframe)<-substr(rownames(manframe),1,8)

manframe$prop<-paste(round(prop.table(mantabs),4)*100,"%")


write.table(manframe, file = "frequent_manufact.csv", append = FALSE, quote = F, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = T,
            col.names = F, qmethod = c("escape", "double"),
            fileEncoding = "")


print(sort(table(macframe$oui[which(macframe$manufact_short=="NA")]),decreasing=T)[1:10])