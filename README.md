## The script

Almost all steps has been recorded as a comment in the script. Here are basic steps:
* Merge all necessary data
* Exctract mean and standart deviation variables
* Name all activities
* Combine all tables and save it as .txt
* Create new file with tidy data and save it as .txt (average of each variable for each activity and each subject)

As the result there would be 2 files with the .txt format: 
* final_table_mean_std_merged.txt (~8.3 Mb, with clear (Tidy) columns and rows and as a variables)
* tidyDataSet.txt (~225 KB, data set with the average of each variable for each activity and each subject. 

## Run scripit

* Open R Studio (or similar)
* Download all files from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
to you current working directory and unzip them there
* Open this scripit in your R studio
* Select all and then hit run