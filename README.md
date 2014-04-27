run_analysis R script
===========

This is a guide for whoever needs to use this R script to prepare data from the Samsung data set.
The main objectives of this script are listed here as found on [Coursera] (https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions):

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The code is properly commented but to ease the review I'll describe the steps followed in the script.


### Basic assumptions before running the script

It's assumed that you have R installed on your machine, no special packages are required to run this script.
The data set can be download [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The link will download a zip file that needs to be extracted in the Working directory of R (use getwd() and setwd() to check and change the directory respectively).
The default name for the parent folder is "UCI HAR Dataset" but it is ok if the name is modifed during the extraction as long as the structure remains the same.


### Running the script

To run the script copy it into your working directory and add the source in your R environment using the source call.
The function accepts one optional argument which is the location of the data set parent directory, if left empty it assumes the default name.
You can specify both a relative or absolute path, for relative remember to add the dot:

	run_analysis(".\\UCI HAR Dataset")


### Steps

1. The scripts starts accessing each relevant file on the dataset according to the original structure and saves every set into a table.
2. The features extracted are used to rename the columns on the measurements set (both the training and testing ones).
3. Once the columns are named we replicate the table into a new one only including those columns that have mean and standard deviations values.
4. The selection is done using the function grepl which looks for either mean or std in the column names.
5. After this a new table is created merging the subject and activity information for both train and test to finally row bind them together, after having deleted the useless activity ids and renamed the columns.
6. The same binding is done with the measurements train and test table.
7. Finally both tables are column bind to generate the final "data" table.
8. The second part of the assignment is completed using a single command: "aggregate". We create a new table ("tidyData") including the mean measurement of every column of the data table (excluding the first two columns, Activity and SubectId which are only for sorting purposes), according to the categories of Activity and Subject the values belong to.
9. The contents of tidy are written into the "tidy.txt" file in the working directory.





Coders
====================

* [Jorge Hermoso](http://befaust.com) - Wrote the initial version (2014).



