library(dplyr)
library(reshape2)
### set the working directory to where the data is saved.
# Read all tables into R
setwd("~/R/Cleaning Data/Project/UCI HAR Dataset/")
features<-read.table("features.txt")
activities<-read.table("activity_labels.txt")
subject_test<-read.table("./test/subject_test.txt")
testset<-read.table("./test/X_test.txt")
testlabels<-read.table("./test/y_test.txt")
subject_train<-read.table("../UCI HAR Dataset/train/subject_train.txt")
trainset<-read.table("../UCI HAR Dataset/train/x_train.txt")
trainlabels<-read.table("../UCI HAR Dataset/train/y_train.txt")

### 1.Merges the training and the test sets to create one data set.
# Add the columns of "activities" and "subject" to test and training dataset before combining them.
testset1 <-cbind(testset, testlabels,subject_test)
colnames(testset1)[c(562,563)]<-c("activities","subject")
trainset1<-cbind(trainset,trainlabels,subject_train)
colnames(trainset1)[c(562,563)]<-c("activities","subject")
# Combine 2 datasets into 1 by calling rbind. Rename all the columns using the names stored in table "features".
combinedset<-rbind(testset1,trainset1 )
colnames(combinedset)[c(1:561)]<-as.vector(features[,2])

### 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# Extract all columns whose headers contain "mean()" or "std()".Ignor cases.
# Also, activities and subject columns are included for future usage. 
# Columns whose headers contain "meanFreq()" or "stdFreq()" are not included because the way they are described in project instruction 
# implies they should be treated differently. In other words, they are not "measurement" mean or stdev.
final<-select(combinedset,grep("mean()",colnames(combinedset),fixed=T),
              grep("std()",colnames(combinedset),fixed=T),
              activities,subject)

### 3.Uses descriptive activity names to name the activities in the data set
# Merge the final dataset and the "activities" table, which populates levels of activities with meaningful names. 
showActivities<-merge(final, activities, by.x="activities", by.y="V1") %>%
  select(-activities) 
colnames(showActivities)[68]<-"activities"
### 4.Appropriately labels the data set with descriptive variable names. 
# Already done in step 1.

### 5.Create an independent tidy data set with the average of each variable for each activity and each subject.
# Use the melt-dcast function to calculate means for each column, for each "activity" and each "subject".
# Write the data as a txt file and try to re-read it into R.
# compare the head of the original "avetable" and "testtable", and they are the same. 
dataMelt<-melt(showActivities, id=c("subject","activities"))
avetable<-dcast(dataMelt,formula=activities+subject~...,mean)
head(avetable)
write.table(avetable, file = "Tidy data average.txt", row.names = F)
testtable<-read.table("Tidy data average.txt", header = T,check.names = F)
head(testtable)

