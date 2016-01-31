# Anuj jain
#run_analysis.R
# Week 4 Assignment

#load libraries
library(dplyr)
library(tidyr)

# check if the director data exists, if not it is created
if(!file.exists("./data")){dir.create("./data")}

# this is the url from where the zip file is downloaded
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# datafile is downloaded only if it doesnt exist
if(!file.exists("./data/Dataset.zip")) {download.file(dataUrl, "./data/Dataset.zip")}

#unzip file
if(!file.exists("./data/DataSt")){unzip("./data/Dataset.zip", exdir ="./data/DataSt")}


# appropriate files are extracted

trainingData <- read.table("./data/DataSt/UCI HAR Dataset/train/X_train.txt")
traininglabel <- read.table("./data/DataSt/UCI HAR Dataset/train/y_train.txt")
testData <- read.table("./data/DataSt/UCI HAR Dataset/test/X_test.txt")
testlabel <- read.table("./data/DataSt/UCI HAR Dataset/test/y_test.txt")
feature <- read.table("./data/DataSt/UCI HAR Dataset/features.txt")
activity <- read.table("./data/DataSt/UCI HAR Dataset/activity_labels.txt")
subjectTest <- read.table("./data/DataSt/UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("./data/DataSt/UCI HAR Dataset/train/subject_train.txt")

#Renaming the Activity Column
colnames(activity)[2] <- "activity"

# Assign a name to the trainingLabel and testlabel tables
names(testlabel) <- "activity"
names(traininglabel) <- "activity"

# Assign a name to the SubjectTrain and subjecttest tables
names(subjectTest) <- "subject"
names(subjectTrain) <- "subject"

# Assign Column Names to TrainingData
names(trainingData) <- feature$V2

# Question 4: Assign Column Names to TestData
names(testData) <- feature$V2

# Add Subject data
subject <- rbind(subjectTrain,subjectTest)

# Add Activity Data
labelData <- rbind(traininglabel, testlabel)

# Add the Activity Column to the TrainingData and TestData tables
#trainingData <- cbind(traininglabel, trainingData)
#testData <- cbind(testlabel, testData)

# Merges Training and Test Data Set into one DataSet
TotalData <- rbind(trainingData, testData)

# Question 2 : Finding data that contains mean() or std()
TotalData <- TotalData[,(grepl("\\-(mean|std)\\(\\)", names(TotalData), ignore.case = TRUE))]

# Merge labelData to TotalData
TotalData <- cbind(subject,labelData, TotalData)

# Clean up the Column Names
names(TotalData) <- gsub("(\\()|(\\)|(-)|(,))", "", names(TotalData))
names(TotalData) <- tolower(names(TotalData))


# Clean up the Column Names
names(TotalData) <- gsub("^t", "time", names(TotalData))
names(TotalData) <- gsub("^f", "freq", names(TotalData))
names(TotalData) <- tolower(names(TotalData))

# Question 3
TotalData <- merge(activity, TotalData, by.x = "V1", by.y = "activity", all=TRUE)
TotalData <- TotalData[,-c(1)]

# Question 5
tidyData <- TotalData %>%
                group_by(subject, activity) %>%
                    summarize_each(funs(mean))

#Outputs the Text File
write.table(tidyData, "tidyData.txt", row.name=FALSE)

#clears all data
rm(list=ls())





