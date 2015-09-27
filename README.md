## General

As part of the course "Getting and Cleaning Data" by Coursera, 
this code will answer to the project goal which is to collect data from different files and reshaping the data as required.

## Data source and path

The data source for this project is downloadable from this [URL.][1] 
The code assumes that under the working directory there's a ***data*** directory and under that directory there's the extracted ***UCI HAR Datase***t directory

**Example: Working Directory\data\UCI HAR Datase\test**

![path][2]

## Scripts

run_analysis.R - the main and only script which does the following:

 1. Get the *test* and *train* measurements and combine them to one dataset
 2. Name the variables (by features file)
 3. Add the activity type to each measurement (activity number is replaced with activity lable. i.e.: WALKING, SITTING)
 4. Add the subject ID related to each measurement (there are 30 subjects)
 5. keeping only the variables which contain "**mean**" or "**std**" for the set of measurements
 6. Melt the data and present the mean value of each variables for each subject and each activity he/she had done


  [1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  [2]: https://github.com/liranye/gettingAndCleaningData/blob/master/path.png