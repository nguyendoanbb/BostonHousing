###########################################Linear Regression#############################################

#####Simple linear regression
lm.full <- lm(log(medv)~., data=xy.train)
lm.step <- step(lm.full)
summary(lm.step)


#prediction using lm.step
lm.predict <- predict(lm.step, x.test)
lm.mse <- mean((lm.predict-y.test)^2)
#MSE is very high, we need to run diagnostics


#checking for response transformation
library(MASS)
library(caret)
medv.boxcox <- BoxCoxTrans(Boston.full$medv)
#for box-cox transformation, a lambda value of 1 is equivalent to using the original data
#the box-cox transformation suggests a lambda value = 0.2
Boston.full$medv.new <- predict(medv.boxcox, Boston.full$medv)

#####Linear regression with transformed response
#create new dataset with new transformed response
Boston.box1 <- Boston.full[,c('crim', 'zn', 'indus', 'chas', 'nox', 'rm', 'age', 'dis', 'rad',
                              'tax', 'ptratio', 'b', 'lstat', 'medv.new')]
box1.xy.train <- Boston.box1[train,]
box1.y.test <- Boston.box1[-train,'medv.new']
box1.x.test <- Boston.box1[-train, -length(Boston.box1)]


#re-perform linear regression with transformed response
lm.box1 <- lm(medv.new~., data=box1.xy.train)
lm.box1.step <- step(lm.box1)
lm.box1.pred <- predict(lm.box1.step, box1.x.test)
lm.box1.mse <- mean((lm.box1.pred - box1.y.test)^2) 
#response transformation tremendously reduces MSE

#####linear regression diagnostics
#Outliers detection
#Use cut-off value 4/(n-k-1), any observation has cook's distance > cut-off is considered outlier
cutoff.val <- 4/(nrow(Boston.box1)-length(lm.box1.step$coefficients)-1)

library(car)

outlierTest(lm.box1.step) #three observations (413,372,369) that may be outlier in term of age

###May need to re-run this part multiple times and remove outliers until outlierTest shows no more outliers
#re-run regression after eliminating outliers
Boston.box2 <- Boston.box1[-c(369,413,372,373,368,375),] #keep removing observations until no more outliers
box2.xy.train <- Boston.box2[train,]
box2.y.test <- Boston.box2[-train,'medv.new']
box2.x.test <- Boston.box2[-train, -length(Boston.box2)]
lm.box2 <- lm(medv.new~., data=box2.xy.train)
lm.box2.step <- step(lm.box2)
lm.box2.pred <- predict(lm.box2.step, box2.x.test)
lm.box2.mse <- mean((lm.box2.pred - box2.y.test)^2) #response transformation and eliminate outliers tremendously reduces MSE
#rerun outlier test
outlierTest(lm.box2.step)

################################################
install.packages('corrplot')
library(corrplot)
match(c('chas','medv.new'), names(Boston.box2))
corrplot(cor(Boston.box2[,-c(4,14)]), type = 'upper', order = 'hclust', tl.col = 'black', tl.srt = 45)
vif(lm.box2.step) #all VIF scores are less than 10, which is not considered problematic, hence, we do not remove any features

#non-normality
qqPlot(lm.box2.step, main='QQ Plot') #qqplot for studendized residuals shows linear pattern
hist(studres(lm.step), freq=F, main = 'Distribution of Studendized Residuals') #distribution is normal
xfit <- seq(min(studres(lm.step)), max(studres(lm.step)), length=100)
yfit <- dnorm(xfit)
lines(xfit, yfit)

#non-constant variance
ncvTest(lm.box2.step) #using Breusch-Pagan test, null: constant variance of residuals, alternative: non-constant variance of residuals
#the residual is non-constant, plot indicates the same conclusion, linear regression may not be appropriate for this dataset
plot(lm.box2.step, which = 1) #even after transformation, residuals plot still show non-constant variance.
