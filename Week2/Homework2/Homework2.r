## Solutions for Homework 2

###									Setting up the file and variable names

# Firstly , we will read in the paroles csv file
parole = read.csv('parole.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Initially , we just want to find out the number of observations in the dataset . For this , we can use either of the two methods .
str(parole)
nrow(parole)

## Next , we find out the number of parolees who violated their parole . For this , we use the table function .
table(parole$violator)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## The variables male, race, state, crime, and violator all are factor variables and all of them are unordered . However , out of 
## these , only state and crime have at least 3 levels .

## Since these variables are factor variables with 3 levels, we convert them into factor variables . 
parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## Now , we want to split the data into training and testing sets . 

set.seed(144)
library(caTools)
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)
