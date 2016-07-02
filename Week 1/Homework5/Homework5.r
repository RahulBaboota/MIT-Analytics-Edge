## Solutions for Homework 5

###									Setting up the file and variable names

salesData = read.csv('elantra.csv')
trainData = subset( salesData , Year <= 2012 )
testData = subset( salesData , Year > 2012 )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Firstly , we have to find the number of observations in the training data .

no_of_observations_train = nrow(testData)
str(testData)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## Herein , we will build a linear regression model using four of our independent variables .

salesModel1 = lm( ElantraSales ~ Queries + CPI_energy + CPI_all + Unemployment , data = trainData )
summary(salesModel1)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## We observed above that the R^2 value of our model was not very great . While modeling sales and demand models , it is very 
## important to take into account the seasonality as it might be the case that the sale of a product is quite high during a 
## particular time in the year and might be quite low during another time of the year . Therefore , to make our model better 
## we will also include "Month" as an independent variable .

salesModel2 = lm( ElantraSales ~ Queries + CPI_energy + CPI_all + Unemployment + Month , data = trainData )
summary(salesModel2)

## When we look at the summary of the second model , we notice one pecularity in the coefficient of "Month". In our dataframe
## the month is recorded as a numeric value and thus from our observations , we see that for every month we progress into the
## year , our sales should go up . However , we know that this is not true . Therefore , the correct method of including 
## month in our model would be to add it as a factor variable . 

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 4

## We discussed above that we need to include month as a factor variable in our regression model . For this , we create a new 
## variable monthfactor in which we will store values of the month variable by treating it as a factor variable . To do this ,
## we will use R's inbuilt method as.factor() .

testData$MonthFactor = as.factor( testData$Month )
trainData$MonthFactor = as.factor( trainData$Month )

## We then create another linear regression model wherein we include month as a factor variable and not as a numneric variable.

salesModel3 = lm( ElantraSales ~ Queries + CPI_energy + CPI_all + Unemployment + MonthFactor , data = trainData )
summary(salesModel3)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 5

## We can see from the summary of the above model that the sign of the coefficient of queries has changed . Also , the coefficient
## of CPI_energy is positive i.e. as the cost of energy increases , the sales of elantra also increases . However, by intuition
## only , we can judge that this is incorrect because if the price of energy increases , people will have less money and thus
## the sales should go down . Thus , we can safely say that these peculiar results are due to multicollinearty.

cor(trainData[c("Unemployment","Month","Queries","CPI_energy","CPI_all")])

## -----------------------------------------------------------------------------------------------------------------------------

## Now , we will finally create the best suiting model for our problem which is devoid of any insignificant variables .

salesModel4 = lm( ElantraSales ~ CPI_energy + CPI_all + Unemployment + MonthFactor , data = trainData )
summary(salesModel4)

## Now , we will make predictions from the above created model on our testData. Then , we will calculate the sum of squared errors
## for our test set predictions .

predictTest = predict( salesModel4 , newdata = testData )

SSE = sum(( testData$ElantraSales - predictTest ) ^2 ) 
SSE

## After that , we will calculate what the baseline predictions would have predicted .

baseline_predictions = mean( trainData$ElantraSales )
baseline_predictions

## Now , we will calculate the value of R^2 for our test set predictions .

SST = sum(( baseline_predictions - testData$ElantraSales ) ^2 )
SST

R^2 = 1 -SSE/SST
R^2

## We can then find out that which prediction was the least accurate or we can check for the maximum absolute error made when
## predicting .

max_error = max(abs(PredictTest - ElantraTest$ElantraSales))
max_error

## Then , we can find out for what year and month were these predictions made 

max_error_row_no = which.max(abs(PredictTest - ElantraTest$ElantraSales))

max_error_month = testData$Month[max_error_row_no]
max_error_month

max_error_year = testData$Year[max_error_row_no]
max_error_year


## -----------------------------------------------------------------------------------------------------------------------------
