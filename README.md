R-cleaning-data-run-analysis
============================

This is the runanalysis R code to clean up dataset for the project

* The two libraries needed are dplyr and reshape2
* Before anything, set the working directory to where the data is saved.

Steps:
1.Merges the training and the test sets to create one data set.
  Frist read all tables into R.
  - Add the columns of "activities" and "subject" to test(X_test.txt) and training(X_train.txt) datasets before combining        them. 
    For test dataset: "activities" column store data from "y_test.txt". "subject" stores data from "subject_test.txt" table. 
    For training dataset: "activities" stores data from "y_train.txt". "subject" stores data from "subject_train.txt" table. 
  - Combine 2 datasets into 1 by calling rbind. Rename all the columns using the names stored in table "features.txt".

2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  - First to extract all columns whose headers contain "mean()" or "std()".Ignor cases.
  - Also, activities and subject columns are included for future usage. 
  - Columns whose headers contain "meanFreq()" or "stdFreq()" are not included because the way they are described in project     instruction implies they should be treated differently. In other words, they are not "measurement" mean or stdev.

3.Uses descriptive activity names to name the activities in the data set
  - Merge the final dataset and data from "activity_labels.txt". This populates levels of activities with meaningful names.
  - A detailed analysis reveals that "fBodyAccJerkMag", "fBodyGyroMag","fBodyGyroJerkMag" related measurements are described     in the "features_info.txt" file yet missing from the "features.txt" table. Instead, there are a set of columns in       "features.txt" that describe "fBodyBodyAccJerkMag", "fBodyBodyGyroMag", "fBodyBodyGyroJerkMag" measurements. It is understood     as that the system mislabled these measurements by duplicating the word "Body". To match the description in the original     data description, these columns are renamed in the final output.

4.Appropriately labels the data set with descriptive variable names. 
  - This is already done in step 1 and step 3.

5.Create an independent tidy data set with the average of each variable for each activity and each subject.
  - Use the melt-dcast functions to calculate means for each column, for each "activity" and each "subject".
  - Write the data as a txt file and try to re-read it into R.
  - Compare the head of the original "avetable" and "testtable", and they are the same. 

