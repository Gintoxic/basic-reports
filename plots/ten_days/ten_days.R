


#barplot(tab)

#dat[1:10,]

tab<-table(dat$mac,dat$day)

days<-colnames(tab)
numdays<-dim(tab)[2]

daysframe<-as.data.frame(days)
colnames(daysframe)<-"day"

daysframe$freq_dev<-0
for (i in 1:numdays)
{
  
  curday<-tab[,i]
  uni<-length(unique(names(which(curday>0))))
  print(uni)
  daysframe$freq_dev[i]<-uni
  daysframe$freq_readings[i]<-sum(tab[,i])
}


setwd("C:\\Traxity\\BasicReports\\plots\\ten_days")
write.table(daysframe, file = "ten_days.csv", append = FALSE, quote = F, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = T,
            col.names = F, qmethod = c("escape", "double"),
            fileEncoding = "")








