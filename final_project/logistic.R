library(lattice)
library(mice)
library(ggplot2)
library(VIM)
library(DMwR)
library(ResourceSelection)
library(pROC)

heart<-read.csv("D://学习//大三上//探索性数据分析//final_project//heartdisease.csv",header=T)
#因子化
heart$male<-as.factor(heart$male)
heart$education<-as.factor(heart$education)
heart$BPMeds<-as.factor(heart$BPMeds)
heart$prevalentStroke<-as.factor(heart$prevalentStroke)
heart$diabetes<-as.factor(heart$diabetes)
heart$prevalentHyp<-as.factor(heart$prevalentHyp)
heart$TenYearCHD<-as.factor(heart$TenYearCHD)
#设定基准组，避免虚拟变量陷阱
heart$education<-factor(as.character(heart$education),levels=c("1","2","3","4"))

#独立性检验
x1<-table(heart$BPMeds,heart$prevalentHyp)
is.matrix(x1)
chisq.test(x1)
cor(heart$diaBP,heart$sysBP) #0.7609
x2<-table(heart$prevalentHyp,heart$prevalentStroke)
chisq.test(x2)
x3<-table(heart$glucose,heart$diabetes)

#划分训练集和测试集8:2
set.seed(12345)
nn=0.8
sub<-sample(1:nrow(heart),round(nrow(heart)*nn))
hearttrain<-heart[sub,]
hearttest<-heart[-sub,]
dim(hearttrain)
dim(hearttest)
str(hearttrain)

#全模型放入AIC进行回归
glm1<-glm(TenYearCHD~.,family=binomial(link="logit"),data=hearttrain)
glm1_steped<-step(glm1,k=2)
summary(glm1)
summary(glm1_steped)
#卡方检验
pchisq(glm1_steped$deviance,glm1_steped$df.residual,lower.tail = FALSE)
anova(glm1_steped,test='Chisq')
#Hosmer-Lemeshow检验（因为自变量中有连续变量）
hoslem.test(glm1_steped$y,fitted(glm1_steped),g=10)

#推断
exp(glm1_steped$coefficients) #OR估计
#预测
pret<-predict(glm1_steped,hearttrain,type="response")
pre<-predict(glm1_steped,hearttest,type="response")

prob<-1/(1+exp(-pre))
pre_CHD<-NULL
pre_CHD[prob>0.5]<-1
pre_CHD[prob<=0.5]<-0
library(caret)
ismatrix<-confusionMatrix(as.factor(pre_CHD),as.factor(hearttest$TenYearCHD))
ismatrix
confusionMatrix(as.factor(pre_CHD),as.factor(hearttrain$TenYearCHD))

#预测效果（ROC）
roc<-roc(hearttest$TenYearCHD,pre)
plot(roc,print.auc=TRUE,auc.polygon=TRUE,grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue",print.thres=T)
roct<-roc(hearttrain$TenYearCHD,pret)
plot(roct,print.auc=TRUE,auc.polygon=TRUE,grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue",print.thres=T)

glm2<-update(glm1_steped,.~.-diaBP)
summary(glm2)
hoslem.test(glm2$y,fitted(glm2),g=10)
pre2<-predict(glm2,hearttest,type="response")
roc2<-roc(hearttest$TenYearCHD,pre2)
plot(roc2,print.auc=TRUE,auc.polygon=TRUE,grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue")


glm3<-update(glm1_steped,.~.-diaBP-BMI)
summary(glm3)
hoslem.test(glm3$y,fitted(glm3),g=10)
pre3<-predict(glm3,hearttest,type="response")
roc3<-roc(hearttest$TenYearCHD,pre3)
plot(roc3,print.auc=TRUE,auc.polygon=TRUE,grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue")
#似然比检验(似然比检验的零假设：固定效应模型是冗余的)
lrt<--2*(logLik(glm3)[1]-logLik(glm1_steped)[1])
pchisq(lrt,df=1,lower.tail = FALSE)
#deviance检验
anova(glm3,glm1_steped,test='Chisq')

#特征选择
set.seed(1234)
library(caret)
control<-trainControl(method = "cv",number=10)
control_logistic<-trainControl(method = "boot",number=10)
model_logistic<-train(TenYearCHD~sysBP+age+prevalentHyp+BPMeds+totChol+glucose+BMI+male+diabetes+prevalentStroke+cigsPerDay+education,hearttrain,
                      method="LogitBoost",trControl=control_logistic)
importance1<-varImp(model_logistic,scale=FALSE)
print(importance1)
plot(importance1)

#预测正确率
library(rpart)
rpart.mod<-rpart(TenYearCHD~.,data= hearttrain,
                 method='class',
                 parms=list(prior=c(0.65,0.35),split='gini'),
                 control=tc)
rpart.mod.pru<-prune(rpart.mod,cp=rpart.mod$cptable[which.min(rpart.mod$cptable[,"xerror"]),"CP"])
pred_test<-predict(rpart.mod.pru,test)[,2]
pred_test1<-ifelse(pred_test>=0.5,1,0)
table <- table(as.numeric(pred_test1),as.numeric(test[,15]))
accuracy1[num]<- accuracy1[num]+sum(diag(table))/sum(table)
pred_test.roc<-roc(test$TenYearCHD,pred_test)
auc1[num]=auc1[num]+ pred_test.roc $auc




