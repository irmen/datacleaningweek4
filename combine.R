# combines the test and train data sets into one.
# returns a list containing:
#   combined_all = datafrme with the combination of the test and train data
#   activities = dataframe with the descriptive names for the activities

combine = function() {

    library(data.table)   # fast reading
    
    datadir <- "./UCI HAR Dataset"
    traindir <- file.path(datadir, "train")
    testdir <- file.path(datadir, "test")
    
    message("reading train data")
    x_train = fread(file.path(traindir, "X_train.txt"), header=FALSE)
    y_train = fread(file.path(traindir, "y_train.txt"), header=FALSE)
    subject_train = fread(file.path(traindir, "subject_train.txt"), header=FALSE)
    
    message("reading test data")
    x_test = fread(file.path(testdir, "X_test.txt"), header=FALSE)
    y_test = fread(file.path(testdir, "y_test.txt"), header=FALSE)
    subject_test = fread(file.path(testdir, "subject_test.txt"), header=FALSE)
    
    # read the label names
    features = fread(file.path(datadir, "features.txt"), header=FALSE)
    activities = fread(file.path(datadir, "activity_labels.txt"), header=FALSE)
    
    # (item 3 in the assignment:) use descriptive column names
    # I like to do this as early as possible so we can use
    # descriptive names in all future code.
    colnames(activities) = c("activityID", "activityname")
    colnames(features) <- c("featureID", "featurename")
    colnames(x_test) <- features[,featurename]
    colnames(y_test) <- "activityID"
    colnames(x_train) <- features[,featurename]
    colnames(y_train) <- "activityID"
    colnames(subject_test) <- "subjectID"
    colnames(subject_train) <- "subjectID"
    
    # combine the separate data tables into one called 'combined_all'
    # columns:   subjectID, activityID, features....
    combined_test <- cbind(subject_test, y_test, x_test)
    combined_train <- cbind(subject_train, y_train, x_train)
    combined_all <- rbind(combined_test, combined_train)
    
    list(combined_all=combined_all, activities=activities)
}
