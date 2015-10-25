
"The command below unzips and extracts the Samsung data located in the WD"
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

"Load the needed library"
library(dplyr)
library(plyr)
########################################################################
"Step1 : Creating a single dataset by merging Test and Train data sets"

"Load data from provided Dataset"

TestX<-read.table("UCI HAR Dataset\\test\\X_test.txt")
TrainX<-read.table("UCI HAR Dataset\\train\\X_train.txt")
Features<-read.table("UCI HAR Dataset\\features.txt")
Testy<-read.table("UCI HAR Dataset\\test\\y_test.txt")
Trainy<-read.table("UCI HAR Dataset\\train\\y_train.txt")
TrainSubject<-read.table("UCI HAR Dataset\\train\\subject_train.txt")
TestSubject<-read.table("UCI HAR Dataset\\test\\subject_test.txt")

"Merge the Training and Testing X data sets and labelling the columns using Features.txt"
MergeX<-rbind(TrainX,TestX)
###############################################################

"Step 4:"
"Labelling the variables with descriptive names"
Xlabels<-as.character(Features$V2)
colnames(MergeX)<-Xlabels

###############################################################
"Step 1 : contd..."

"Merging the y and subject data from Train and Test"
Mergey<-rbind(Trainy,Testy)
colnames(Mergey)<-"Activity_id"
Mergesubject<-rbind(TrainSubject,TestSubject)
colnames(Mergesubject)<-c("Subject_id")

"Combine X, y and Subject data into one single super dataset"
Mergedata<-cbind(MergeX,Mergey,Mergesubject)

#########################################################################

"Step2: Extract only Mean and STD from the super data set"
Data_meanstd<-Mergedata[c( grep("(mean\\(|std\\()", names(Mergedata), value = TRUE),"Activity_id","Subject_id")]

#######################################################################
"Step 3:Use descriptive activity names to name activities in dataset"

"Read Activity id and Activity name from Activity_labels.txt"
Activity<-read.table("UCI HAR Dataset\\activity_labels.txt")
colnames(Activity)<-c("Activity_id","Activity_Name")

"Activity Name is a factor. So converting to character"
Activity$Activity_Name<-as.character(Activity$Activity_Name)

"Replace Activity ids with Activity names"
Data_meanstd<-join(Data_meanstd,Activity) 
MeanStd<-select(Data_meanstd, -Activity_id)

"Step 5:"

"Group the previous dataset on Subject id and Activity name and calculate mean for each combination"        
tidydata<-MeanStd %>% group_by(Subject_id,Activity_Name) %>% summarise_each(funs(mean))

"Write the generated tidy dataset into a text file"
write.table(tidydata, "tidydata.txt", sep="\t", col.names=F)