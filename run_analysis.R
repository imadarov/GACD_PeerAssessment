library(plyr)
library(reshape2)

# Show message because loading data may take a while
message("Loading data... ", appendLF = F)

# Import the test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Import the training data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Show loading done message
message("Done\n")

# Step 1) Merge the training and the test sets to create one data set.

X_full<-rbind(X_test, X_train)
Y_full<-rbind(Y_test, Y_train)
subject_full<-rbind(subject_test, subject_train)

# Naming the columns in X_full from features.txt
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(X_full)<-features[,2]

# Step 2) Extract only the measurements on the mean and standard deviation for each measurement.

# The desired columns are labeled using mean and std
desiredcols<- grepl("mean()",colnames(X_full)) | grepl("std()",colnames(X_full))

# Then put the desired columns in a new data frame:
X_mean_std <- X_full[,desiredcols]

# Step 3) Uses descriptive activity names to name the activities in the data set

# The activity labels are found in a activity_labels.txt file
activities<-read.table("./UCI HAR Dataset/activity_labels.txt")

# Prepare a factor 
Y_factor <- as.factor(Y_full[,1])
Y_factor <- mapvalues(Y_factor,from = as.character(activities[,1]), to = as.character(activities[,2]))

# Step 4) Appropriately labels the data set with descriptive activity names. 

# Y_factor is now a factor with the 6 named levels, it can be added to X_mean_std using cbind
X_mean_std <- cbind(Y_factor, X_mean_std) 

# Change the first column name to "activity"
colnames(X_mean_std)[1] <- "activity"

# Step 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Adding also column for subject IDs
X_mean_std <- cbind(subject_full, X_mean_std)
colnames(X_mean_std)[1] <- "subject"

# The tidy data can be done using the reshape functions 
X_melt<- melt(X_mean_std,id.vars=c("subject","activity"))
X_tidy <- dcast(X_melt, subject + activity ~ ..., mean)

# Show message for writing data
message("Writing data... ", appendLF = F)

# Write tidy dataset file
write.table(X_tidy, file="tidy_dataset.txt", row.names = FALSE)

# Show writing done message
message("Done\n")

