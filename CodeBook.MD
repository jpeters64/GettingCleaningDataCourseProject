## Getting and Cleaning Data Course Project Codebook

Jeremy Peters

##Description
Describes the variables, data and  transformations used in the course project


##Data Source 
A full description of the data used in this project can be found at the following UCI Machine Learning Repository URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data source used in this project was download from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


README Data Source Data Set description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The dataset includes the following files that werfe used in this project:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name

- 'train/X_train.txt': Training set

- 'train/y_train.txt': Training labels

- 'test/X_test.txt': Test set

- 'test/y_test.txt': Test labels

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each training window sample. 
- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each test window sample. 




##The script `run_analysis.R` executes the following 5 tasks described in the course project's definition.

1.Merge the training and the test sets to create one data set

a. The following files are read in  table format and the following data frame variables are created for each

Files:			Data Frames:
features.txt		features
activity_labels.txt	activityLabels
x_train.txt		xTrain
y_train.txt		yTrain
subject_train.txt	subjectTrain
x_test.txt		xTest
y_test.txt		yTest
subject_test.txt	subjectTest

b. Column names are assigned to the following data frame variables to help format the dataset and  enable the 
appending/merging of training and test data frames that have the same colum names: activityLabels, xTrain, yTrain, subjectTrain, xTest, yTest, subjectTest

c. The training data frames (xTrain, yTrain and subjectTrain) are combined by columns, using cbind  function, to produce the "trainingDataset" data frame variable

d. The test data frames (xTest, yTest and subjectTest) are combined by columns, using cbind  function,to produce the "testDataset" data frame variable

e. The combined training and test data frames (trainingDataset, testDataset) are combined by rows, using rbind  function, to produce the "combinedDataset" data frame variable


2. Extract only the measurements on the mean and standard deviation for each measurement. 

a. Search for matches to column name  pattern within each element of a character vector to create a Vector that contains TRUE values for the ID, mean and stddev columns and FALSE for others

b. Subset this logcal vector into "combinedDatasetSubset" to keep only the necesary column names that contains TRUE values for the necessary columns to


3 Use descriptive activity names to name the activities in the data set

a. Use merge function with a Left outer join to merge the "combinedDatasetSubset" data frame variable with the "acitivityLabel" data frame to include descriptive activity names

4. Appropriately label the data set with descriptive activity names.

a. Use gsub function to replace activity names with  new descriptive activity names in the "combinedDatasetSubsetLabels" data frame variable
-() are removed
-frequency replaces prefix f 
-time  replaces prefix t
-Mean replaces -mean
-StdDev replaces -std
-Magnitude replaces Mag
-Body replaces BodyBody
-Accelerometer replaces Acc
-Gyroscope replaces Gyro


5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

a. Use aggregate function to split the data into subsets and compute summary statistics to include just the mean of each variable for each activity and each subject to produce the "combinedDatasetSummary" data frame variable

b. Use the Order function to sort the "combinedDatasetSummary" data frame variable by subjectId and activityId

c. Use Write.table function to export the "combinedDatasetSummary" data frame variable into a  tab delimited text file called "combinedDatasetSummary.txt"
