"x": Row Number
"ID": identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
"ActivityName": Its activity label: Laying, Sitting, Standing, Walking, Walking_Downstairs, Walking_Upstairs

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The variables are averages of each orginal mean variable for each activity and each subject. The '()' and '-' characters from the original variable names has been removed.  

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

"tBodyAccmeanX"
"tBodyAccmeanY"
"tBodyAccmeanZ"
"tGravityAccmeanX"
"tGravityAccmeanY"
"tGravityAccmeanZ"

the body linear acceleration was derived in time to obtain Jerk signals

"tBodyAccJerkmeanX"
"tBodyAccJerkmeanY"
"tBodyAccJerkmeanZ"

- Triaxial Angular velocity from the gyroscope. 
"tBodyGyromeanX"
"tBodyGyromeanY"
"tBodyGyromeanZ"

the angular velocity were derived in time to obtain Jerk signals  

"tBodyGyroJerkmeanX"
"tBodyGyroJerkmeanY"
"tBodyGyroJerkmeanZ"

Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

"tBodyAccMagmean"
"tGravityAccMagmean"
"tBodyAccJerkMagmean"
"tBodyGyroMagmean"
"tBodyGyroJerkMagmean"

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
Note the 'Freq' indicates the weighted average of the frequency components to obtain a mean frequency

"fBodyAccmeanX"
"fBodyAccmeanY"
"fBodyAccmeanZ"
"fBodyAccmeanFreqX"
"fBodyAccmeanFreqY"
"fBodyAccmeanFreqZ"

"fBodyAccJerkmeanX"
"fBodyAccJerkmeanY"
"fBodyAccJerkmeanZ"
"fBodyAccJerkmeanFreqX"
"fBodyAccJerkmeanFreqY"
"fBodyAccJerkmeanFreqZ"

"fBodyGyromeanX"
"fBodyGyromeanY"
"fBodyGyromeanZ"
"fBodyGyromeanFreqX"
"fBodyGyromeanFreqY"
"fBodyGyromeanFreqZ"

"fBodyAccMagmean"
"fBodyAccMagmeanFreq"

"fBodyBodyAccJerkMagmean"
"fBodyBodyAccJerkMagmeanFreq"

"fBodyBodyGyroMagmean"
"fBodyBodyGyroMagmeanFreq"

"fBodyBodyGyroJerkMagmean"
"fBodyBodyGyroJerkMagmeanFreq"
