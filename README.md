######The assumptions for the project has been based on the discussion in David's FAQ thread and the "Tidy Data" paper by Hadley Wickhlam

######I have not processed the data inside the "Inertial Signals" folder since the information regarding the column names was not provided. 

I assume that the data files are stored as follows ::

* UCI HAR Dataset
       * activity_labels.txt :: *activity list with their codes*
       * features.txt :: *feature list of 561 variables*
       * features_info.txt
       * README.txt
* UCI HAR Dataset/train
       * subject_train.txt :: *identifies the subject*
       * X_train.txt :: *actual 561 vector measurement*
       * y_train.txt :: *identifies the activity*
* UCI HAR Dataset/test :: *similar to the data in the train folder*
       * subject_test.txt
       * X_test.txt
       * y_test.txt

The files in the repo are as follows: 

* run_analysis.R : *Code for processing and preparing the tidy data*

* CodeBook.md : *Provides description of the data fields in the tidy data*

* codebook.r : *R script for preparing the codebook*

* tidy_data.txt : *Final output! Stored with coursera*

* Readme.md : *This file!* 


####PART 1 - Merges the training and the test sets to create one data set


The data is read from the train and test folders and merged together. The files are read using read.table() and stringsAsFactors=FALSE.

1. Read subject_train.txt, X_train.txt and y_train.txt and merge it into merge_train. cbind() function is used to merge the three data files.

      ```
      subject_train + y_train + X_train ---(merge)--->> merge_train 
      ```


2. Read subject_test.txt, X_test.txt and y_test.txt and merge it into merge_test cbind() function is used to merge the three data files.

      ```
      subject_test + y_test + X_test ---(merge)--->> merge_test 
      ```

3. Finally merge the two data tables from above into one : merged_data, using rbind().

      ```
      merge_train + merge_test ---(merge)--->> merged_data
      ```

The intermediate files are removed using the rm() function.



####PART 2 - Extracts only the measurements on the mean and standard deviation for each measurement
         
1. Read the features.txt to get the names of the 561 variables that were 
measured.
2. I have then cleaned up the variable list, and removed the special characters. The following "()","-","," were removed from the variable names.
The feature list is a character vector of 561 variables. Since the x_train was combined with the y_train and subject_train data, it has two more variables. These variables contain the subject and activityCode. So the merged data has 563 columns. 
3. To add the first two column names a new data frame is then prepared for the subject and activityCode. This is then merged with the feature list.
4. This features list is then used as names for the columns in the merged data frame.
5. Grep() function is then used to create a list of measurements which have '[Mm]ean' or 'std' in their column names. The "[Mm]" argument ensures that both "Mean" and "mean" are selected.
6. This list (mean_std_cols) is then used to select only the mean and standard deviation from the merged data. This new data table is called as mean_std_data<br>
*Selecting only the mean and standard deviation data removes the columns with duplicate names.*<br> 
*Also note that I have included the angular readings, in the mean_std_data. This angular data may be required when the data is analyzed.*<br>
gravityMean<br>
tBodyAccMean<br>
tBodyAccJerkMean<br>
tBodyGyroMean<br>
tBodyGyroJerkMean<br>

####PART 3 - Uses descriptive activity names to name the activities in the data set
         

1. In this I have read the activity names from the activity_labels.txt file.
2. This data table is then used to replace the activity code with the activity description using the join() function from the plyr package. 

>>><h6>This is similar to the case study regarding Individual-level mortality rates in the "Tidy Data" paper by Hadley Wickham (see Pg.16), where the cod(cause of death) column the codes are replaced with the actual description for the cause of death. This makes the data more readable.</h6>

3. The two tables are joined using the activityCode. So a new column is added with the description of the activity (ie. "Walking","Sitting"...etc)
4. The activity column is the last column in the table and may not be visible when you view the data. So I have copied the values of this column over the activity codes column (which is the 2nd column in the table) After copying the data the last column is dropped. This is done to avoid keeping duplicate information in the data table.

####PART 4 - Appropriately label the data set with descriptive variable names
         

1. Then I use the sub() function to give more descriptive names to the variables
2. The sub() function is used over the mean_std_cols list
3. The above list is then used to rename the column names of the data file (mean_std_data) and stored as part4_data<br>
Intermediate data tables are removed using the rm() function

####PART 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
                 

1. Group_by() and summarize functions from the dplyr package are then used to prepare the final part of this project.The %>% operator is used in this step.
2. The group_by function is used to first group the data table obtained from PART (4). This function groups the data by subject and activity.
3. Then the summarise_each() function is used to calculate the means of each of the measurements. 
4. This final data table is then written to a text file using write.table() function. The summarized data is stored in the "tidy_data.txt" file.


####How to read the tidy data

Kindly use the following code to read the tidy data into your R environment

```R
summary_data<- read.table("tidy_data.txt",header=TRUE,stringsAsFactors=FALSE)
```

The parameters header=TRUE is set since I have stored the variable name with the file to make it easier to read the data<br>
stringsAsFactors = FALSE is kept so that the data is coerced into their respective classes (either as a character or a numeric vector)
This will make it easier to analyze the data 

<h6>The code for preparing the CodeBook.md is kept in codebook.R</h6>
<br>
<br>
<br>






