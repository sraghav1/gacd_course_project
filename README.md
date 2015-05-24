# gacd_course_project
Course project for Getting and Cleaning Data course (https://class.coursera.org/getdata-014)

## How to run the script
1. Download the data set from the following site and extract. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. The data should be exctraced in "UCI HAR Dataset" directory.
3. Clone this git repository and copy the file run_analysis.R file to "UCI HAR Dataset" directory.
4. Run the script run_analysis.R from the "UCI HAR Dataset" directory.
5. Example command on windows:
`C:\sunil\datascience\gacd\course_project\UCI HAR Dataset>c:\r\R-3.2.0\bin\Rscript.exe ..\run_analysis.R`
6. On a successful run the output will be created in the same directory, in a file name "accelerometer_groupwise_avg.txt".

## What does the script do
1. The script parses the 'UCI HAR' dataset, parsing both test and training data.
2. It extracts feature name and activity code enumeration by parsing the files 'features.txt' and 'activity_labels.txt' respectively.
3. The script then extracts subject, activity and all the feature measurements from the training and test data sets. These are bound together to form a single dataset.
4. Column name corresponding to each feature is generated from the feature name read from featurs.txt.
5. Only the measurements of mean and standard deviation are stored in the data set. This is achieved by matching the feature names using regular expressions with 'mean' and 'std'.
6. Activity code is substituted with activity labels extracted from the activity_labels file.
7. Average measurements of all the features in the dataset grouped by subject and activity is calculated. This is achieved using the ddply function from plyr package.
8. The output dataset is written to the file "accelerometer_groupwise_avg.txt". This is a text file using space to separate individual fields and new line to separate records.

## How do I make sense of the data
Please refer to the code_book.txt file in this git repository.

