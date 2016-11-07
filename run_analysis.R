#Getting and Cleaning Data Course Project
#November  6, 2016 - Derpfrog
######################################
# This script will:
# Download the data.
# Merges the training and the test sets to create one data set.
# Extract only the measurements on the mean and standard deviation for each measurement.
# Use descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

#load libraries
library(dplyr)

#Download data
if(!file.exists("./data")){dir.create("./data")}
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, destfile = "./data/acc.zip")


#Create a list of the files in the zip folder
ziplist<-unzip("./data/acc.zip", list = TRUE)

#Unzip downloaded file
unzip("./data/acc.zip")

#Read data into R
featureNames <- read.table(ziplist[2,1])
Alabels <- read.table(ziplist[1,1])
X_test <- read.table(ziplist[17,1])
y_test <- read.table(ziplist[18,1])
y_train <- read.table(ziplist[32,1])
X_train <- read.table(ziplist[31,1])
test_subject <- read.table(ziplist[16,1])
train_subject <- read.table(ziplist[30,1])

#Add proper colnames for the test and train dataset
names(X_test)<-featureNames[,2]
names(X_train) <- featureNames[,2]

#Add proper colnames for y datasets and Subjects
names(y_train)<- "Activity"
names(y_test)<- "Activity"
names(test_subject)<- "Subject"
names(train_subject)<- "Subject"

#Add activity labels to y data sets by modifying the factor level names
y_train$Activity <- as.factor(y_train$Activity)
levels(y_train$Activity)<- Alabels$V2
y_test$Activity <- as.factor(y_test$Activity)
levels(y_test$Activity)<- Alabels$V2

#Find cols with requested data std() and Mean()
std <- grep("std()", names(X_train), fixed = TRUE)
m <- grep("mean()", names(X_train), fixed = TRUE)

#Make a final list of all the cols for easy subsetting
s <-append(std, m)

#subset X_train and X_test & add in activity as well as subject column y_train and Y_test
X_train_sub <- X_train[,s]
X_train_sub$Activity <- y_train$Activity
X_train_sub$Subject <- train_subject$Subject
X_test_sub <- X_test[,s]
X_test_sub$Activity <- y_test$Activity
X_test_sub$Subject <- test_subject$Subject

#merge train and test set into one data set
all_data <- rbind(X_test_sub, X_train_sub)

#Group all_data by Subjectt and Activity and find the mean for each variable.  Write this data to file. 
tidy <- all_data %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(tidy, "tidy_2016.txt", row.names = FALSE)
