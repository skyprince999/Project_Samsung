(1) Merges the training and the test sets to create one data set. 

There are three files in the Training & Test folders:
1- Subject_train.txt:: Dim(this identifies the subject whose activity was measured
2- y_train.txt:: this identifies the activity of the subject
3- x_train.txt:: this is the actual 561 measurement data

The subject_train along with the y_train gives us the activity and identifies the subject. 
So first the run_analysis.r program merges the three data sets 

subject_train + y_train + x_train ----(merged)--->>> merged_train.txt

The same process is performed on the test data
subject_test + y_test + x_test ----(merged)--->>> merged_test.txt

The two merged data sets are then merged into a single data set
merged_test + merged_train ---(merged)--->>> merged_data.txt


The Inertial data is not merged since:
1) Based on David's FAQ, the column names are not available, so I cannot classify them into mean or std

the features file is then read and processed to get column names for the merged data


(2) Extracts only the measurements on the mean and standard deviation for each measurement. 

Using grep to acquire column names with "[Mm]ean" OR "std" 
Then forming a data set with subject,activity code and the column names that were pulled from the grep step

(3)Uses descriptive activity names to name the activities in the data set

Now I rename the activity rows,by replacing the activity code with the actual activity to make the data more readable 

(4) Appropriately labels the data set with descriptive variable names.

Labeled the dataset variables

(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject







