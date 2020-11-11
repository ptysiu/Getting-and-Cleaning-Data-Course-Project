# Function based on the name of the column splits the data into specific variables and fills the values. 


cleanTheData <- function (sourceData, columnName) {
  
  #Filling the value of the variable Domain
  domain = "N/A"
  if(str_detect(columnName, "^t")) domain = "TIME"
  if(str_detect(columnName, "^f")) domain = "FFT"

  #Filling the value of the variable Signal Source
  signal_source = "N/A"
  if(str_detect(columnName, "Acc")) signal_source = "ACCELERATOMETR"
  if(str_detect(columnName, "Gyro")) signal_source = "GYROSCOPE"

  #Filling the value of the variable Acceleration Signal
  acc_signal = "N/A"
  if(str_detect(columnName, "Body"))   acc_signal = "BODY"
  if(str_detect(columnName, "Grav"))   acc_signal = "GRAVITY"

  #Filling the value of the variable Jerk
  jerk = 'No'
  if(str_detect(columnName, "Jerk")) jerk = 'Yes'

  #Filling the value of the variable Magnitude
  magnitude = 'No'
  if(str_detect(columnName, "Mag")) magnitude = 'Yes'

  #Filling the value of the variable Dimension
  dims = "N/A"
  if(str_detect(columnName, "-X"))   dims = "X"
  if(str_detect(columnName, "-Y"))   dims = "Y"
  if(str_detect(columnName, "-Z"))   dims = "Z"

  #Choose the name respective variable for which the value will be set (mean, std)
  if(str_detect(columnName, "mean"))  col = 'MEAN_VALUE'
  if(str_detect(columnName, "std"))   col  = "STD_VALUE"
  
  ##cols <- c("Subject_ID", "Activity_Name", "Test_Data_Type", columnName)
  
  #select data from Source Data and then add the variables with values
  cleanedData <- select(sourceData, c("Subject_ID", "Activity_Name", "Test_Data_Type", columnName)) %>% 
                        mutate(DOMAIN = domain, 
                        SIGNAL_SOURCE = signal_source, 
                        ACCEL_SIGNALS = acc_signal, 
                        JERK = jerk, 
                        MAGNITUDE = magnitude, 
                        DIMMENSION = dims)
  names(cleanedData)[4] = col
  return(cleanedData)

}