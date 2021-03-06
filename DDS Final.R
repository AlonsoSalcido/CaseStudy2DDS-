library(ggplot2)
library(GGally)
library(GGpairs)
library(dplyr)
library(tidyverse)
library(e1071)

EDA= CaseStudy

summary(EDA)
head(EDA)

#Irrelevant Columns
drop= c("EmployeeCount", "EmployeeNumber", "Over18", "StandardHours", "Attrition.1")
EDA= EDA[ , !(names(EDA) %in% drop)]

#Graph Attrition
ggplot(EDA, aes(x="", y=Attrition, fill=Attrition)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y")

#Attrition by Numbers
AttritionYes=nrow(EDA[EDA$Attrition == "Yes",])
AttritionNo=nrow(EDA[EDA$Attrition == "No",])
AttritionPercent= nrow(EDA[EDA$Attrition == "Yes",])/nrow(EDA[EDA$Attrition == "No",])
AttritionYes
AttritionNo
AttritionPercent

#Categorical Variables
#Travel
ggplot(EDA,mapping=aes(x=Attrition,fill=BusinessTravel))+
  geom_bar(position="fill")+
  ggtitle("Attrition by Travel")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())
#No Difference

#Department
ggplot(EDA,mapping=aes(x=Attrition,fill=Department))+
  geom_bar(position="fill")+
  ggtitle("Attrition by Department")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

SalesAttrition= nrow(EDA[EDA$Attrition == "Yes" & EDA$Department == "Research & Development",])/nrow(EDA[EDA$Attrition == "Yes",])
SalesNoAttrition=nrow(EDA[EDA$Attrition == "No" & EDA$Department == "Research & Development",])/nrow(EDA[EDA$Attrition == "No",])
RDAttrition=nrow(EDA[EDA$Attrition == "Yes" & EDA$Department == "Sales",])/nrow(EDA[EDA$Attrition == "Yes",])
RDNoAttrition=nrow(EDA[EDA$Attrition == "No" & EDA$Department == "Sales",])/nrow(EDA[EDA$Attrition == "No",])
#Sales is the Department with Highest Attrition 
SalesAttrition
SalesNoAttrition
#Research and Development is the Department with Less Attrition
RDAttrition
RDNoAttrition

#EducationField
ggplot(EDA,mapping=aes(x=Attrition,fill=EducationField))+
  geom_bar(position="fill")+
  ggtitle("Attrition by EducationField")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

nrow(EDA[EDA$Attrition == "Yes" & EDA$EducationField == "Technical Degree",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$EducationField == "Technical Degree",])/nrow(EDA[EDA$Attrition == "No",])

#Gender
ggplot(EDA,mapping=aes(x=Attrition,fill=Gender))+
  geom_bar(position="fill")+
  ggtitle("Attrition by Gender")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

#JobRole
ggplot(EDA,mapping=aes(x=Attrition,fill=JobRole))+
  geom_bar(position="fill")+
  ggtitle("Attrition by JobRole")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

nrow(EDA[EDA$Attrition == "Yes" & EDA$JobRole == "Sales Representative",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$JobRole == "Sales Representative",])/nrow(EDA[EDA$Attrition == "No",])
nrow(EDA[EDA$Attrition == "Yes" & EDA$JobRole == "Research Director",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$JobRole == "Research Director",])/nrow(EDA[EDA$Attrition == "No",])
nrow(EDA[EDA$Attrition == "Yes" & EDA$JobRole == "Manager",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$JobRole == "Manager",])/nrow(EDA[EDA$Attrition == "No",])

#MaritalStatus
ggplot(EDA,mapping=aes(x=Attrition,fill=MaritalStatus))+
  geom_bar(position="fill")+
  ggtitle("Attrition by MaritalStatus")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

nrow(EDA[EDA$Attrition == "Yes" & EDA$MaritalStatus == "Single",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$MaritalStatus == "Single",])/nrow(EDA[EDA$Attrition == "No",])
nrow(EDA[EDA$Attrition == "Yes" & EDA$MaritalStatus == "Divorced",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$MaritalStatus == "Divorced",])/nrow(EDA[EDA$Attrition == "No",])

#Overtime
ggplot(EDA,mapping=aes(x=Attrition,fill=OverTime))+
  geom_bar(position="fill")+
  ggtitle("Attrition by OverTime")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())
nrow(EDA[EDA$Attrition == "Yes" & EDA$OverTime == "Yes",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$OverTime == "Yes",])/nrow(EDA[EDA$Attrition == "No",])

#Ordinal Variables
# Make Attrition Numeric
NEDA = EDA[,c(3, 1:32)]
NEDA$Attrition=gsub('No', 0 , NEDA$Attrition)
NEDA$Attrition=gsub('Yes', 1 , NEDA$Attrition)
NEDA$Attrition= as.numeric(NEDA$Attrition) #Numeric

NEDA %>% ggplot(aes(EnvironmentSatisfaction, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(JobInvolvement, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(JobLevel, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(JobSatisfaction, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(NumCompaniesWorked, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(StockOptionLevel, Attrition)) + geom_smooth()
NEDA %>% ggplot(aes(WorkLifeBalance, Attrition)) + geom_smooth()

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(EnvironmentSatisfaction)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by EnvironmentSatisfaction")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())


ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(JobInvolvement)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by JobInvolvement")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(JobLevel)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by JobLevel")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(JobSatisfaction)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by JobSatisfaction")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(NumCompaniesWorked)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by NumCompaniesWorked")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(StockOptionLevel)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by StockOptionLevel")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())

ggplot(EDA,mapping=aes(x=Attrition,fill=as.character(WorkLifeBalance)))+
  geom_bar(position="fill")+
  ggtitle("Attrition by WorkLifeBalance")+
  ylab("Percentage")+
  scale_y_continuous(labels = scales::percent_format())
nrow(EDA[EDA$Attrition == "Yes" & EDA$WorkLifeBalance == "1",])/nrow(EDA[EDA$Attrition == "Yes",])
nrow(EDA[EDA$Attrition == "No" & EDA$WorkLifeBalance == "1",])/nrow(EDA[EDA$Attrition == "No",])

#Continuous Variables
#Age
ggplot(EDA, aes(x=Attrition, y=Age, fill=Attrition)) + 
  geom_boxplot(notch=TRUE) +
  stat_summary(fun.y=mean, geom="point", shape=18, size=10, color="black", fill="red")+
  ggtitle("Attrition by Age") 


#DistanceFromHome
ggplot(EDA, aes(x=Attrition, y=DistanceFromHome, fill=Attrition)) + 
  geom_boxplot(notch=TRUE) +
  stat_summary(fun.y=mean, geom="point", shape=18, size=10, color="black", fill="red")+
  ggtitle("Attrition by DistanceFromHome") 


#MonthlyIncome
ggplot(EDA, aes(x=Attrition, y=MonthlyIncome, fill=Attrition)) + 
  geom_boxplot(notch=TRUE) +
  stat_summary(fun.y=mean, geom="point", shape=18, size=10, color="black", fill="red")+
  ggtitle("Attrition by MonthlyIncome") 


#YearsInCurrentRole
ggplot(EDA, aes(x=Attrition, y=YearsInCurrentRole, fill=Attrition)) + 
  geom_boxplot(notch=TRUE) +
  stat_summary(fun.y=mean, geom="point", shape=18, size=10, color="black", fill="red")+
  ggtitle("Attrition by YearsInCurrentRole") 


#Predict Attrition
#KNN

KNNEDA = EDA

#Drop Non Relevant Variables
drop= c("ID", "DailyRate", "Education", "Gender", "HourlyRate")
KNNEDA= KNNEDA[ , !(names(KNNEDA) %in% drop)]
KNNEDA$Attrition=factor(KNNEDA$Attrition)

#TransformCategorical Variables
KNNEDA$Non_Travel= ifelse(KNNEDA$BusinessTravel == "Non-Travel",1,0)
KNNEDA$Travel_Frequently= ifelse(KNNEDA$BusinessTravel == "Travel_Frequently",1,0) 
KNNEDA$Travel_Rarely= ifelse(KNNEDA$BusinessTravel == "Travel_Rarely",1,0) 

KNNEDA$HRDepartment= ifelse(KNNEDA$Department == "Human Resources",1,0)
KNNEDA$RDDepartment= ifelse(KNNEDA$Department == "Research & Development",1,0)
KNNEDA$SalesDepartment= ifelse(KNNEDA$Department == "Sales",1,0)

KNNEDA$HumanResourcesDegree= ifelse(KNNEDA$EducationField == "Human Resources",1,0)
KNNEDA$LifeSciencesDegree= ifelse(KNNEDA$EducationField == "Life Sciences",1,0)
KNNEDA$MarketingDegree= ifelse(KNNEDA$EducationField == "Marketing",1,0)
KNNEDA$MedicalDegree= ifelse(KNNEDA$EducationField == "Medical",1,0)
KNNEDA$OtherDegree= ifelse(KNNEDA$EducationField == "Other",1,0)
KNNEDA$TechnicalDegree= ifelse(KNNEDA$EducationField == "Technical Degree",1,0)

KNNEDA$HealthcareRep= ifelse(KNNEDA$JobRole == "Healthcare Representative",1,0)
KNNEDA$HumanResources= ifelse(KNNEDA$JobRole == "Human Resources",1,0)
KNNEDA$LaboratoryTechnician= ifelse(KNNEDA$JobRole == "Laboratory Technician",1,0)
KNNEDA$Manager= ifelse(KNNEDA$JobRole == "Manager",1,0)
KNNEDA$ManufacturingDirector= ifelse(KNNEDA$JobRole == "Manufacturing Director",1,0)
KNNEDA$ResearchDirector= ifelse(KNNEDA$JobRole == "Research Director",1,0)
KNNEDA$ResearchScientist= ifelse(KNNEDA$JobRole == "Research Scientist",1,0)
KNNEDA$SalesExec= ifelse(KNNEDA$JobRole == "Sales Executive",1,0)
KNNEDA$SalesRep= ifelse(KNNEDA$JobRole == "Sales Representative",1,0)

KNNEDA$Divorced= ifelse(KNNEDA$MaritalStatus == "Divorced",1,0)
KNNEDA$Married= ifelse(KNNEDA$MaritalStatus == "Married",1,0)
KNNEDA$Single= ifelse(KNNEDA$MaritalStatus == "Single",1,0)

KNNEDA$OverTime= ifelse(KNNEDA$OverTime == "Yes",1,0)

#Drop Transformed Variables
drop= c("BusinessTravel", "Department", "EducationField", "Gender", "JobRole", "MaritalStatus")
KNNEDA= KNNEDA[ , !(names(KNNEDA) %in% drop)]
KNNEDA= KNNEDA[,c(2, 1:46)]
KNNEDA= KNNEDA[ , !(names(KNNEDA)=="Attrition.1")]

#Top 3 Factors of Attrition
model=glm(Attrition~.,data = KNNEDA, family= "binomial")
summary(model)
#OverTime, JobInvolvement, JobSatisfaction



KNNEDA1= KNNEDA[, c(1,3,4,6, 11, 15,18, 23, 28, 34, 39, 43,46)]
set.seed(1)
confusionMatrix(table(knn.cv(KNNEDA1[,2:12],KNNEDA1$Attrition, k = 1), KNNEDA1$Attrition))

#Attrition-Naive Bayes
set.seed(1)
trainIndices = sample(1:dim(KNNEDA)[1],round(splitPerc * dim(KNNEDA)[1]))
train = KNNEDA[trainIndices,]
test = KNNEDA[-trainIndices,]

model_train = naiveBayes(Attrition~.,data = train)
predict(model_train, train[,c(4,5,6,8,10,11,15,18,19,24,43,46)])

model_test = naiveBayes(Attrition~.,data = test)
classifications=predict(model_test, test[,c(4,5,6,8,10,11,15,18,19,24,43,46)])
CM_NaiveBayes=confusionMatrix(table(classifications,test$Attrition))
CM_NaiveBayes
