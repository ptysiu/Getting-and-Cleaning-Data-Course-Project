##Script that that will be used while completing the course Getting and Cleaning Data: 
## The script will:
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## 3. From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.


## function reads the data from the files specified as variables
## Arguments
## measurementFilePath - path to the file with measurements
## activityFilePath - path to the file with names of activities
## subjectFilePath - path to the file with the subjects
## featuresFilePath - path to the file with names of the features
## activityDictFilePath - path to the file with the description of the activities. 

parseSourceFiles <- function (measurementFilePath, activityFilePath, subjectFilePath, featuresFilePath = "./Data/features.txt", activityDictFilePath = "./Data/activity_labels.txt") {
  
  ## Reading the measurement data from the file 
  measurementRawData <- read.csv(measurementFilePath, sep = "", header = FALSE)
  
  ## Reading the features data from the file. It will be used 
  ## to label the respective columns of the measurements 
  featuresRawData <- read.csv(featuresFilePath, sep = "", header = FALSE)
  
  ## Adding column names to the measurements data by transposing the featuresRawData 
  ## and applying the column names from featuresRawData to measurements tibble 
  featuresRawData <- t(featuresRawData)
  colnames(measurementRawData) <- featuresRawData[2, ]
  ## Selecting the variables that contain either "mean" or "std"
  ##measurementRawData <- select(measurementRawData, contains("mean"), contains("std"))
  measurementRawData <- select(measurementRawData, matches("^(t|f).*(mean|std).*"))
  
  ## Reading the identifiers of the subject data
  subjectRawData <- read.csv(subjectFilePath, sep = "", header = FALSE, col.names = c("SUBJECT_ID"))
  
  ## Reading activity IDs and its full named references
  activityRawData <- read.csv(activityFilePath, sep = "", header = FALSE, col.names = c("ACTIVITY"))
  activityDict <- read.csv(activityDictFilePath, sep = "", header = FALSE, col.names = c("Index", "Activity"))  
  
  ## Replacing the activity IDs with the Activity Names from the Dictionary File
  activityNames <- factor(activityRawData[, 1], levels = activityDict$Index)
  levels(activityNames) <- activityDict$Activity
  
  ## Creating the output data by merging Raw Data, reworked 
  rawData <- bind_cols(subjectRawData, Activity_Name = activityNames, measurementRawData)
  tibble(rawData)   
  
}