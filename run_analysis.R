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
dat <- do.call(cbind, tmp)

#column binding the test files
tmp <- lapply(test_list, read.table)
dat2 <- do.call(cbind, tmp)

#row binding the training and test files
dat3 <- do.call(rbind, list(dat, dat2))

# Setting column names
x <-read.table("features.txt") #file containg X_train variable names
xx<- as.character(x[,2]) # Making a character vector of these names
xxx<- c('ID', 'Activity', as.character(xx)) # adding names to the list for the Subject_train and Activity tables that were column bound.
str(xxx) #taking a look at result

dat3<- setNames(dat3, xxx) # setting the column names
names(dat3) #checking result

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
#Making names valid
valid_column_names <- make.names(names=names(dat3), unique=TRUE, allow_ = TRUE)
names(dat3) <- valid_column_names
#looking at new names
names(dat3)
#Selecting only the Mean and standar deviation for each meansurement
dat4<- select(dat3, ID, Activity, contains(".mean"), contains( ".std"))
#checking
names(dat4)

# 3.Uses descriptive activity names to name the activities in the data set

#reading in the 'activity_labels.txt' file
a <- read.table('activity_labels.txt', stringsAsFactors = F)

#Add cloumn names
a<- setNames(a, c("ActivityNumber", "ActivityName"))
# Merge tables and remove the ActivityNumber column
b <- a %>% merge(dat4, by.x="ActivityNumber", by.y="Activity", all=T) %>% select (-ActivityNumber)
names(b)

# 4.Appropriately labels the data set with descriptive variable names.
# Removing all the periods for appropriatly labelled data set.
gsub("\\.", "", names(b))
b <- setNames(b, gsub("\\.", "", names(b)))
names(b)

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Selecting only the Mean for each meansurement
dat6<- select(b, ID, ActivityName, matches( "mean"))
#checking
names(dat6)

#I want to combine the Activity and subject variables into a new variable.
# I need to add a"0" if less than 10 using the ifelse

dat6$IDactivity<-ifelse(dat6$ID<10, paste0("0", dat6$ID, dat6$ActivityName), paste0(dat6$ID, dat6$ActivityName)) 
dat6$IDactivity

# Melt data
library(reshape2)
c <- melt(dat6, id=c("ID", "ActivityName", "IDactivity"))
head(c, n=3)
byActicity <- dcast(c, ActivityName ~ variable, mean)
byActicity
byID <- dcast(c, ID ~ variable, mean)
byID
byIDActivity <- dcast(c, IDactivity ~ variable, mean)
byIDActivity
