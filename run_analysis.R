## run_analysis.R

## Course project for getting & cleaning data
## requires the samsung wearable data to be the working directory

## last modified: 6/21
## Alex Bergin

## writefiles is a flag the allows the script to write the output files

run_analysis <- function(writefiles = FALSE)
{
  ##read in data items
  ## reads in xTest, xTrain, features, & labels
  ############################################ Test files
  filename <- "UCI HAR Dataset//test//X_test.txt"
  xTest <- read.table(filename)
  filename <- "UCI HAR Dataset//test//y_test.txt"
  yTest <- read.table(filename)
  filename <- "UCI HAR Dataset//test//subject_test.txt"
  subjectTest <- read.table(filename)
  ############################################ Train files
  filename <- "UCI HAR Dataset//train//x_train.txt"
  xTrain <- read.table(filename)
  filename <- "UCI HAR Dataset//train//y_train.txt"
  yTrain <- read.table(filename)
  filename <- "UCI HAR Dataset//train//subject_train.txt"
  subjectTrain <- read.table(filename)
  ############################################ Feature files
  filename <- "UCI HAR Dataset//activity_labels.txt"
  labels <- read.table(filename, stringsAsFactors = FALSE)
  filename <- "UCI HAR Dataset//features.txt"
  features <- read.table(filename)
  
  ##apply column names to the data set
  colnames(xTrain) <- features[[2]]
  colnames(xTest) <- features[[2]]
  colnames(labels) <- c("V1", "activity")
  colnames(subjectTrain) <- "subject"
  colnames(subjectTest) <- "subject"
  
  ## add the activity label
  trainData <- cbind(subjectTrain, yTrain, xTrain)
  testData <- cbind(subjectTest, yTest, xTest)
  
  ## merge the two data sets, keeping all records
  combinedData <- rbind(trainData, testData)
  
  ## grep the feature set for means & sds
  selectedFeatures <- c(1, 2, 
    2+grep("std", features[[2]], ignore.case = FALSE),
    2+grep("mean", features[[2]], ignore.case = FALSE))
  
  ##select only the columns we are interestd in
  selectedData <- combinedData[,selectedFeatures]
  
  mergedData <- merge(selectedData, labels, by.x = "V1", by.y = "V1")
  finalData <- mergedData[, c(2, 82, 3:81)]
    
  ## output the final table
  if(writefiles)
  {
    filename <- "abergin_getdata-015_projectSubmission1.txt"
    write.table(x = finalData,file = filename, row.names = FALSE)
  }
  ##################### Step 5
  output <- aggregate(finalData[,3:81], 
                      by = list(finalData$activity, finalData$subject),
                      FUN = mean)
  colnames(output)[1:2] <- c("activity", "subject")

  if(writefiles)
  {
    filename <- "abergin_getdata-015_projectSubmission2.txt"
    write.table(x = output,file = filename, row.names = FALSE)
  }
  
  ## returnt the final data
  return(output)
}