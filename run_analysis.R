##library(tidyverse)

source("parseSourceFiles.R")
source("cleanupTheData.R")

##Reading Test Data
rawTestData <- parseSourceFiles("./Data/test/x_test.txt", 
                                "./Data/test/y_test.txt", 
                                "./Data/test/subject_test.txt")
rawTestData <- bind_cols(rawTestData, DATA_TYPE  = rep("Test", count(rawTestData)))

##Reading Training Data
rawTrnData <- parseSourceFiles("./Data/train/x_train.txt", 
                               "./Data/train/y_train.txt", 
                               "./Data/train/subject_train.txt")
rawTrnData <- bind_cols(rawTrnData, DATA_TYPE  = rep("Training", count(rawTrnData)))

##Stack those two data sets
fullDataSet <- bind_rows(rawTestData, rawTrnData)

columnsToRetrieve <- colnames(select(rawTestData, -Subject_ID, -Test_Data_Type, -Activity_Name))

for (i in seq_along(columnsToRetrieve)) {
  df <- cleanTheData(rawTestData, columnsToRetrieve[i])
  tidyData <- bind_rows(tidyData, df)
}