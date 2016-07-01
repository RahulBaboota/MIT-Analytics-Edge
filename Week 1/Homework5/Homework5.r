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
