############random forest
install.packages('randomForest')
library(randomForest)
library(MASS)

#convert integer to numerical features
for (i in c(1:length(box1.xy.train))){
  if (is.integer(box1.xy.train[,i]) == TRUE){
    box1.xy.train[,i] = as.numeric(box1.xy.train[,i])
  } 
}

#Using built-in function random forest
rf.box1 <- randomForest(medv.new~. , data=box1.xy.train,
                            importance=TRUE, ntree = 500)
yhat.box1 <- predict(rf.box1, newdata=box1.x.test)
mean((yhat.box1-box1.y.test)^2) #MSE 

#using my own trainforest function with variable importance plot
trainforest(response = box1.xy.train[,"medv.new"], features = box1.xy.train[,-length(box1.xy.train)],
            new.response = box1.y.test, new.features = box1.x.test,
            cv.fold = 10, cv.step = 0.8, cv.recursive = F)

#Conclusion:
#Random forest generate a model with very similar MSE.
#However, due to its ability to not overfit with a large number of trees, random forest is recommended over linear regression
