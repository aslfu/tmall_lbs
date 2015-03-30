setwd("~/Downloads/tianchi")

user<-read.csv("tianchi_mobile_recommend_train_user.csv")
item<-read.csv("tianchi_mobile_recommend_train_item.csv")

user$time<-as.Date(as.character(user$time),format="%Y-%m-%d %H")

train<-subset(user,time<"2014-12-18")
test<-subset(user,time=="2014-12-18")

a<-unique(subset(train,is.element(item_id,item$item_id))[,c("user_id","item_id")])
referenceSet<-unique(subset(test,is.element(item_id,item$item_id)&behavior_type==4)[,c("user_id","item_id")])

referenceSet$label<-TRUE
trainSet<-merge(a,referenceSet,by=c("user_id", "item_id"), all.x=TRUE)
trainSet$label[is.na(trainSet$label)] <- FALSE 
table(trainSet$label) # FALSE 516667 TRUE 162
