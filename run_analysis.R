############################################################################
## Windows 7 OS  R ver 3.1.2 
## Part 1 - Merges the training and the test sets to create one data set.
## 
############################################################################

library(plyr)
library(dplyr)

setwd("D:/Data Science - Getting and Cleaning Data/Project_Samsung")
#setwd("./Project_Samsung")

subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",stringsAsFactors=FALSE)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",stringsAsFactors=FALSE)
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt",stringsAsFactors=FALSE)

subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors=FALSE)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors=FALSE)
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors=FALSE)

merge_train<-cbind( subject_train,y_train,x_train)
merge_test<-cbind(subject_test,y_test,x_test)
merged_data<-rbind(merge_train,merge_test)

#rm(merge_train,merge_test,subject_train,subject_test,y_train,y_test,x_train,x_test)

############################################################################
## Part 2 - Extracts only the measurements on the mean and standard 
##          deviation for each measurement
############################################################################


features_names<-read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
names(features_names)<-c("code","features")

features_names$features<-gsub("\\(","",features_names$features)
features_names$features<-gsub("\\)","",features_names$features)
features_names$features<-gsub("\\-","",features_names$features)
features_names$features<-gsub("\\,","",features_names$features)


new_rows<-data.frame(code=c(1,2),features=c("subject","activityCode"))
features_names<-rbind(new_rows,features_names)
features_names$code<-c(1:563)
names(merged_data)<-features_names$features


mean_std_cols<-grep("[Mm]ean|std",names(merged_data),value=TRUE)
mean_std_cols<-c("subject","activityCode",mean_std_cols)
mean_std_data<-merged_data[,c(mean_std_cols)]

############################################################################
## Part 3 - Uses descriptive activity names to name the activities in the 
##          data set
############################################################################

activity<-read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
names(activity)<-c("activityCode","activity")

part4_data<-join(mean_std_data,activity,by="activityCode")
part4_data$activityCode<-part4_data$activity
part4_data<-part4_data[,c(1:88)]


############################################################################
## Part 4 - Appropriately labels the data set with descriptive variable 
##          names
############################################################################

mean_std_cols<-sub("^t","time",mean_std_cols)
mean_std_cols<-sub("^f","freq",mean_std_cols)
mean_std_cols<-sub("Acc","Acceleration",mean_std_cols)
mean_std_cols<-sub("Gyro","Gyroscope",mean_std_cols)
mean_std_cols<-sub("Mag","Magnitude",mean_std_cols)
mean_std_cols<-sub("mean","Mean",mean_std_cols)
mean_std_cols<-sub("std","StdDeviation",mean_std_cols)
mean_std_cols<-sub("gravity","Gravity",mean_std_cols)
mean_std_cols<-sub("BodyBody","Body",mean_std_cols)
names(part4_data)<- mean_std_cols 

#rm(activity,new_rows,merged_data,features_names,mean_std_data,mean_std_cols)

############################################################################
## Part 5 - From the data set in step 4, creates a second, independent 
##          tidy data set with the average of each variable for each 
##          activity and each subject
############################################################################


tidy_data<- part4_data %>% 
              group_by(subject,activityCode) %>%
                summarise_each(funs(mean))

write.table(tidy_data,"tidy_data.txt",row.names=FALSE)
#rm(part4_data)
