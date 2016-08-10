## Solutions for Homework 3

###									Setting up the file and variable names

Census = read.csv("census.csv")

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Firstly , we will split our data into a Training and Testing set using R's library caTools .

library(caTools)
set.seed(2000)
spl = sample.split( Census$over50k , SplitRatio = 0.6 )
Train = subset( Census , spl == TRUE )
Test = subset( Census , spl == FALSE )

## After that , we will create a logistic regression model to predict "over50k" using all of the other independent variables .
## We will then check which of the variables are significant .

LogisticModel1 = glm( over50k ~ . , data = Train , family = "binomial" )
summary(LogisticModel1)

## After that , we will check the accuracy of our model by making predictions on the Test set .

LogisticPrediction1 = predict( LogisticModel1 , newdata = Test , type = "response" )
table( Test$over50k , LogisticPrediction1 > 0.5 )

## For comparison purposes , we now compute the accuracy of our baseline model . The baseline model will make the most frequently 
## occuring result in our Training Set as the default result for our Test Set .

table( Train$over50k )
table( Test$over50k )

## We will then compute the AUC of our following model .

library(ROCR)
ROCRpred = prediction( LogisticPrediction1 , Test$over50k )
as.numeric(performance(ROCRpred, "auc")@y.values)

## -----------------------------------------------------------------------------------------------------------------------------
