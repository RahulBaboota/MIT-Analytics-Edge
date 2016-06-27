## Solutions for Homework 2

###									Setting up the file and variable names

fluTrain = read.csv('FluTrain.csv')
fluTest = read.csv('fluTest.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1 

## In this problem , we want to get those weeks for which the ILI and the queries value is maximum . We can do this task via 2 
## approaches . In the first approach we can create a subset which contains only the maximum value of these queries and then we can 
## look at the dataframe .

week_ILI_max = subset( fluTrain , ILI == max(ILI))
week_ILI_max

week_Query_max  = subset( fluTrain , Query == max(Query))
week_Query_max

## Another approach which is more desirable is that we get the row numbers for the maximum values of these variables and then find 
## the week for this corresponding row. This approach is more desirable as it does not involve us populating our session with 
## dataframes.

row_ILI_max = which.max( fluTrain$ILI )
week_ILI_max = fluTrain$Week[row_ILI_max]

row_Query_max = which.max( fluTrain$row_Query_max )
week_Query_max = fluTrain$Query[row_Query_max]

## Next , we have to plot a histogram for the independent variable "ILI" . We can do this easily by using the hist() function .

histogram_ILI = hist( fluTrain$ILI )

## In the histogram , we can clearly observe that there are a greater number of observations which have a low value and smaller 
## number of observations which have a high value . In statistics terms , this kind of a histogram is said to be "Skewed Right".

## When we are encountered with skewed independent variables , it is often useful and meaningful to take their logarithms as this 
## prevents the very big or small values , i.e , the "outliers" from having a drastic effect on our measures of errors such as SSE 
## and R^2 . In here , we plot a curve between the log(ILI) and Queries .

log_ILI = log( fluTrain$ILI )
plot( fluTrain$Query , log_ILI )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## Now we create a linear regression model in which we only consider one independent variable "Queries" and the dependent variable 
## is log(ILI) as we saw from the above plot that there was a linear relationship between the two variables .

FluTrend1 = lm( log_ILI ~ Query , data= fluTrain )
summary(FluTrend1)

## For a single variable regression model , there is a direct relationship between the R^2 value and the correlation value between 
## the independent and dependent variable . However , there is no function in R which will help us to predict what that relationship 
## is. Therefore , we have to determine that independently .

correlation = cor( log(fluTrain$ILI) , fluTrain$Query )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## Now , we will predict values on our test data using the model we have created above . However ,  one important thing to note is
## that in the model created above , we are taking the log of our dependent variable , so the predictions will also be values of 
## log of our dependent variable . For this , we have to exponentiate our variable. 

PredTest1 = exp( predict( FluTrend1 , newdata = fluTest ))

## Now , we have to find the predictions for Week of March 11, 2012 . For this , we find out the row number for this week and
## then we find the corresponding value of the prediction using this obtained row number . 

row_number = which(fluTest$Week == "2012-03-11 - 2012-03-17")
PredTest1[row_number]

## We have to calcuate the relative error for our model for the above obtained week when we run it on test data .

relative_error = (fluTest$ILI[row_number] - PredTest1[row_number] ) / fluTest$ILI[row_number]

## Now , we need to find the Root Mean Squared Value .

SSE = sum((fluTest$ILI - PredTest1)^2)
RMSE = sqrt(SSE/nrow(fluTest))

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 4

## The observations we have in this dataset are consecutive weekly measurements of the dependent and independent variables .
## A dataset with such kind of observations is known as a "Time Series" dataset . We can improve our statistical model by 
## predicting the value of the current dependent variable using previous values of the dependent variables .

## In this , we will try predicting the values of ILI by using the approach defined above . We will make our model in such a 
## way that the decision maker has the record of the previous two weeks to predict the current value of ILI . To do this , we 
## will have to install a R package named as "zoo" . 

install.packages('zoo')
library(zoo)

ILILag2 = lag( zoo( fluTrain$ILI) ,-2, na.pad=TRUE)
fluTrain$ILILag2 = coredata(ILILag2)

## In line 102 , we are creating a variable ILILag2 wherein we store the predicted values for the current dependent variable which
## in this case is ILI . The argument -2 means to return 2 observations prior to the current observation . The argument 
## "na.pad = TRUE" means that we are setting the values of ILI for the first 2 weeks wherein we dont have any kind of prior data
## to predict these values .

## Plotting a curve between log(ILILag2) and log(ILI)

plot( log(fluTrain$ILILag2) , log(fluTrain$ILI) )

## Creating another linear regression model

FluTrend2 = lm( ILI ~ Queries + ILILag2 , data = fluTrain)
summary(PredTest2)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 5

## So far we have only added the ILILag2 variable to our training set . In order to make predictions with our FluTrend2 model , we
## need to add this variable to our testing set as well .

ILILag2 = lag ( zoo( fluTest$ILI) ,-2, na.pad=TRUE)
fluTest$ILILag2 = coredata(ILILag2)

## In our training and testing sets , the data is splitted sequentially . Our testing set contains data from the year 2004-2011 and 
## training set contains data from the year 2012 . Therefore , it is in continuation . Therefore , we can predict the ILILag2 
## values for the first two values of the testing set from the ILILag2 values of the training set .

length_of_training_set = nrow(fluTrain)

fluTest$ILILag2[1]=fluTrain$ILILag2[length_of_training_set-1]
fluTest$ILILag2[2]=fluTrain$ILILag2[length_of_training_set]

## Root Mean Squared Value for the FluTrend2 Model 

SSE = sum((fluTest$ILILag2 - PredTest2)^2)
RMSE = sqrt(SSE/nrow(fluTest))

## -----------------------------------------------------------------------------------------------------------------------------

