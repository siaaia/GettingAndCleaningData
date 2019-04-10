# Getting and Cleaning Data Course Project

## Data input

The [UCI HAR Dataset] represents Human Activity Recognition data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone. 

See `UCI HAR Dataset/README.txt` and the [original source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for further documentation.

## R Script

The script [run_analysis.R](run_analysis.R) checks for a folder `UCI HAR Dataset` in the working directory; if this folder is not found, the [UCI HAR Dataset] is downloaded and and unzipped in the working directory.

The script then performs the following:

1. Merges the training and test sets to create one dataset.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See comments in [run_analysis.R](run_analysis.R) for further documentation.

## Output

[run_analysis.R](run_analysis.R) writes its output to a text file named `analysis_result.txt`.

See the [codebook](codebook.md) for the description of this file.

[UCI HAR Dataset]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip