setwd("/Users/Francisco/datasciencecoursera/UCI-HAR-Dataset")
dataSubjectTrain <- fread("train/subject_train.txt")
dataSubjectTest  <- fread("test/subject_test.txt")
dataActivityTrain <- fread("train/y_train.txt")
dataActivityTest  <- fread("test/y_test.txt")

# Read datafiles and convert to tables in one step
f2d <- function (file) {
  datafile <- read.table(file)
  datatable <- data.table(datafile)
}
dataTrain <- f2d("train/X_train.txt")
dataTest  <- f2d("test/X_test.txt")

# Now, concatenate the data into the data object
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(dataSubject, "V1", "Subject")
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
setnames(dataActivity, "V1", "ActivityNum")
data <- rbind(dataTrain, dataTest)

dataSubject <- cbind(dataSubject, dataActivity)
data <- cbind(dataSubject, data)

#Set key.
setkey(data, Subject, ActivityNum)

# The features.txt file tells us which variables are measurements for the mean and standard deviation.
dataFeatures <- fread(file.path(pathIn, "features.txt"))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))

# Subset only for the mean and standard deviation.
dataFeatures <- dataFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

# Convert the column numbers to a vector of variable names matching columns in data
dataFeatures$featureCode <- dataFeatures[, paste0("V", featureNum)]
head(dataFeatures)
dataFeatures$featureCode

# Subset these variables using variable names.
select <- c(key(data), dataFeatures$featureCode)
data <- data[, select, with=FALSE]

# Use descriptive activity names by reading the labels file
dataActivityNames <- fread(file.path(pathIn, "activity_labels.txt"))
setnames(dataActivityNames, names(dataActivityNames), c("ActivityNum", "ActivityName"))

# Merge the activity labels to give meaningful names
data <- merge(data, dataActivityNames, by="ActivityNum", all.x=TRUE)

# This adds the activityName as a key.
setkey(data, Subject, ActivityNum, ActivityName)

# Use melt to reshape it to a tall, narrow format.
data <- data.table(melt(data, key(data), variable.name="featureCode"))

# Merge activity name.
data <- merge(data, dataFeatures[, list(featureNum, featureCode, featureName)], by="featureCode", all.x=TRUE)

# Create new factor classes for activity and features
data$Activity <- factor(data$ActivityName)
data$feature <- factor(data$featureName)

# Use some regular expressions to filter the data - probably a better way to do this, but i'm thinking Unix-style
grepdata <- function (regex) {
  grepl(regex, data$feature)
}
## Features with 1 category
data$Jerk <- factor(grepdata("Jerk"), labels=c(NA, "Jerk"))
data$Magnitude <- factor(grepdata("Mag"), labels=c(NA, "Magnitude"))
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepdata("^t"), grepdata("^f")), ncol=nrow(y))
data$Domain <- factor(x %*% y, labels=c("Time", "Freq"))
x <- matrix(c(grepdata("Acc"), grepdata("Gyro")), ncol=nrow(y))
data$Instrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepdata("BodyAcc"), grepdata("GravityAcc")), ncol=nrow(y))
data$Acceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(grepdata("mean()"), grepdata("std()")), ncol=nrow(y))
data$Variable <- factor(x %*% y, labels=c("Mean", "SD"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepdata("-X"), grepdata("-Y"), grepdata("-Z")), ncol=nrow(y))
data$Axis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))

# Create the tidy data set

setkey(data, Subject, Activity, Domain, Acceleration, Instrument, Jerk, Magnitude, Variable, Axis)
tidy_data <- data[, list(count = .N, average = mean(value)), by=key(data)]
write.table(tidy_data,row.name=FALSE,quote=FALSE,file="GACD-Project.out")
