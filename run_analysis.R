# Download the file and unzip, then import as R object.

# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

# From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

library(dplyr)
rm(list = ls())
setwd("~/Code/GettingCleaningData")
my.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = my.url, destfile = "Dataset.zip", method = "curl")
unzip(zipfile = "Dataset.zip")

read.table(file = "UCI HAR Dataset/train/X_train.txt") -> train_data.df
read.table(file = "UCI HAR Dataset/test/X_test.txt")   -> test_data.df

read.table(file = "UCI HAR Dataset/train/subject_train.txt") -> train_subject.v
read.table(file = "UCI HAR Dataset/test/subject_test.txt")   -> test_subject.v

read.table(file = "UCI HAR Dataset/features-mean-sd.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE) -> selected.features

temp.1 <- data.frame(train_subject.v, train_data.df)
temp.2 <- data.frame(test_subject.v,  test_data.df)

rbind(temp.1, temp.2) -> data.df

data.2.df <- data.df[, c(1, selected.features$V1)]

my.labels <- c("ID", selected.features$V2)
names(data.2.df) <- my.labels

grouped <- group_by(data.2.df, ID)
activities.mean <- summarise_each(grouped, funs(mean))

write.table(activities.mean, file = "my_tidy_data.txt", row.names = FALSE)
