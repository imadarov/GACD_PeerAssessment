# Getting and Cleaning Data - peer assessment project

## Assumptions

The script assumes the data will be found in the directory "./UCI HAR Dataset/" structured as it is in the linked archive.

The script requires that the packages "plyr" and "reshape2" are available.

## Use
To repeat the work done in this project:

1) Download source data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2) Unzip to your working directory

3) Execute the script run_analysis.R from that directory

##Functionality

The script imports:
  - test and training datasets X_test.txt and X_train.txt from the UCI HAR data and combines them into a single dataframe X_full using rbind.
  - test and training datasets Y_test.txt and Y_train.txt from the UCI HAR data and combines them into a single dataframe Y_full using rbind.
  - test and training datasets subject_test.txt and subject_train.txt from the UCI HAR data and combines them into a single dataframe subject_full using rbind.
  
The columns of combined dataframe X_full are then named from the features.txt file provided in the archive.

The script identifies the desired columns that include mean() and std() in their name. 

These desired columns of interest are then assigned to a new data frame X_mean_std.

The activity labels for each observation (provided in Y_test.txt and Y_train.txt) are converted from numeric vectors to factors with the corresponding text activity label (found in activity_labels.txt) using the mapvalues function from plyr.

This factor is added as a column to the data frame X_mean_std. 

An additional column containing the subject id for each observation (read in from subjects_test.txt and subjects_train.txt) is also included.

The data frame is then averaged for each subject and activity for each variable by using the melt and dcast functions in the reshape2 library.

The tidy data frame (X_tidy) is then stored by write.table() using row.name=FALSE in tidy_dataset.txt



