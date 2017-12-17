# Getting and Cleaning Data week 4 assignment

This contains the Codebook and R scripts for the Getting and Cleaning Data Course Project.

The data for this project is described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and the data file is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

- ``CodeBook.md`` : the codebook that describes how the data is obtained, processed and how the result looks like.
- ``run_analysis.R`` : the R script that does the work and produces the end result. It makes use of two additional scripts mentioned below.
- ``get_dataset.R`` : downloads and unzips the raw data needed for this project. 
- ``combine.R`` : reads the various separate data files and combines them in one data set, that can be further processed by the ``run_analysys.R`` script.


Perform the analysis by sourcing the ``run_analysys.R`` script.


Here's a great [blog post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) about this assignment that explains various things about the assignment itself.
