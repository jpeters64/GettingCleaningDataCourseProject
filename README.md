##Getting and Cleaning Data Course Project README
Jeremy Peters

This repository contains the R code and documentation files for the coursera Data Science "Getting and Cleaning data" course 

## Project Objective
The objective of this project is to demonstrate your ability to collect, work with, and clean a data set in order to prepare it  for subsequent analysis.

##Project Data Source 
A full description of the data used in this project can be found at the following UCI Machine Learning Repository URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data source used in this project was download from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Project Tasks
Create one R script called run_analysis.R that does the following:
 1. Merge the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. Creates a second, independent tidy data set with the average of each
    variable for each activity and each subject.



## Program run_analysis.R

run_analysis.R file contains all the code to perform the project tasks described above
CodeBook.MD file  contains information about the data used, variables created, and transformations performed in run_analysis.R.
combinedDatasetSummary.txt file contains the output of the program as described by task 5 above

In order to run the program do the following:
a. Download the "getdata_projectfiles_UCI HAR Dataset.zip" file from the URL specified above
b. Unzip it unmodified into you R working directory so that you see a "UCI HAR Dataset" directory directly under your R working directory
c. Import run_analysis.R into RStudio



