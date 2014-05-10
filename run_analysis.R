# run_analysis.R - merges training and test data from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Then creates a tidy data set with average values by activity and subject
# Developed for the Coursera course "Getting and Cleaning Data" 
# https://www.coursera.org/course/getdata

# Load libraries
library(reshape2)
library(dplyr)

# Load and merge the data.
feature.labels <- read.table('UCI HAR Dataset//features.txt', 
                             stringsAsFactors=F)[,2]
X.test <- read.fwf('UCI HAR Dataset//test/X_test.txt', rep(16, 561))
X.train <- read.fwf('UCI HAR Dataset//train/X_train.txt', rep(16, 561))
tt.data <- rbind(X.test, X.train)
names(tt.data) <- feature.labels

# Filter for mean() and std() features only
tt.data <- tt.data[,c(grep('tBodyAcc-mean\\(\\)', names(tt.data)), 
                      grep('tBodyAcc-std\\(\\)', names(tt.data)),
                      grep('tBodyGyro-mean\\(\\)', names(tt.data)), 
                      grep('tBodyGyro-std\\(\\)', names(tt.data)))]

# Add activity labels
y.test <- read.table('UCI HAR Dataset//test/y_test.txt')
y.train <- read.table('UCI HAR Dataset//train/y_train.txt')
y <- rbind(y.test, y.train)
names(y) <- 'Activity'
tt.data <- cbind(y, tt.data)

# Add subject IDs
subject.test <- read.table('UCI HAR Dataset//test/subject_test.txt')
subject.train <- read.table('UCI HAR Dataset//train/subject_train.txt')
subject <- rbind(subject.test, subject.train)
names(subject) <- 'Subject'
tt.data <- cbind(subject, tt.data)

# Label data with descriptive activity names
activity.names <- read.table('UCI HAR Dataset//activity_labels.txt',
                             col.names = c('id', 'Activity.Name'))
tt.data <- merge(tt.data, activity.names, by.x="Activity", by.y='id')

# Create a new tidy data set with the average of each variable for each 
# activity and subject.
tt.melted <- melt(tt.data, id=c('Subject', 'Activity.Name'),
                  measure.vars=names(tt.data[3:(ncol(tt.data)-1)]))
tt.melted$Subject <- as.factor(tt.melted$Subject)
tt.out <- dcast(tt.out, Subject + Activity.Name ~ variable, FUN=mean)
write.table(tt.out, file='motion_data.txt', sep='\t', quote=FALSE, row.names=FALSE)

