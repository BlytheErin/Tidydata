# Tidydata

The purpose of this project is to demonstrate my ability to collect, 
work with, and clean a data set. The goal is to prepare tidy data 
that can be used for later analysis. 

1) a tidy data set as described below, 

###1.Merges the training and the test sets to create one data set.: totaldataset.csv
###2.Extracts only the measurements on the mean and standard deviation for each measurement.: selectdataset.csv
###3.Uses descriptive activity names to name the activities in the data set: mergeddataset.csv
###4.Appropriately labels the data set with descriptive variable names.: mergeddataset.csv
###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
for each activity and each subject.: byIDActivity.csv

2) https://github.com/BlytheErin/Tidydata: a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or 
work that you performed to clean up the data called CodeBook.md. 
4)This is a README.md in my Tidydata repo that describes my scripts. 


## 1.Merges the training and the test sets to create one data set.

### Downloading and unziping the files
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "Dataset")

### Resetting the directory
list.files("Dataset")
setwd("Dataset/UCI HAR Dataset")
getwd()
list.files(getwd())
list.files("train")
list.files("test")

### Reading and cbinding the subject and activity tables to the obseravbles and calculated variables table
train_list <- c("train/subject_train.txt", "train/y_train.txt", "train/X_train.txt")  #creates a list of training files 
test_list <- c("test/subject_test.txt", "test/y_test.txt", "test/X_test.txt") # creating a list of the test files

### column binding the training files
tmp <- lapply(train_list, read.table)
traindataset <- do.call(cbind, tmp)

### column binding the test files
tmp <- lapply(test_list, read.table)
testdataset <- do.call(cbind, tmp)

## row binding the training and test files
totaldataset <- do.call(rbind, list(traindataset, testdataset))

### Setting column names
x <-read.table("features.txt") ### file containg X_train variable names
xx<- as.character(x[,2]) # Making a character vector of these names
xxx<- c('ID', 'Activity', as.character(xx)) # adding names to the list for the Subject_train and Activity tables that were column bound.
str(xxx) ### taking a look at result

totaldataset<- setNames(totaldataset, xxx) # setting the column names
names(totaldataset) #checking result

### Extracting resulting dataset
setwd("D:/Blythe")
getwd()
if(!file.exists("./Tidydata/data_output")){dir.create("./Tidydata/data_output")}
write.csv(totaldataset, file = "Tidydata/data_output/totaldataset.csv", row.names=FALSE)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.

### Making names valid
library(dplyr)
valid_column_names <- make.names(names=names(totaldataset), unique=TRUE, allow_ = TRUE)
names(totaldataset) <- valid_column_names
### looking at new names
names(totaldataset)
### Selecting only the Mean and standar deviation for each meansurement
selectdataset<- select(totaldataset, ID, Activity, contains(".mean"), contains( ".std"))
### checking
names(selectdataset)

### Extracting the file
setwd("D:/Blythe")
if(!file.exists("./Tidydata/data_output")){dir.create("./Tidydata/data_output")}
write.csv(selectdataset, file = "Tidydata/data_output/selectdataset.csv", row.names=FALSE)

## 3.Uses descriptive activity names to name the activities in the data set

### reading in the 'activity_labels.txt' file
setwd("R/Dataset/UCI HAR Dataset")
activitytable <- read.table('activity_labels.txt', stringsAsFactors = F)

### Add cloumn names
activitytable<- setNames(activitytable, c("ActivityNumber", "ActivityName"))
### Merge tables and remove the ActivityNumber column
mergeddataset <- activitytable %>% merge(selectdataset, by.x="ActivityNumber", by.y="Activity", all=T) %>% select (-ActivityNumber)
names(mergeddataset)

## 4.Appropriately labels the data set with descriptive variable names.

### Removing all the periods for appropriatly labelled data set.
gsub("\\.", "", names(mergeddataset))
mergeddataset <- setNames(mergeddataset, gsub("\\.", "", names(mergeddataset)))
names(mergeddataset)

### Extracting the file
setwd("D:/Blythe")
if(!file.exists("./Tidydata/data_output")){dir.create("./Tidydata/data_output")}
write.csv(mergeddataset, file = "Tidydata/data_output/mergeddataset.csv", row.names=FALSE)

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Selecting only the Mean for each meansurement
meandataset<- select(mergeddataset, ID, ActivityName, matches( "mean"))
### checking
names(meandataset)

### Combining the subject and acitivity variables into a new variable,
### while adding a"0" if the subject ID is less than 10 using the ifelse statement.

meandataset$IDactivity<-ifelse(meandataset$ID<10, paste0("0", meandataset$ID, meandataset$ActivityName), paste0(meandataset$ID, meandataset$ActivityName)) 
meandataset$IDactivity

### Melt data
library(reshape2)
meltdataset <- melt(meandataset, id=c("ID", "ActivityName", "IDactivity"))
head(meltdataset, n=3)
byActivity <- dcast(c, ActivityName ~ variable, mean)
byActivity
byID <- dcast(c, ID ~ variable, mean)
byID
byIDActivity <- dcast(c, IDactivity ~ variable, mean)
byIDActivity


### Extracting the file
setwd("D:/Blythe")
if(!file.exists("./Tidydata/data_output")){dir.create("./Tidydata/data_output")}
write.csv(byIDActivity, file = "Tidydata/data_output/byIDActivity.csv", row.names=FALSE)



