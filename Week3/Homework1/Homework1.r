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

CARTModel3 = rpart( voting ~ civicduty + hawthorne + self + neighbors + sex, data = Gerber , cp =0.0 )
prp(CARTModel3)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## Now , let us create another Regression Model using just the "control" variable and "control" and "sex" variable .

CARTModel4 = rpart( voting ~ control , data = Gerber , cp = 0.0 )
prp(CARTModel4)

CARTModel5 = rpart( voting ~ control + sex , data = Gerber , cp = 0.0 )
prp(CARTModel5)

## Now , let us a create a logistic regression model using these independent variables only .

LogisticModel1 = glm( voting ~ control + sex , data = Gerber , family = "binomial" )
summary(LogisticModel1)

## We saw that our Regression Tree was able to provide us with the probablities of all cases which were (Man, Not Control),
## (Man, Control), (Woman, Not Control), (Woman, Control) . However , our logistic regression model is not able to do that .
## Therefore , we create a new dataframe which contains all the possible values of "control" and "sex" and apply the predict 
## function on this dataframe .

Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(LogisticModel1, newdata=Possibilities, type="response")

## We now add another variable in our logistic regression model that is the combination of the "sex" and "control" variables - 
## so if this new variable is 1, that means the person is a woman AND in the control group.

LogisticModel2 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(LogisticModel2)

Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(LogisticModel2, newdata=Possibilities, type="response")


## -----------------------------------------------------------------------------------------------------------------------------
