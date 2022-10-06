library(gridExtra)
library(ggplot2)
library(mice)
library(dplyr)
library(pROC)

credit_origin<-read.csv("D://学习//大三上//探索性数据分析//hw2//germancredit.csv",header=T)
id<-c(1:1000)
credit_origin<-data.frame(id,credit_origin)
credit<-sample_n(credit_origin,900,replace = FALSE)
credittest = subset(credit_origin, !credit_origin$id%in%c(credit$id)) #从一个数据框中去掉另一个数据框
credit<-credit[,-1]
credittest<-credittest[,-1]
#设定基准组
credit$checkingstatus1<-factor(as.character(credit$checkingstatus1),levels=c("A11","A12","A13","A14"))
credit$history<-factor(as.character(credit$history),levels=c('A30','A31','A32','A33','A34'))
credit$purpose<-factor(as.character(credit$purpose),levels=c('A410','A40','A41','A42','A43','A44','A45','A46','A47','A48','A49'))
credit$savings<-factor(as.character(credit$savings),levels=c('A61','A62','A63','A64','A65'))
credit$employ<-factor(as.character(credit$employ),levels=c('A71','A72','A73','A74','A75'))
credit$installment<-factor(as.character(credit$installment),levels=c('1','2','3','4'))
credit$status<-factor(as.character(credit$status),levels=c('A91','A92','A93','A94','A95'))
credit$others<-factor(as.character(credit$others),levels=c('A101','A102','A103'))
credit$residence<-factor(as.character(credit$residence),levels=c('1','2','3','4'))
credit$property<-factor(as.character(credit$property),levels=c('A124','A121','A122','A123'))
credit$otherplans<-factor(as.character(credit$otherplans),levels=c('A143','A142','A141'))
credit$housing<-factor(as.character(credit$housing),levels=c('A151','A152','A153'))
credit$job<-factor(as.character(credit$job),levels=c('A171','A172','A173','A174'))
#把数据集中的分类自变量都factor
credit_origin$default<-as.factor(credit_origin$default)
credit_origin$checkingstatus1<-as.factor(credit_origin$checkingstatus1)
credit_origin$history<-as.factor(credit_origin$history)
credit_origin$purpose<-as.factor(credit_origin$purpose)
credit_origin$savings<-as.factor(credit_origin$savings)
credit_origin$employ<-as.factor(credit_origin$employ)
credit_origin$installment<-as.factor(credit_origin$installment)
credit_origin$status<-as.factor(credit_origin$status)
credit_origin$others<-as.factor(credit_origin$others)
credit_origin$residence<-as.factor(credit_origin$residence)
credit_origin$property<-as.factor(credit_origin$property)
credit_origin$otherplans<-as.factor(credit_origin$otherplans)
credit_origin$housing<-as.factor(credit_origin$housing)
credit_origin$cards<-as.factor(credit_origin$cards)
credit_origin$job<-as.factor(credit_origin$job)
credit_origin$liable<-as.factor(credit_origin$liable)
credit_origin$tele<-as.factor(credit_origin$tele)
credit_origin$foreign<-as.factor(credit_origin$foreign)
str(credit_origin)
md.pattern(credit_origin)

#分类自变量可视化
p1<-ggplot(credit,aes(x=checkingstatus1,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='支票账户状况')+theme(legend.position = "bottom")
p2<-ggplot(credit,aes(x=history,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='信贷历史')+theme(legend.position = "bottom")
p3<-ggplot(credit,aes(x=purpose,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='借款目的')+theme(legend.position = "bottom")
p4<-ggplot(credit,aes(x=savings,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='存款数')+theme(legend.position = "bottom")
p5<-ggplot(credit,aes(x=employ,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='工作年数情况')+theme(legend.position = "bottom")
p6<-ggplot(credit,aes(x=installment,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='分期付款率占可支配收入的百分比')+theme(legend.position = "bottom")
p7<-ggplot(credit,aes(x=status,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='个人婚姻状况和性别')+theme(legend.position = "bottom")
p8<-ggplot(credit,aes(x=others,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='其他担保人')+theme(legend.position = "bottom")
p9<-ggplot(credit,aes(x=residence,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='至今居住')+theme(legend.position = "bottom")
p10<-ggplot(credit,aes(x=property,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='财产状况')+theme(legend.position = "bottom")
p11<-ggplot(credit,aes(x=otherplans,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='其他分期付款计划')+theme(legend.position = "bottom")
p12<-ggplot(credit,aes(x=housing,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='住房情况')+theme(legend.position = "bottom")
p13<-ggplot(credit,aes(x=cards,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='该银行现有的信贷数量')+theme(legend.position = "bottom")
p14<-ggplot(credit,aes(x=job,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='工作情况')+theme(legend.position = "bottom")
p15<-ggplot(credit,aes(x=liable,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='还款人数')+theme(legend.position = "bottom")
p16<-ggplot(credit,aes(x=tele,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='是否有电话')+theme(legend.position = "bottom")
p17<-ggplot(credit,aes(x=foreign,fill=default))+geom_bar(width = 0.5,position='fill')+
  labs(x="",y="比率",title='是否有外国劳工')+theme(legend.position = "bottom")  
grid.arrange(p1,p2,p3,p4,p5,p6,ncol=3,newpage = T)
grid.arrange(p7,p8,p9,p10,p11,p12,ncol=3,newpage = T)
grid.arrange(p13,p14,p15,p16,p17,ncol=3,newpage = T)

#连续自变量可视化
p18<-ggplot(credit,aes(x=default,y=duration,fill=default))+geom_boxplot(width = 0.5,show.legend = FALSE)+
  labs(x="是否违约",y="duration",title='持续时间')+theme(legend.position = "bottom")
p19<-ggplot(credit,aes(x=default,y=amount,fill=default))+geom_boxplot(width = 0.5,show.legend = FALSE)+
  labs(x="是否违约",y="借款金额",title='借款金额')+theme(legend.position = "bottom")
p20<-ggplot(credit,aes(x=default,y=age,fill=default))+geom_boxplot(width = 0.5,show.legend = FALSE)+
  labs(x="是否违约",y="年龄",title='年龄')+theme(legend.position = "bottom")
grid.arrange(p18,p19,p20,ncol=3,newpage = T)

#全模型放入AIC的logistic回归
#model
glm1<-glm(default~.,family=binomial(link="logit"),data=credit)
glm1_steped<-step(glm1,k=2)
summary(glm1)
summary(glm1_steped)
#卡方检验
pchisq(glm1_steped$deviance,glm1_steped$df.residual,lower.tail = FALSE)
anova(glm1_steped,test='Chisq') #发现amount,age,others,housing在0.05的显著性水平下不显著

#推断
exp(glm1_steped$coefficients) #OR估计

#预测
pre<-predict(glm1_steped,credittest,type="response")

#预测效果（ROC）
roc<-roc(credittest$default,pre)
plot(smooth(roc),print.auc=TRUE,auc.polygon=TRUE,grid.col=c("green","red"),max.auc.polygon=TRUE,auc.polygon.col="skyblue")


#去掉amount,age,liable
glm2<-update(glm1_steped,.~.-liable)
summary(glm2)
#卡方检验
pchisq(glm2$deviance,glm2$df.residual,lower.tail = FALSE)
#似然比检验(似然比检验的零假设：固定效应模型是冗余的)
lrt<--2*(logLik(glm2)[1]-logLik(glm1_steped)[1])
pchisq(lrt,df=1,lower.tail = FALSE)#拒绝原假设








#不显著分类变量取值分组后
creditgrp<-credit
for(i in (1:900)){
  if(creditgrp$purpose[i] %in% c('A410','A44','A45','A46','A48','A49')){
    creditgrp$purpose[i]<-'others'
  }}
for(i in (1:900)){
  if(creditgrp$savings[i] %in% c('A62','A63')){
    creditgrp$savings[i]<-'others'
  }}
for(i in (1:900)){
  if(creditgrp$status[i] %in% c('A92','A94')){
    creditgrp$status[i]<-'others'
  }}
creditgrp$purpose<-as.factor(creditgrp$purpose)
creditgrp$savings<-as.factor(creditgrp$savings)
creditgrp$status<-as.factor(creditgrp$status)
glmgrp<-glm(default~.,family=binomial(link="logit"),data=creditgrp)
glmgrp_steped<-step(glmgrp,k=2)
summary(glmgrp_steped)
pchisq(glmgrp_steped$deviance,glmgrp_steped$df.residual,lower.tail = FALSE)
anova(glmgrp_steped,test='Chisq')

