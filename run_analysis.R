# save the data into variables, assuming it has been downloaded
# and named "project.zip" as in the following, commented-out
# portion:

# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl,"project.zip")
unzip("project.zip",exdir="project",overwrite=TRUE)
setwd("project/UCI HAR Dataset/test")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
setwd("../train")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

#merge the data appropriately
dataset <- rbind(X_train,X_test)
labs <- rbind(y_train,y_test)
subs <- rbind(subject_train,subject_test)
data2 <- cbind(subs, dataset)
tidy <- cbind(labs, data2)

#use feature names to make column name vector
setwd("..")
names <- read.table("features.txt")
names <- as.character(names[,2])
names <- paste(names,sep="")
names(tidy) <- c("Activity","Subject",names)

#clean up feature names
names(tidy) <- gsub("BodyBody", "Body", names(tidy))
names(tidy) <- gsub("()-","_",names(tidy))
names(tidy) <- gsub("-","_",names(tidy))
names(tidy) <- gsub("()","",fixed=TRUE,names(tidy))

#get only id columns, mean and std
subtidy <- tidy[, c("Activity","Subject",
                    colnames(tidy)[grep("mean|std",colnames(tidy))])]
#rename activities
subtidy$Activity <- gsub("1","walking",subtidy$Activity)
subtidy$Activity <- gsub("2","walking_upstairs",subtidy$Activity)
subtidy$Activity <- gsub("3","walking_downstairs",subtidy$Activity)
subtidy$Activity <- gsub("4","sitting",subtidy$Activity)
subtidy$Activity <- gsub("5","standing",subtidy$Activity)
subtidy$Activity <- gsub("6","laying",subtidy$Activity)

# new dataset with averages of mean and std measures
# made using dplyr package functions
subtidy <- tbl_df(subtidy)
by_activity <- group_by(subtidy,Subject,Activity)
tidiest <- summarise_each(by_activity,funs(mean))
write.table(tidiest,file="step5.txt",row.names=FALSE)
