run_analysis<-function(parentDir=".\\UCI HAR Dataset")
{
  #Load all the individual files in tables
  #Parent Directory first
  activities<-read.table(paste(parentDir, "\\activity_labels.txt", sep=""))
  features<-read.table(paste(parentDir, "\\features.txt", sep=""))
  #Train folder
  xTrain<-read.table(paste(parentDir, "\\train\\X_train.txt", sep=""))
  yTrain<-read.table(paste(parentDir, "\\train\\y_train.txt", sep=""))
  subTrain<-read.table(paste(parentDir, "\\train\\subject_train.txt", sep=""))
  #Test folder
  xTest<-read.table(paste(parentDir, "\\test\\X_test.txt", sep=""))
  yTest<-read.table(paste(parentDir, "\\test\\y_test.txt", sep=""))
  subTest<-read.table(paste(parentDir, "\\test\\subject_test.txt", sep=""))
  
  #Assign correct names to columns according to the feature file
  names(xTest)<-features$V2
  names(xTrain)<-features$V2
  
  #Delete all columns that do not contain a mean or std on the name
  xTestClean<-xTest[,(grepl("mean",names(xTest)) |grepl("std",names(xTest)))]
  xTrainClean<-xTrain[,(grepl("mean",names(xTrain)) |grepl("std",names(xTrain)))]
  
  #Join table and activity name
  yTestClear<-merge(activities,yTest)
  yTrainClear<-merge(activities,yTrain)

  #Bind columns subject and activity 
  tempTest<-cbind(yTestClear,subTest$V1)
  tempTrain<-cbind(yTrainClear,subTrain$V1)
  tempTest$V1<-NULL# Delete Id row not necessary anymore
  tempTrain$V1<-NULL
  names(tempTest)<-cbind("Activity","SubjectId")
  names(tempTrain)<-cbind("Activity","SubjectId")
  temp<-rbind(tempTrain,tempTest)
  
  #Merge X test and train together
  X<-rbind(xTrainClean,xTestClean)
  
  #Merge Activities and subject with X
  data<-cbind(temp, X)
  
  #Creating second table "Tidy" based on the original data
  tidyData<-aggregate(data[3:length(data)], list(Subject = data$SubjectId, Activity = data$Activity), mean)
  
  #Save to file
  write.table(tidyData,"tidy.txt")
  
  #Return tidy set
  return (tidyData)
}