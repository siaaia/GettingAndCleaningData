require(data.table)

###########################
# Download and unzip data #
###########################
if (!file.exists("./UCI HAR Dataset")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
    "data.zip")
  unzip("data.zip")
}

###############################################################################
# 1. Merge the training and the test sets to create one data set.             #
###############################################################################

# Merge the training and test data
Xtrain <- fread("./UCI HAR Dataset/train/X_train.txt")
Xtest  <- fread("./UCI HAR Dataset/test/X_test.txt")
Xdata <- rbind(Xtrain, Xtest)

# Merge the training and test y-values (activity ID)
ytrain <- fread("./UCI HAR Dataset/train/y_train.txt")
ytest  <- fread("./UCI HAR Dataset/test/y_test.txt")
ydata  <- rbind(ytrain, ytest)

# Merge the training and test values for subject ID
subjtrain <- fread("./UCI HAR Dataset/train/subject_train.txt")
subjtest  <- fread("./UCI HAR Dataset/test/subject_test.txt")
subjdata  <- rbind(subjtrain, subjtest)

###############################################################################
# 2. Extract only the measurements on the mean and standard deviation         #
#    for each measurement.                                                    #
###############################################################################

# Extract the feature names from a file
features <- fread("./UCI HAR Dataset/features.txt")
feature_names <- unlist(features[,2])

# Assign extracted feature names to the data set
names(Xdata) <- feature_names

# Extract only the columns with names containing either 'mean()' or 'std()'
target_colnames <- grep(".*mean\\(\\).*|.*std\\(\\).*", feature_names, value=TRUE)
target <- Xdata[, ..target_colnames]

###############################################################################
# 3. Use descriptive activity names to name the activities in the data set    #
###############################################################################

# Extract the activity labels from a file
activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt")
activity_names <- unlist(activity_labels[,2])

# Add activity ID to the dataset as a factor, labeled with the activity names
target$activity <- factor(ydata[[1]], labels=activity_names)

###############################################################################
# 4. Appropriately label the data set with descriptive variable names.        #
###############################################################################

# Descriptive feature names were already assigned in step 2.
#   names(target) == target_colnames
# A descriptive name for the activity factor was already assigned in step 3.
#   target$activity

###############################################################################
# 5. From the data set in step 4, create a second, independent tidy data set  #
#    with the average of each variable for each activity and each subject.    #
###############################################################################

# Add subject ID to the dataset as as a factor
target$subject  <- factor(subjdata[[1]])

# Cast data, taking the average of each variable for each activity and subject
target_melt <- melt(target, id=c("activity","subject"))
analysis_result <- dcast(target_melt, activity+subject ~ variable, mean)

# Write analysis_result to a text file
write.table(analysis_result, file="analysis_result.txt", row.name=FALSE)

################################
# Cleanup intermediate objects #
################################
rm(Xtrain, Xtest, Xdata, ytrain, ytest, ydata, subjtrain, subjtest, subjdata)
rm(features, feature_names, target_colnames, target)
rm(activity_labels, activity_names)
rm(target_melt)