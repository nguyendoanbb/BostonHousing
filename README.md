# BostonHousing
Predict housing price in Boston city

# Dataset Overview:
This dataset was taken from the Statlib Library which is maintained at Carnegie Melon University. The dataset was completed and published on July 7, 1993. It records housing values in suburbs of Boston with important attributes that may or may not affect the housing price such as per capita crime rate by town, proportion of residential land zoned for lots, proportion of non-retail business acress per town, and nitric oxides concentration etc.

# Objective:
The main purpose of this analysis is to predict housing price in Boston by selecting and using important attributes
This analysis also provides a descriptive and graphical summary of the data. 
This analysis will also produce and compare different statistical models in predicting housing price such as 
linear regression, random forest, penalized regression (ridge and lasso) and principal component analysis.

# Data description:
- ```crim```: per capita crime rate by town
- ```zn```: proportion of residential land zoned for lots over 25,000 sq.ft.
- ```indus```: proportion of non-retail business acres per town
- ```chas```: charles river dummy variable (=1 if tract bounds river; 0 otherwise)
- ```nox```: nitric oxides concentration (parts per 10 million)
- ```rm```: average number of rooms per dwelling
- ```age```: proportion of owner-occupied units built prior to 1940
- ```dis```: weighted distances to five Boston employment centres
- ```rad```: index of accessibility to radial highways
- ```tax```: full-value property-tax rate per $10,000
- ```ptratio```: pupil-teacher ratio by town
- ```b```: 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
- ```lstat```: percent lower status of the population
- ```medv```: median value of owner-occupied homes in $1000's

# Result:
- Linear regression produces a model with MSE equal approximately 0.0869
- Random forest produces a model with MSE equal approximately 0.0973

Both models are very similar in term of prediction metric. However, linear regression still encounter a non-constant variance, which may cause the prediction estimate to be very noisy for future data.
Random forest, on the other hand, randomly selects features in each trees. Thus, it leads to a better estimates, reduces varaince and helps to avoid overfitting. It is also less affected by outliers and multicollinearity. 

Hence, for this particular dataset, random forest is a model that perform better.