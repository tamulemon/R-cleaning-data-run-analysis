R-cleaning-data-run-analysis
============================

This is the runanalysis R code to clean up dataset for the project

* The two libraries needed are dplyr and reshape2
* Before anything, set the working directory to where the data is saved.

Steps:
1.Merges the training and the test sets to create one data set.
  - Add the columns of "activities" and "subject" to test and training dataset before combining them. "activities" column stores data from "activity_labels.txt". "subject
  - Combine 2 datasets into 1 by calling rbind. Rename all the columns using the names stored in table "features".

2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  - First to extract all columns whose headers contain "mean()" or "std()".Ignor cases.
  - Also, activities and subject columns are included for future usage. 
  - Columns whose headers contain "meanFreq()" or "stdFreq()" are not included because the way they are described in project     instruction implies they should be treated differently. In other words, they are not "measurement" mean or stdev.

3.Uses descriptive activity names to name the activities in the data set
  - Merge the final dataset and the "activities" table, which populates levels of activities with meaningful names. 

4.Appropriately labels the data set with descriptive variable names. 
  - This is already done in step 1.

5.Create an independent tidy data set with the average of each variable for each activity and each subject.
  - Use the melt-dcast function to calculate means for each column, for each "activity" and each "subject".
  - Write the data as a txt file and try to re-read it into R.
  - Compare the head of the original "avetable" and "testtable", and they are the same. 

