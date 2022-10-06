#可视化
library(ggplot2)

prop.table(heart$TenYearCHD)
ggplot(heart,aes(x=male,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)
ggplot(heart,aes(x=education,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)
ggplot(heart,aes(x=BPMeds,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)
ggplot(heart,aes(x=prevalentStroke,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)
ggplot(heart,aes(x=prevalentHyp,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)
ggplot(heart,aes(x=diabetes,fill=TenYearCHD))+geom_bar(position = "fill",alpha=0.8)


#totChol/sysBP/glucose/heartRate/cigsperday
ggplot(heart)+geom_histogram(aes(x=totChol,col=1,fill=TenYearCHD),position="identity",alpha=0.8,binwidth = 40)+facet_wrap(~TenYearCHD)+guides(color=FALSE)
ggplot(heart)+geom_histogram(aes(x=sysBP,col=1,fill=TenYearCHD),position="identity",alpha=0.8,binwidth =15)+facet_wrap(~TenYearCHD)+guides(color=FALSE)
ggplot(heart)+geom_histogram(aes(x=glucose,col=1,fill=TenYearCHD),position="identity",alpha=0.8,binwidth =10)+facet_wrap(~TenYearCHD)+guides(color=FALSE)
ggplot(heart)+geom_histogram(aes(x=heartRate,col=1,fill=TenYearCHD),position="identity",alpha=0.8,binwidth =7)+facet_wrap(~TenYearCHD)+guides(color=FALSE)
ggplot(heart)+geom_histogram(aes(x=cigsPerDay,col=1,fill=TenYearCHD),position="identity",alpha=0.8,binwidth = 6)+facet_wrap(~TenYearCHD)+guides(color=FALSE)

ggplot(heart)+geom_boxplot(aes(x=TenYearCHD,y=age,fill=TenYearCHD),alpha=0.8)+labs(x="age")
ggplot(heart)+geom_boxplot(aes(x=TenYearCHD,y=totChol,fill=TenYearCHD))+labs(x="totChol")
ggplot(heart)+geom_boxplot(aes(x=TenYearCHD,y=diaBP,fill=TenYearCHD),alpha=0.8)+labs(x="diaBP")
ggplot(heart)+geom_boxplot(aes(x=TenYearCHD,y=BMI,fill=TenYearCHD),alpha=0.8)+labs(x="BMI")



ggplot(heart,aes(x=prevalentHyp,fill=BPMeds))+geom_bar(position = "fill")
ggplot(heart)+geom_boxplot(aes(x=diabetes,y=glucose,fill=diabetes))

