---
title: "Codebook"
author: "Rolf Eleveld"
date: "Friday, March 13, 2015"
output: html_document
---
#This document describes the variables used in run_analysis.R script
There are 5 sections in the source for each partial assignment one.

##1. Create one dataset
The loading of the data from disk and processing it into labeled data.frame
Used:

```{r}
lbl # will contain all column labels from the data set as given by the zip file
```
I have updated the labeling to remove the brackets () from the column names as they translate into .
I have also updated the use of , in the column labes to be using an underbar _ instead.

Collect the training data, note tdf will be column joined with ltdf and stdf
```{r}
tdf  # will contain the whole data from the training process, and will be labeled immediately with the labels from lbl
ltdf # will contain the activity label for the training process
stdf # will contain the subject reference for the training process
```
Then collect the test data, note adf will be column joined with ladf and sadf
```{r}
adf # will contain the whole data from the test process, and will be labeled immediately with the labels from lbl
ladf # will contain the activity label for the test process
sadf # will contain the subject reference for the test process
```
Join all data together
```{r}
data # will contain the row joined tdf and adf
```
only lbl and data will be kept, the other variables will be cleared.

##2. only mean and std
The only keep the mean and std values in the data collected.
```{r}
matches           # will contain subject, activity, and the data column names that have the word mean or std in their label 
mean_and_std_data # is the subset from data selecting only the colomns mentioned in matches
```
only mean_and_std_data will be kept all other variables are cleared.

##3. Proper labeled activities
Have sensible values in the activities column
```{r}
activitylbl           # will contain the mapping data for the activity labels as defined in the data set
activity_labeled_data # will contain the updated data from mean_and_std_data with the proper values for activity
```

##4. labeled data
This has already been achieved in #1 to have clean column names
```{r}
labeled_data # will contain an exact copy of activity_labeled_data
```
only labeled_data will be kept

##5. Grouped means
Group data by subject and activity and get the means of the columns in the grouped data
```{r}
summarized_data #will contain the resulting mean of each column per subject and activity
```
The summarized_data data table will be written to a file named: summarized_data.tbl.txt in the working directory

All variables will be cleared