# `tidydata_project` - a script for tidying motion data

This repo supports a project for [Getting and Cleaning Data](https://coursera.org/classes/getdata/). Using provided data from [an experiment using smartphone data to characterize human actvity](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), the script performs the following tasks:

- Loads traininng and test data as well as label info for the datasets
- Filters on the variables of interest (see [Codebook.md](./Codebook.md) for more info).
- Reshapes it into a tidy dataset displaying average values for the selected metrics by subject and activity.

The output file is a tab-separated file called `motion_data.txt`.

Files in this repo:

- `README.md` - this file
- `Codebook.md` - description of the data in the tiny dataset and any transforms performed
- `run_analysis.R` - an R script that loads the raw data from a directory structure in the working directory, processes it, and saves motion_data.txt

To use this script the data (or any data with the same structure) should be placed in the working directory. [Here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is the source data used to develop and test the script.