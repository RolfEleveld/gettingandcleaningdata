---
title: "Readme"
author: "Rolf Eleveld"
date: "Friday, March 13, 2015"
output: html_document
---
#How to run run_analysis.R
##requiremnts
The script relies on the dplyr package, and must be installed from CRAN beforehand

##Operations
Script can be run without parameters
```{r}
source("run_analysis.R")
```
The script will download the zip if the zip file is not found, otherwise it will extract the file to a folder called UCIdata, which will be removed if it exists.
The following files will be consumed from the data:

1. UCIdata/UCI HAR Dataset/features.txt
2. UCIdata/UCI HAR Dataset/train/X_train.txt
3. UCIdata/UCI HAR Dataset/train/y_train.txt
4. UCIdata/UCI HAR Dataset/train/subject_train.txt
5. UCIdata/UCI HAR Dataset/test/X_test.txt
6. UCIdata/UCI HAR Dataset/test/y_test.txt
7. UCIdata/UCI HAR Dataset/test/subject_test.txt
8. UCIdata/UCI HAR Dataset/activity_labels.txt

The loading of the files and processing does take quite a while, there is no output while importing the data files.

The following will be written, and overwritten if it exists:

* summarized_data.tbl.txt

##Acknowledgements
Acknowledging the use of data used:
License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012