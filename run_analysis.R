# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Downloading and unziping the files
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "Dataset")

# Resetting the directory
list.files("Dataset")
setwd("Dataset/UCI HAR Dataset")
getwd()
list.files(getwd())
list.files("train")
list.files("test")

# Reading and cbinding the subject and activity tables to the obseravbles and calculated variables table
train_list <- c("train/subject_train.txt", "train/y_train.txt", "train/X_train.txt")  #creates a list of training files 
test_list <- c("test/subject_test.txt", "test/y_test.txt", "test/X_test.txt") # creating a list of the test files

#column binding the training files
tmp <- lapply(train_list, read.table)
train <- do.call(cbind, tmp)

#column binding the test files
tmp <- lapply(test_list, read.table)
test <- do.call(cbind, tmp)

#row binding the training and test files
total <- do.call(rbind, list(train, test))

# Setting column names
x <-read.table("features.txt") #file containg X_train variable names
xx<- as.character(x[,2]) # Making a character vector of these names
xxx<- c('ID', 'Activity', as.character(xx)) # adding names to the list for the Subject_train and Activity tables that were column bound.
str(xxx) #taking a look at result

totaldataset<- setNames(total, xxx) # setting the column names
names(totaldataset) #checking result

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
#Making names valid
valid_column_names <- make.names(names=names(totaldataset), unique=TRUE, allow_ = TRUE)
names(totaldataset) <- valid_column_names
#looking at new names
names(totaldataset)
#Selecting only the Mean and standar deviation for each meansurement
selectdataset<- select(totaldataset, ID, Activity, contains(".mean"), contains( ".std"))
#checking
names(selectdataset)

# 3.Uses descriptive activity names to name the activities in the data set

#reading in the 'activity_labels.txt' file
activitytable <- read.table('activity_labels.txt', stringsAsFactors = F)

#Add cloumn names
activitytable<- setNames(activitytable, c("ActivityNumber", "ActivityName"))
# Merge tables and remove the ActivityNumber column
mergeddataset <- activitytable %>% merge(selectdataset, by.x="ActivityNumber", by.y="Activity", all=T) %>% select (-ActivityNumber)
names(mergeddataset)

# 4.Appropriately labels the data set with descriptive variable names.
# Removing all the periods for appropriatly labelled data set.
gsub("\\.", "", names(mergeddataset))
mergeddataset <- setNames(mergeddataset, gsub("\\.", "", names(mergeddataset)))
names(mergeddataset)

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Selecting only the Mean for each meansurement
meandataset<- select(mergeddataset, ID, ActivityName, matches( "mean"))
#checking
names(meandataset)

#Combining the subject and acitivity variables into a new variable,
# while adding a"0" if the subject ID is less than 10 using the ifelse statement.

meandataset$IDactivity<-ifelse(meandataset$ID<10, paste0("0", meandataset$ID, meandataset$ActivityName), paste0(meandataset$ID, meandataset$ActivityName)) 
meandataset$IDactivity

# Melt data
library(reshape2)
meltdataset <- melt(meandataset, id=c("ID", "ActivityName", "IDactivity"))
head(meltdataset, n=3)
byActivity <- dcast(c, ActivityName ~ variable, mean)
byActivity
byID <- dcast(c, ID ~ variable, mean)
byID
byIDActivity <- dcast(c, IDactivity ~ variable, mean)
byIDActivity
