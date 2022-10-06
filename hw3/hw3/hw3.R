library(ggplot2)
library(mice)
library(corrplot)
library(gridExtra)
library(factoextra)

cerealorigin<-read.csv("D://学习//大三上//探索性数据分析//hw3//cereals.csv",header=T)
###数据预处理
#缺失值
head(cerealorigin)
md.pattern(cerealorigin,rotate.names = TRUE)
cereal<-cerealorigin[complete.cases(cerealorigin),]
cereall<-cereal[,c(-1,-2,-3,-13,-14,-15)]

#异常值
boxplot(cereall$calories)
boxplot(cereall$protein)
boxplot(cereall$fat)
boxplot(cereall$sodium)
boxplot(cereall$fiber)
boxplot(cereall$carbo)
boxplot(cereall$sugars)
boxplot(cereall$potass)
hist(cereall$vitamins)

###可视化
score.corr <- round(cor(cereall), 3)
corrplot(score.corr, addCoef.col = 'grey')
ggplot(cereal,aes(x=factor(1),fill=mfr))+geom_bar()+coord_polar(theta="y")+scale_fill_manual(values=alpha(c("#99CCFF","#9999FF","#6666FF","#0033CC","#0099CC","#660099","#000066"), 0.65))

p1<-hist(cereall$calories,col = "lightblue")
ggplot(cereal)+geom_histogram(aes(x=calories,fill=mfr),binwidth = 17)
p2<-hist(cereall$protein,col = "lightblue")
p3<-hist(cereall$fat,col = "lightblue")
p4<-hist(cereall$sodium,col = "lightblue")
p5<-hist(cereall$fiber,col = "lightblue")
p6<-hist(cereall$carbo,col = "lightblue")
p7<-hist(cereall$sugars,col = "lightblue")
p8<-hist(cereall$potass,col = "lightblue")
p9<-hist(cereall$vitamins,col = "lightblue")


###主成分
score.pca <- prcomp(cereall, scale=T, retx=T)
summary(score.pca)
score.pca$rotation
score.pca
#主成分得分
cerealpca<- predict(score.pca)
cerealpca
#碎石图
plot(score.pca,type="lines",main="")   
abline(h=1,col='red') 
box()

###聚类
set.seed(1234)
cerealpcak<-cerealpca[,1:4]
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data, 2, var))
  for(i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers = i)$withinss)
  }
  plot(1:nc, wss, type = "b",xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")
}
wssplot(cerealpcak)

#kmeans聚类
set.seed(1234)
cerealkmeans <- kmeans(cerealpcak,centers = 6)
table(cerealkmeans$cluster)
cerealkmeans$centers

plot(cerealpca[,1:2],col=cerealkmeans$cluster,pch="*") 
points(cerealkmeans$centers[,1:2],pch=8,col=1:6,cex=2) 
plot(cerealpca[,3:4],col=cerealkmeans$cluster,pch="*") 
points(cerealkmeans$centers[,3:4],pch=8,col=1:6,cex=2)



fviz_cluster(cerealkmeans, data = cerealpcak)


