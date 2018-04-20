#Code book
 
# In the R script called run_analysis.R are datasets 
created with data from the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1.Merges the training and the test sets to create one data set.

traindataset: the training measurements combined with the corresponding ID and activities, 
including "train/subject_train.txt", "train/y_train.txt", "train/X_train.txt"

testdataset: the test measurements combined with the ID and activities.
including "test/subject_test.txt", "test/y_test.txt", "test/X_test.txt" 

totaldataset: the row bound train and test datasets

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

selectdataset: the totaldataset with only the measurements on the mean and standard deviation of each measurement.

# 3.Uses descriptive activity names to name the activities in the data set

activitytable: 'activity_labels.txt': Links the class labels with their activity name.

mergeddataset: the merged acitivitytable and the selectdataset and the removal of the ActivityNumber column that the data was merged on.

# 4.Appropriately labels the data set with descriptive variable names.
# Removing all the periods for appropriatly labelled data set.

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

meandataset: exludes the std variable values
IDactivity: a new variable in the meandataset that combines the subject and activity identifications and adds a preceding "0" for single digits.  

# Melt data

meltdataset : The melted dataset
byActivity : the variable means by the 6 activity
byID : the variable means by the 30 subject ID
byIDActivity: the variable means by each of the 6 activity and each the 30 subjects for a total of 180 cases