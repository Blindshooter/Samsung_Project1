library(plyr)
library(reshape2)
y_test <- read.table("~/Samsung/test/y_test.txt", quote="\"")
X_test <- read.table("~/Samsung/test/X_test.txt", quote="\"")
subject_test <- read.table("~/Samsung/test/subject_test.txt", quote="\"")
subject_train <- read.table("~/Samsung/train/subject_train.txt", quote="\"")
y_train <- read.table("~/Samsung/train/y_train.txt", quote="\"")
X_train <- read.table("~/Samsung/train/X_train.txt", quote="\"")
features <- read.table("~/Samsung/features.txt", quote="\"")
activity_labels <- read.table("~/Samsung/activity_labels.txt", quote="\"")

test_data<-cbind(subject_test,y_test,X_test)
train_data<-cbind(subject_train, y_train, X_train)
data<-rbind(test_data,train_data)
data_names<-as.vector(features$V2)
names(data)<-c('Subject','Activity',data_names)
te<- sort(c(1,2,grep('mean()', names(data)),grep('std()', names(data))))#only mean and std values
new_data<-data[,te]
new_data$Activity_name<-activity_labels[new_data$Activity,2] #activity name
melt_data<-melt(new_data, id = c('Subject','Activity','Activity_name'))
tidy_data<-ddply(melt_data, c('Subject','Activity','Activity_name', 'variable'), summarize, mean = mean(value))
write.table(tidy_data, file = '~/tidy_data.txt', row.names= FALSE)
