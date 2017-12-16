# download and unzip the raw data 

if(!file.exists("Dataset.zip")) {
    message("downloading data...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Dataset.zip")
} else {
    message("already downloaded")
}

if(!dir.exists("UCI HAR Dataset")) {
    message("unzipping datafile...")
    unzip("Dataset.zip", exdir = ".")
} else {
    message("already unzipped")
}
