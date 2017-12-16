# preparation.
source("get_dataset.R")
source("combine.R")

# 1. Merge the training and test sets to create one data set.
combined = combine()

# 2. extract only the measurements on the mean and stddev for each measurement
# we also want to keep the activityID column because we need to give it a description later.
# and ofcourse the subjectID.
column_names <- colnames(combined$combined_all)
interesting_columns <- column_names[grepl("mean..|std..|activityID|subjectID", column_names)]
combined_data <- combined$combined_all[, interesting_columns, with=FALSE]   # data.table feature

# 3. Use descriptive activity names to name the activities in the data set
combined_data <- merge(combined$activities, combined_data, by="activityID", all.y=TRUE)

# 4. Appropriately labels the data set with descriptive variable names. 
# This has already been done in the combine function in step 1

# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
library(tibble)
library(dplyr)
library(data.table)
summary <-
    as_tibble(combined_data) %>%
    group_by(subjectID, activityname) %>%
    summarize_all(mean)

# write the dataset, 
message("writing tidy summary dataset")
fwrite(summary, file="second_dataset_tidy.csv")
