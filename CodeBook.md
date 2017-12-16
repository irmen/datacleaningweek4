# Getting and Cleaning Data week 4 assignment


## Preparation: obtain and unzip the raw data files

Download the data set zipfile from the [URL mentioned](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the instructions; save it as "Dataset.zip".

Unzip it, you'll get a lot of files in the "UCI HAR Dataset" directory. Make sure this is in your R working directory. You can do this outside of R, or in R itself if you so desire, by sourcing the ``get_dataset.R`` script.


## 1. Merge the test and train data into one data set

The data set is partitioned into 'test' and 'train' data, which we have to combine into one dataset.
This task is performed by the ``combine`` function in the ``combine.R`` script.
It uses the ``data.table`` library to speed up the reading of the data files significantly.

The ``combine`` function takes no parameters, and returns a list with:
- ``combined_all`` = dataframe with the combination of the test and train data
- ``activities`` = dataframe with the descriptive names for the activities

The data frames also already have descriptive column names. These are taken from the ``activity_labels.txt`` (the six activities the subjects performed)
and ``features.txt`` (the device measurements) data files.


## 2. Extract only the measurements on the mean and stddev for each measurement

The ``run_analysis.R`` script does the rest of the processing.
After having read the combined data from step 1, it extracts a new data table from it,
that contains only the columns we are interested in :
'activityID', 'subjectID' and all columns containing the string "mean" (the means) or "std" (the standard deviations).
Keeping the right columns is done via a nice subsetting feature of the ``data.table``.


## 3. Name the activities in the data set using descriptive activity names

The ``activityID`` is matched with the data from the ``activity_labels.txt`` file so that
the descriptive activity names are now present in the data table.


## 4. Appropriately labels the data set with descriptive variable names

This has already been done in the combine function in step 1,
because it's more natural to do it there (when reading the data files)
and it is convenient as well to do it as early as possible.


## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

The ``dplyr`` library is used to group the data on activityname and subject, and
then summarize it by using ``mean`` over all columns. 
The resulting data table is written to the ``second_dataset_tidy.csv`` file which has the following format:

|Column|Name          | Data type | Description |
|------|--------------|-----------|-------------|
| A    | subjectID    | numeric   | identifies the subject that took the test, range 1-30 |
| B    | activityname | text      | the name of the activity performed, out of six possibilities |
| C    | activityID   | numeric   | the id of the performed activity |
| D-CD | -varies-     | numeric   | the average of each measured variable for that subject and activity |
