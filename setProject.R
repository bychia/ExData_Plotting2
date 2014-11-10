# Tested in R Version 3.1.1
# Project Settings / Dataset URL
dataset <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Check if current directory variable exists
if(!exists("currentDir"))
  currentDir <- file.path(getwd())

# Check if directory exists
if(!file.exists(currentDir))
  dir.create(currentDir)

# Check if current working directory equals to currentDir
if(getwd()!= currentDir){
  setwd(currentDir)
  print(paste("Set Working Directory to:", currentDir))
}

# Check if dataset exists in currentDir
if(!file.exists(file.path(currentDir,"dataset.zip"))){
  download.file(dataset, "dataset.zip", method="curl")
  # Unzip data
  unzip("dataset.zip") 
}
