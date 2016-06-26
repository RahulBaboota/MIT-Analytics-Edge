## Solutions for Homework 2

###									Setting up the file and variable names

fluTrain = read.csv('FluTrain.csv')

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


