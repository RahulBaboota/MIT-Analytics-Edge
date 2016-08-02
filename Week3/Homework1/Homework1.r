## Solutions for Homework 1

###									Setting up the file input and including libraries

Gerber = read.csv('gerber.csv')
library(rpart)
library(rpart.plot)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## We will create a CART tree for voting using all of the data and the four independent variable classifiers we used before .
## It is to be noted that we will be creating a Regression Tree rather than a Classification Tree . We want to build a 
## Regression Tree because we want to see that wether there are different kinds of splits produced based on the probabilities
## of the people who vote . If we build a CART Tree , then we would only get two splits i.e. , where the probability of voting
## is greater than 50% or where it is less than 50% . 

CARTModel1 = rpart( voting ~ civicduty + hawthorne + self + neighbors, data = Gerber )
prp(CARTModel1)

## When we plot this Regression Tree , we see that there were no splits made . This means that none of the variables used were
## significant enough to have an effect on the model.

## To force the model to build a Tree, we provide it the "complexity parameter".

CARTModel2 = rpart( voting ~ civicduty + hawthorne + self + neighbors, data = Gerber , cp = 0.0 )
prp(CARTModel2)

## We can then study the Regression Tree to find out what proportion of people in each of the groups voted.

## We now create another Regression Tree , this time , including the "sex" variable in our observations.

CARTModel3 = rpart( voting ~ civicduty + hawthorne + self + neighbors + sex, data = Gerber )
prp(CARTModel3)

## -----------------------------------------------------------------------------------------------------------------------------
