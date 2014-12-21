---
title: "README"
output: html_document
---

The run_analysis script uses the accelerometer data from
the Samsung Galaxy S smartphone. It first merges the test and training sets, including the activities and subjects. It then uses the provided features.txt as a starting point to name the variables, using gsub to remove some illegal characters and mistakes in the original labels. The activity codes are then replaced with the corresponding labels. The dataset is subsetted to retain only the columns corresponding to means and standard deviations for each measurement. Finally, a second, independent data set is created using functions from dplyr that gives the average of each variable for each subject and activity. This data set is saved to a txt file called 'step5.txt'.