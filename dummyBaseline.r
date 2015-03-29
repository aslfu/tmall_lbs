setwd("~/Downloads/tianchi")
user<-read.csv("tianchi_mobile_recommend_train_user.csv")
item<-read.csv("tianchi_mobile_recommend_train_item.csv")

#length(unique(user$user_id))#user数 10000
user$time<-as.Date(as.character(user$time),format="%Y-%m-%d %H")

train<-subset(user,time<"2014-12-18")
test<-subset(user,time=="2014-12-18")

#length(unique(train$user_id)) #9838
#length(unique(item$item_id))#p中包含314694个item

a<-subset(train,is.element(item_id,item$item_id))
predictionSet<-unique(a[,c("user_id","item_id")])

b<-subset(test,is.element(item_id,item$item_id)&behavior_type==4)
referenceSet<-unique(b[,c("user_id","item_id")])

c<-merge(predictionSet,referenceSet)

######################################
precision<-nrow(c)/nrow(predictionSet)
recall<-nrow(c)/nrow(referenceSet)
F1<-2*precision*recall/(precision+recall)
