# Getting and Cleaning Data week 4 assignment


## 1. Obtaining and preparing the raw data files

Download the data set zipfile from the [URL mentioned](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the instructions; save it as "Dataset.zip".

Unzip it, you'll get a lot of files in the "UCI HAR Dataset" directory. Make sure this is in your R working directory. You can do this outside of R, or in R itself if you so desire, by sourcing the ``get_dataset.R`` script.


## 2. Merging the test and train data

The data set is partitioned into 'test' and 'train' data. We need to combine these into one dataset.
This task is performed by the ``combine`` function in the ``combine.R`` script.

It takes no parameters, and returns a dataframe that contains the combined test and train data,
with descriptive column names: 'subjectID', 'activityID', followed by the 561 feature columns.

