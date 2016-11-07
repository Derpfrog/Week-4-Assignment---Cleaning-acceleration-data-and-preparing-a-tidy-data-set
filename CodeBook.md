# Getting and cleaning data - Code Book

This data was obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
The original full description of the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Process
After downloading the data and unzipping it the code will read in the data to the following variables:

* featureNames > Holds the feature names 
* Alabels > Holds activity labels
* x_test > Acceleration in the x dimension for test data
* y_test > Acceleration in the y dimension for test data
* x_train > Acceleration in the x dimension for train data
* y_train > Acceleration in the y dimension for train data
* test_subject > Test subject identification
* train_subject > Train subject identification


##Next
the code will add appropriate feature names to the test and train data.
Along with this it will update the variable names to something more human readable.

##After
the code will add activity labels to the y test and train data. Followed by a search for the mean and standard deviation variables.  Once this data has been found it will make a list of the column names required for easy subsetting later on.

##Once
subsetting has been completed the test and train data is merged into one data set.  This data set is then turned into a tidy data set with the average of each variable for each activity and each subject.
