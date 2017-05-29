loadData <- function() {
  featureNames <- read_lines("features.txt")
  x.train <- read_table("train/X_train.txt", col_names = featureNames)
  x.test <- read_table("test/X_test.txt", col_names = featureNames)
  rbind(x.train, x.test)
}

loadActivityNames <- function() {
  y.train <- read_lines("train/y_train.txt")
  y.test <- read_lines("test/y_test.txt")
  labels <- read_lines("activity_labels.txt")
  
  y.all <- as.numeric(c(y.train, y.test))
  labels <- sub(".+ ", "", labels)
  sapply(y.all, function(y) labels[[y]])
}

extractCols <- function(x.all) {
  mean.std.cols <- grep("mean|std", names(x.all))
  x.all[,mean.std.cols]
}

loadSubjects <- function() {
  s.train <- read_lines("train/subject_train.txt")
  s.test <- read_lines("test/subject_test.txt")
  as.numeric(c(s.train, s.test))
}

run.analysis <- function() {
  loadData() %>%
    extractCols() %>%
    mutate(activity=loadActivityNames()) %>%
    mutate(subject=loadSubjects()) %>%
    group_by(activity, subject) %>%
    summarise_all(mean)
}
