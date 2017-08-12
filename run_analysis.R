##########################################################################################################

## Peer-graded Assignment: Getting and Cleaning Data Course Project
## Jeremy Peters
## 8/10/2017

# run_analysis.r File Description:

# This script will execute the following tasks on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Apply descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################



# 1.	Merge the training and the test sets to create one data set

#Optional: set working directory to  where the UCI HAR Dataset was unzipped
#setwd("C:\\JP Docs\\Data Science Certification\\WD");

# Read in the data from the list of all features
features     = read.table('UCI HAR Dataset/features.txt',header=FALSE); 

# Read in the data from the  activity name file
activityLabels = read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE); 

# Read in the data from the training files
subjectTrain = read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
xTrain       = read.table('UCI HAR Dataset/train/x_train.txt',header=FALSE); 
yTrain       = read.table('UCI HAR Dataset/train/y_train.txt',header=FALSE); 

# Read in the test data
subjectTest = read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
xTest       = read.table('UCI HAR Dataset/test/x_test.txt',header=FALSE); 
yTest       = read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE); 

#Column names are assigned to the following data frames to help format the dataset and  enable the 
#appending/merging of training and test data frames that have the same colum names: activityLabels, xTrain, yTrain, subjectTrain, xTest, yTest, subjectTest
colnames(activityLabels)  = c('activityId','activityType');

colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";
colnames(subjectTrain)  = "subjectId";

colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";
colnames(subjectTest) = "subjectId";


# The training data frames (xTrain, yTrain and subjectTrain) are combined by columns to produce the trainingDataset data frame
trainingDataset = cbind(yTrain,subjectTrain,xTrain);

# The test data frames (xTest, yTest and subjectTest) are combined by columns to produce the testDataset data frame
testDataset = cbind(yTest,subjectTest,xTest);


# The combined training and test data frames (trainingDataset, testDataset) are combined by rows to produce the combinedDataset data frame
combinedDataset = rbind(trainingDataset,testDataset);




# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a vector for the column names using  the combinedDataset to select the mean and stddev columns
colNames  = colnames(combinedDataset); 


#Search for matches to column name  pattern within each element of a character vector to create a Vector that contains TRUE values for the ID, mean and stddev columns and FALSE for others
meanStdColumns <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames) )

# Subset combinedDataset table to keep only desired columns using the Vector 
combinedDatasetSubset <- combinedDataset[ ,meanStdColumns == TRUE]

# 3. Use descriptive activity names to name the activities in the data set

# Use merge function with a Left outer join to merge the "combinedDatasetSubset" data frame with the "acitivityLabel" data frame to include descriptive activity names
combinedDatasetSubsetLabels = merge(combinedDatasetSubset,activityLabels,by='activityId',all.x=TRUE);



# 4. Appropriately label the data set with descriptive activity names. 

# Use gsub function to replace activity names with  new descriptive activity names in the "combinedDatasetSubsetLabels" data frame
# () are removed
# frequency replaces prefix f 
# time  replaces prefix t
# Mean replaces -mean
# StdDev replaces -std
# Magnitude replaces Mag
# Body replaces BodyBody
# Accelerometer replaces Acc
# Gyroscope replaces Gyro

names(combinedDatasetSubsetLabels)<-gsub("\\()","", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("^f", "frequency", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("^(t)","time", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("-mean","Mean", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("-std","StdDev", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("Mag", "Magnitude", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("BodyBody", "Body", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("Acc", "Accelerometer", names(combinedDatasetSubsetLabels))
names(combinedDatasetSubsetLabels)<-gsub("Gyro", "Gyroscope", names(combinedDatasetSubsetLabels))


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

#Use aggregate function to split the data into subsets and compute summary statistics to include just the mean of each variable for each activity and each subject to produce the "combinedDatasetSummary" data frame variable
combinedDatasetSummary <- aggregate(. ~subjectId + activityId, combinedDatasetSubsetLabels, mean)

#Use the Order function to sort the "combinedDatasetSummary" data frame by subjectId and activityId
combinedDatasetSummary <- combinedDatasetSummary[order(combinedDatasetSummary$subjectId, combinedDatasetSummary$activityId),]

#Use Write.table function to export the "combinedDatasetSummary" data frame into a  tab delimited text file called "combinedDatasetSummary.txt"
write.table(combinedDatasetSummary, "combinedDatasetSummary.txt", row.name=FALSE, sep='\t')



