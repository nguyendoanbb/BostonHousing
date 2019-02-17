#####Data Setup
rm(list=ls()) #clear current R environment
setwd("~/BostonHousing")
Boston <- read.csv("HousingData.csv")
names(Boston) <- sapply(names(Boston), tolower)

###Data Splitting

#change "chas" variable to factor
Boston$chas <- as.factor(Boston$chas)

#check NAs
summary(is.na(Boston))

#handle NA values by using multivariate imputation by chained equation
library(mice)
set.seed(1)
imp <- mice(Boston, m=5)
Boston.full <- complete(imp)
Boston.full$chas <- as.factor(Boston.full$chas)

#recheck NAs
summary(is.na(Boston.full))

#split dataset into train and test
set.seed(12)
train <- sample(1:nrow(Boston.full), nrow(Boston.full)/2)
xy.train <- Boston.full[train,]
y.test <- Boston.full[-train,'medv']
x.test <- Boston.full[-train, -dim(Boston.full)[2]]

