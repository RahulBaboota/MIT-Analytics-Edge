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

## Problem 3

## If a team won the World Series , then it is denoted by a value 1 in the PlayoffRank . We create a variable which stores this 
## result as a binary result , i.e , 1 if the team won and 0 if it didn't .

baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
table(Baseball$WorldSeries)

## When we are not sure which of the variables will be significant , what we do is that we build bivariate models which help us
## to determine which of the variables are significant or not .

Model1 = glm( WorldSeries ~ Year , data = Baseball , family = "binomial" )

Model2 = glm( WorldSeries ~ RS , data = Baseball , family = "binomial" )

Model3 = glm( WorldSeries ~ RA , data = Baseball , family = "binomial" )

Model4 = glm( WorldSeries ~ W , data = Baseball , family = "binomial" )

Model5 = glm( WorldSeries ~ OBP , data = Baseball , family = "binomial" )

Model6 = glm( WorldSeries ~ SLG , data = Baseball , family = "binomial" )

Model7 = glm( WorldSeries ~ BA , data = Baseball , family = "binomial" )

Model8 = glm( WorldSeries ~ Playoffs , data = Baseball , family = "binomial" )

Model9 = glm( WorldSeries ~ RankSeason , data = Baseball , family = "binomial" )

Model10 = glm( WorldSeries ~ RankPlayoffs , data = Baseball , family = "binomial" )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 4

## Now , we will build a final model in which we will include all of the variables which we found to be significant using our 
## bivariate model analysis .

ModelFinal = glm( WorldSeries ~ Year + RA + RankSeason + NumCompetitors , data = Baseball , family = "binomial" )
summary(ModelFinal)

## On looking at the summary of the model created above , we see that any of the variables listed wasn't a significant variable .
## This generally happens due to correlation between the variables .


## -----------------------------------------------------------------------------------------------------------------------------
