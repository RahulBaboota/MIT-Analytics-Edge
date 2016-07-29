## Solutions for Homework 3

###									Setting up the file and variable names

# Firstly , we will read in the loans.csv file
Baseball = read.csv('baseball.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Counting the number of teams in the dataset . Since each row represented a different team , we can just simply count the 
## number of rows .

nrow(Baseball)

## We can find the number of years who's data is present is present in this dataframe by making a table and then counting the 
## years in that table .

length(table(Baseball$Year))

## Since we are only concerned with teams that made the playoffs , we'll reduce our dataset by including only those teams that
## made the playoffs .

Baseball = subset( Baseball , Playoffs == 1 )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## It is much harder to win the world series if there are more teams to compete with . Therefore , this should be an important 
## factor while making our model .

## We store this tabular information in a variable. 

PlayoffTable = table(Baseball$Year)

## We then add this newly created variable to our dataset .

Baseball$NumCompetitors = PlayoffTable[as.character(Baseball$Year)]

## -----------------------------------------------------------------------------------------------------------------------------
