
rm(list=ls())


path<-"D://学习//大三上//探索性数据分析//hw3//cereals.csv"
cereal = read.csv(path,
                     stringsAsFactors = F)
library(corrplot)  
library(mice)
head(cereal)
summary(is.na(cereal))
md.pattern(cereal)
cereal <- cereal[complete.cases(cereal),]



score.corr <- round(cor(cereal[,-c(1,2,3)]), 3)
corrplot(round(cor(cereal[,-c(1,2,3,13:15)]), 3),addCoef.col = 'grey')  
summary(cereal[,-c(1,2,3,13:15)])

round(cor(cereal[,-c(1,2,3,13:15)]), 3)
score.pca <- prcomp(cereal[,-c(1,2,3,13:15)], scale=T, retx=T)
summary(score.pca)
score.pca
# 主成分得分
pc <- predict(score.pca)

#查看主成分分析所贡献的方差的碎石图
plot(score.pca,type="lines",main="")   
abline(h=1,col='red') 
box()
# 展示前两个主成分得分的散点图上（不同学生不同标记表示）
plot(pc[,1:2],type='n')
text(x=pc[,1], y=pc[,2], labels=cereal$name)






#install.packages("factoextra", dependencies = T)
library(dplyr)
library(factoextra) # clustering algorithms & visualization
library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
#install.packages("broom", dependencies = T)
library(broom)


df<-score.pca$x[,1:3]
names(df[,1])="pc1"
names(df[,2])="pc2"
names(df[,3])="pc3"

df<-as.data.frame(df)
names(df)[names(df)=="V1"]="name"   
head(df)

distance <- get_dist(df)
fviz_dist(distance, 
          gradient = list(low = "#00AFBB", 
                          mid = "white", 
                          high = "#FC4E07"))
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)
k2
fviz_cluster(k2, data = df)

df %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         state = row.names(cereal)) %>%
  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
  geom_text()


k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

p3
library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)



set.seed(123)

# function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(df, k, nstart = 10 )$tot.withinss
}

# Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")



set.seed(123)

fviz_nbclust(df, kmeans, method = "wss")


# silhouette method
avg_sil <- function(k) {
  km.res <- kmeans(df, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(df))
  mean(ss[, 3])
}

# Compute and plot wss for k = 2 to k = 15
k.values <- 2:15

# extract avg silhouette for 2-15 clusters
avg_sil_values <- map_dbl(k.values, avg_sil)

plot(k.values, avg_sil_values,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K",
     ylab = "Average Silhouettes")
fviz_nbclust(df, kmeans, method = "silhouette")


# Gap method
set.seed(123)
gap_stat <- clusGap(df, FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
# Print the result
print(gap_stat, method = "firstmax")
fviz_gap_stat(gap_stat)


# Final
set.seed(123)
final <- kmeans(df, 4, nstart = 25)
print(final)
fviz_cluster(final, data = df)
final$cluster

# Summarize
USArrests %>%
  mutate(Cluster = final$cluster) %>%
  group_by(Cluster) %>%
  summarise_all("scale")



#### Hierarchical Clustering
df <- scale(USArrests)

# Compute dissimilarity matrix
res.dist <- dist(df, method = "euclidean")

# Compute hierarchical clustering
res.hc <- hclust(res.dist, method = "ward.D2")

# Visualize
plot(res.hc, cex = 0.5)
res.km <- eclust(df, "kmeans", nstart = 25)
fviz_gap_stat(res.km$gap_stat)
fviz_silhouette(res.km)
res.hc <- eclust(df, "hclust") # compute hclust
fviz_dend(res.hc, rect = TRUE) # dendrogam
fviz_silhouette(res.hc) # silhouette plot
fviz_cluster(res.hc) # scatter plot






















