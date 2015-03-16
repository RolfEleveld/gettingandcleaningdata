#Libraries used in script
library(dplyr)

#1. Merges the training and the test sets to create one data set
# create a working directory, and if it exists skip the next step
#  download the zip as binary file and store it locally
if (!file.exists("UCIDataset.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  "UCIDataset.zip",
                  mode="wb")
}
#remove the directory if it already exists
if (file.exists("UCIdata")){unlink("UCIdata", recursive=TRUE)}
dir.create("UCIdata")
# unzip the contents of the zip to a working folder
unzip("UCIDataset.zip", exdir="UCIdata")

#load the data as a text file into a data frame from the training and the test
#read the column lables
lbl <- read.delim(file="UCIdata/UCI HAR Dataset/features.txt",
                  header=FALSE,
                  sep=" ",
                  as.is=TRUE)
#make this proper labels
lbl <- mutate(lbl,V2=gsub(",","_",gsub("[()]", "", V2)))

#files are 16 cars wide set of numbers. 
# 'UCIdata/UCI HAR Dataset/train/X_train.txt': Training set.
tdf <- read.fwf(file="UCIdata/UCI HAR Dataset/train/X_train.txt",
                header=FALSE,
                widths=rep(16L,561),
                col.names=lbl[,2],
                buffersize=100)
ltdf <- read.delim(file="UCIdata/UCI HAR Dataset/train/y_train.txt",
                   header=FALSE,
                   sep=" ",
                   as.is=TRUE)
names(ltdf)<-c("activity")
stdf <- read.delim(file="UCIdata/UCI HAR Dataset/train/subject_train.txt",
                   header=FALSE,
                   sep=" ",
                   as.is=TRUE)
names(stdf)<-c("subject")
tdf <- cbind(stdf, ltdf, tdf)

# 'UCIdata/UCI HAR Dataset/test/X_test.txt': Test set.
adf <- read.fwf(file="UCIdata/UCI HAR Dataset/test/X_test.txt",
                header=FALSE, 
                widths=rep(16L,561), 
                col.names=lbl[,2],
                buffersize=100)
ladf <- read.delim(file="UCIdata/UCI HAR Dataset/test/y_test.txt",
                   header=FALSE,
                   sep=" ",
                   as.is=TRUE)
names(ladf)<-c("activity")
sadf <- read.delim(file="UCIdata/UCI HAR Dataset/test/subject_test.txt",
                   header=FALSE,
                   sep=" ",
                   as.is=TRUE)
names(sadf)<-c("subject")
adf <- cbind(sadf, ladf, adf)

#join tables
data = rbind(tdf,adf)
#clean up rest, lbl is needed below.
rm(tdf,adf,ltdf,ladf,stdf,sadf)

#2. Extracts only the measurements on the mean and standard deviation for each measurement
#get only the column names that have mean or std in them.
matches<-names(data)[c(1,2,grep("mean|std", lbl$V2)+2)] 
# note that there are 2 extra columns at the beginning
mean_and_std_data <- data[,matches]
#cleanup
rm(matches, data, lbl)

#3. Uses descriptive activity names to name the activities in the data set
activitylbl <- read.delim(file="UCIdata/UCI HAR Dataset/activity_labels.txt",
                          header=FALSE,
                          sep=" ",
                          as.is=TRUE)
activity_labeled_data <- mutate(mean_and_std_data, activity = activitylbl[activity,2])
#cleanup
rm(activitylbl, mean_and_std_data)

#4. Appropriately labels the data set with descriptive variable names
labeled_data <- activity_labeled_data
rm(activity_labeled_data)

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject
summarized_data <- labeled_data %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
if (file.exists("summarized_data.tbl.txt")){file.remove("summarized_data.tbl.txt")}
write.table(summarized_data, file="summarized_data.tbl.txt", row.name=FALSE)

#cleanup
rm(labeled_data,summarized_data)