## Solutions for Homework 2

###									Setting up the file input and including libraries

Letters = read.csv('letters_ABPR.csv')
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Let us first add a factor variable which tells us wether the observation is "B" or not . 

Letters$isB = as.factor(Letters$letter=="B")

## Now , let us divide the data into Training and Testing sets on the basis of the variable "isB" . 

library(caTools)
set.seed(1000)
spl = sample.split( Letters$isB , SplitRatio = 0.5 )
Train = subset( Letters , spl == TRUE )
Test = subset( Letters , spl == FALSE )

## Let us now make a CART Model for predicting the variable "isB" . 

library(rpart)
library(rpart.plot)

CartModel1 = rpart( isB ~ . - letters , data = Train , method = "class" )
Predictions1 = predict( CartModel1 , newdata = Test , type = "class" )

## Now , let us check the accuracy of our model by creating a confusion matrix .
table( Test$isB , Predictions1 )

## Now , let us create a Random Forest Model for the same .

library(randomForest)
set.seed(1000)

CartModel2 = randomForest( isB ~ . - letters , data = Train )
Predictions2 = predict( CartModel2 , newdata = Test )

## Now , let us check the accuracy of our model by creating a confusion matrix .
table( Test$isB , Predictions2 )

## -----------------------------------------------------------------------------------------------------------------------------
