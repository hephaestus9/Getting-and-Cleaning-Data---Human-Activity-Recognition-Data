library(data.table)
library(dplyr)

# set working directory
setwd("C:\\Users\\jeramy\\Documents\\Coursera\\Getting and Cleaning Data\\UCI HAR Dataset")

# get features
features = read.table("features.txt")

# get activity labels
activity_labels = read.table("activity_labels.txt")

# remove unused columns
features$V1 = NULL
activity_labels$V1 = NULL

# bring data in
x_train = read.table("train\\x_train.txt")
y_train = read.table("train\\y_train.txt")
names(y_train) = "activities"
subject_train = read.table("train\\subject_train.txt")
names(subject_train) = "subject"

x_test = read.table("test\\x_test.txt")
y_test = read.table("test\\y_test.txt")
names(y_test) = "activities"
subject_test = read.table("test\\subject_test.txt")
names(subject_test) = "subject"

# clean up
x_names = features[,1]
names(x_train) = x_names
names(x_test) = x_names
train_data = cbind(x_train, y_train, subject_train)
test_data = cbind(x_test, y_test, subject_test)
data = rbind(train_data, test_data)
remove(features, x_names, x_test, x_train, y_test, y_train, test_data, train_data, subject_test, subject_train)

org_compiled_data = data

# change activities from int to str
for (i in 1:nrow(data)) {
  data[i, "activities"] = as.character(activity_labels[data[i, "activities"], 1])
}

# finish clean up
remove(i, activity_labels)

# get columns we want
mean_data = data[ , which(names(data) %like% "-mean")]
std_data = data[ , which(names(data) %like% "-std")]
my_data = cbind(mean_data, std_data, data$activities, data$subject)
# I am pretty sure this is a hack, but it cleans it back up
colnames(my_data)[81] = "subject"
colnames(my_data)[80] = "activities"
remove(mean_data, std_data)

# get averages per activity per subject
mean_data = data.frame()
for (i in unique(my_data$subject)){
  for (j in unique(my_data$activities)){
    df = filter(my_data, activities == j, subject == i)
    df = df[, -which(names(df) %in% c("activities", "subject"))]
    row_data = c()
    for ( k in names(df)){
      row_data = c(row_data, mean(df[k][,1]))
    }
    row_data = data.frame(t(unlist(c(row_data, j, i))))
    mean_data = rbind(mean_data, row_data)
    remove(df, row_data)
  }
}
names(mean_data) = names(my_data)
remove(i, j, k)

# comment this out to work with original data,
# or data as it is progressively filtered and manipulated
remove(org_compiled_data, data, my_data)

