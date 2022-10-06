#variable Pre
car$Mfr_GuaranteePre<-cut(car$Mfr_Guarantee,c(-1,0.5,2),c("n","y"))
car$Mfr_GuaranteePre