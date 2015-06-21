---
title: "README"
author: "Alex Bergin"
date: "Sunday, June 21, 2015"
output: html_document
---

Main Script file:
run_analysis.R

Input:
UCI HAR data set

Output:
submission file containing the aggregate mean of all features containing "mean" & "std" grouped by subject & activity

Steps:
1: read in all files using read.table
2: assign variable names appropriately
3: combine x,y,subject for test/train and then test/train using rbind/cbind
4: subset the data to the selected feature rules using grep
5: aggregate the data as per requirements


requirements:
 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

