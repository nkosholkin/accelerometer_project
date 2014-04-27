## This is scripit is made to download and make data from 
## accelerometers. These data has been gathered by one study.
## A full description is available at the site where the data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## I assume that your Working Directory is the same as there you have unzip your file from:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## With Numbers (like number list) - are assignments from R-programming Data Project
## I found it better to split all code to the these parts
## I also add comments to the lines so all who see it can understnd what happend and why.


## 1. Merges the training and the test sets to create one data set

## Read both Training set and Test set
xTrain <- read.table("train/X_train.txt")
xTest <- read.table("test/X_test.txt")
## Combine them into one table
xCombined <- rbind(xTrain, xTest) 

## Read both Training labels and Test labels
yTrain <- read.table("train/y_train.txt")
yTest <- read.table("test/y_test.txt")
## Combine them into one table
yCombined <- rbind(yTrain, yTest)

## Read both Training subjects and Test subjects
sTrain <- read.table("train/subject_train.txt")
sTest <- read.table("test/subject_test.txt")
## Combine them into one table
sCombined <- rbind(sTrain, sTest)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Read features table
featuresDate <- read.table("features.txt")
## Search for a particular pattern (words: Mean and Standard deviation) in each element from the Feature table
onlyNeedFeatures <- grep("-mean\\(\\)|-std\\(\\)", featuresDate[ ,2])
## Extracting only "right" columns
xCombined <- xCombined[, onlyNeedFeatures]
## Name each column appropriately their Feature names
names(xCombined) <- features[onlyNeedFeatures, 2]
## Get rid of "()" from column names (its not for the Tiny data principle, but for your eye)
names(xCombined) <- gsub("\\(|\\)", "", names(xCombined))

## 3. Uses descriptive activity names to name the activities in the data set
## and 4. Appropriately labels the data set with descriptive activity names.

## Read activity label table
listOfActivities <- read.table("activity_labels.txt")
## Make a lower case names of each activity (for better reading)
listOfActivities[, 2] = (tolower(as.character(listOfActivities[, 2])))
## Change numbers to names (in terms of activities)
yCombined[,1] = listOfActivities[yCombined[,1], 2]
## Give the normal name the acitivty column
names(yCombined) <- "Activity_Name"
## Give the name the subject column
## We use "ID" in name since there is only numbers
names(sCombined) <- "Subject_ID"
## Combine all table by column
final_table <- cbind(sCombined, yCombined, xCombined)
## Write this table in .txt file in the current Working Directory
write.table(final_table, "final_table_mean_std_merged.txt")

## 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

## Find all unique subjects and return a vector without subjects duplicating
uniqSubjects = unique(sCombined)[,1]
## Total unique subjects
totalSubjects = length(uniqueSubjects)
## Total activities (they are all unique, hence we dont count them unique as
## in for subjects). We use [,1] to make a value from a vector.
totalActivities = length(listOfActivities[,1])
## Total columns in our final merges table
totalCol = ncol(final_table)
## A table with 68 columns (2 for Acitivity_name and Subject_ID) and 
## 180 rows (since there are 6 activities and 30 subjects)
tidy = final_table[1:(totalSubjects*totalActivities), ]

## Start with the first row
row = 1
## Loop over all subjects
for (s in 1:totalSubjects) {
        ## Loop over all activities as well
        for (a in 1:totalActivities) {
                ## Choose subject
                tidy[row, 1] = uniqSubjects[s]
                ## Choose activity
                tidy[row, 2] = listOfActivities[a, 2]
                ## Create a data frame with these parameters 
                df <- final_table[final_table$Subject_ID==s & final_table$Activity_ID==listOfActivities[a, 2], ]
                ## Calculate mean
                result[row, 3:totalCol] <- colMeans(df[, 3:totalCol])
                ## Update row
                row = row+1
        }
}

## Create a table with tidy mean data
write.table(tidy, "tidyDataSet.txt")
