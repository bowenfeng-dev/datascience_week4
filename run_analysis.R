library(readr)
library(dplyr)

run.analysis <- function() {
  # Loads and combines both train and test data, adds variable names from features.txt.
  loadData <- function() {
    featureNames <- read_lines("features.txt")
    x.train <- read_table("train/X_train.txt", col_names = featureNames)
    x.test <- read_table("test/X_test.txt", col_names = featureNames)
    rbind(x.train, x.test)
  }
  
  # Loads and combines both train and test activity data, transformed into actual names.
  loadActivityNames <- function() {
    y.train <- read_lines("train/y_train.txt")
    y.test <- read_lines("test/y_test.txt")
    labels <- read_lines("activity_labels.txt")
    
    y.all <- as.numeric(c(y.train, y.test))
    labels <- sub(".+ ", "", labels)
    sapply(y.all, function(y) labels[[y]])
  }
  
  # Extracts only mean and std columns from the data frame.
  extractCols <- function(x.all) {
    mean.std.cols <- grep("mean|std", names(x.all))
    x.all[,mean.std.cols]
  }
  
  # Loads and combines both train and test subject numbers.
  loadSubjects <- function() {
    s.train <- read_lines("train/subject_train.txt")
    s.test <- read_lines("test/subject_test.txt")
    as.numeric(c(s.train, s.test))
  }

  loadData() %>%                              # Step 1, 4: Loads data, assign variable names
    extractCols() %>%                         # Step 2: Extracts only the mean and standard deviation
    mutate(activity=loadActivityNames()) %>%  # Step 3: Add activity data
    mutate(subject=loadSubjects()) %>%        # Step 5.1: Add subject data
    group_by(activity, subject) %>%           # Step 5.2: Group by activity and subject
    summarise_all(mean)                       # Step 5.3: Calculate average of each variable for each activity and subject
}
