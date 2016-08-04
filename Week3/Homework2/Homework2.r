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

## Problem 2

## Now , we will solve the original problem of predicting the letter . 

## For this , we firstly need to convert the "letter" variable into a factor variable .

Letters$letter = as.factor(Letters$letter)

## Then , we need to create new Training and Testing Data .

library(caTools)
set.seed(2000)
spl = sample.split( Letter$letters , SplitRatio = 0.5 )
Train = subset( Letters , spl == TRUE )
Test = subset( Letters , spl == FALSE )

## After that we will create a baseline model which is nothing but assigning the most frequently occuring value in the Training data
## to all the observations in the Test data .

table( Train$letters )

## Let us now create a CART Model to predict the letter .

library(rpart)
library(rpart.plot)

CartModel3 = rpart( letters ~ . - isB , data = Train , method = "class" )
Predictions3 = predict( CartModel3 , newdata = Test , type = "class" )

## Now , let us compute the accuracy of our model by creating a confusion matrix .
table( Test$letter , Predictions3 )

## Now , let us create a Random Forest Model for the same .

library(randomForest)
set.seed(1000)

CartModel4 = randomForest( letters ~ . - isB , data = Train )
Predictions2 = predict( CartModel4 , newdata = Test )

## Now , let us check the accuracy of our model by creating a confusion matrix .
table( Test$isB , Predictions4 )

## -----------------------------------------------------------------------------------------------------------------------------