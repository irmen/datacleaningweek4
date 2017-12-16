# Getting and Cleaning Data week 4 assignment


## Preparation: obtain and unzip the raw data files

Download the data set zipfile from the [URL mentioned](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the instructions; save it as "Dataset.zip".

Unzip it, you'll get a lot of files in the "UCI HAR Dataset" directory. Make sure this is in your R working directory. You can do this outside of R, or in R itself if you so desire, by sourcing the ``get_dataset.R`` script.

The dataset is described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and in the various files that are part of it, most notably the ``README.txt``

*For each record it is provided:*

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

*The dataset includes the following files:*

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

*Notes: *
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

# Analysis steps

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
The resulting data table is written to the ``second_dataset_tidy.txt`` file which has the following format (it has no column headers):

|Column| Data type | Description |
|------|-----------|-------------|
| A    | numeric   | subjectID; identifies the subject that took the test, range 1-30 |
| B    | text      | activityname; the name of the activity performed, out of six possibilities |
| C    | numeric   | activityID; the id of the performed activity |
| D-CD | numeric   | many measurements; each is the average of that measured variable for that subject and activity |
