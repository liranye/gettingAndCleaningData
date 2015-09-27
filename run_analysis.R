
## Step 1: Merging the data
##--------------------------
testSet <- read.table('./data/UCI HAR Dataset/test/X_test.txt', header = FALSE)     #loading measurements from test file
trainSet <- read.table('./data/UCI HAR Dataset/train/X_train.txt', header = FALSE)  #loading measurements from train file 
fullSet <- rbind(testSet,trainSet)                                                  #binding the measurements


## Step 2: Enriching the data (assign columns label, add activity name, extract mean&std measurements)
##--------------------------------------------------------------------------------------------------

# 2.1 Assign Labels to the columns according to the features file (point #4)
features <- read.table('./data/UCI HAR Dataset/features.txt', header = FALSE)       #loading the features list
labels <- features[,2]                                                              
colnames(fullSet)<-labels                                                           #assigning labels to columns names (variable names)

# 2.2.1 Adding Activities with description (point #3)
testAct <- read.table('./data/UCI HAR Dataset/test/y_test.txt', header = FALSE)         #loading the activity type for each test measurement
trainAct <- read.table('./data/UCI HAR Dataset/train/y_train.txt', header = FALSE)      #loading the activity type for each train measurement
activities <- read.table('./data/UCI HAR Dataset/activity_labels.txt', header = FALSE)  #merging the activities of test and train
mergedAct <- rbind(testAct, trainAct)                                                   
for (i in 1:length(mergedAct[,1])) {
        mergedAct[i,1]<-as.character(activities[mergedAct[i,1],"V2"])                   #"downcasting" the activity type from factor to character
}
fullSet <- cbind(fullSet, mergedAct)                                                    #adding a column so for each measurement we'll know what was the activity type
colnames(fullSet)[562] <- "activity"                                                    #labeling the activity column

# 2.2.2 Adding subject (the person related to the measurement) with description (point #3)
testSubject <- read.table('./data/UCI HAR Dataset/test//subject_test.txt', header = FALSE)         #loading the activity type for each test measurement
trainSubject <- read.table('./data/UCI HAR Dataset/train//subject_train.txt', header = FALSE)      #loading the activity type for each train measurement
mergedSubject <- rbind(testSubject, trainSubject)                                                   
fullSet <- cbind(fullSet, mergedSubject)                                                    #adding a column so for each measurement we'll know what was the activity type
colnames(fullSet)[563] <- "subject"                                                    #labeling the activity column


# 2.3 Extracting measurements with mean & std (point #2)
extractMean <- fullSet[,grepl("mean", colnames(fullSet))]                       #selecting colums/variables with "mean"
extractStd <- fullSet[,grepl("std", colnames(fullSet))]                         #selecting colums/variables with "std"
measurementsMeanStd <- cbind(extractMean,extractStd)                             #merging the colums/variables above
measurementsMeanStd <- cbind(fullSet[,"subject"], fullSet[,"activity"], measurementsMeanStd)            
colnames(measurementsMeanStd)[1] <- "subject"                                   #updating subject label
colnames(measurementsMeanStd)[2] <- "activity"                                  #updating activity label

## Step 3:  Melting the dat and reshaping to present variables average for a subject and activity
##--------------------------------------------------------------------------------------------------
measurementMelt <- melt(measurementsMeanStd,id=c("subject","activity"),measure.vars=names(measurementsMeanStd)[3:length(measurementsMeanStd)])

# This is  the average of each variable for each subject and the activity he made
measurementData <- dcast(measurementMelt, subject + activity ~ variable, mean) 
