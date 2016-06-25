## Solutions for Homework 2

###									Setting up the file and variable names

## Loading the training and testing files in the R programme 
pisaTrain = read.csv('pisa2009train.csv')
pisaTest = read.csv('pisa2009test.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1 


## To find the number of students in our training set , we can do 2 things . We can either look at the structure of our dataframe which provides us with the no. of unique observations or we can count the number of observations using the nrow() function.

str(pisaTrain)
nrow(pisaTrain)

## Now we have to find the average reading scores of males and females . We can do this problem also by two approaches . The first approach is to create subset dataframes in which one of them contains only observations of males and the other one contains observations of only females . Then we can apply the mean() function to the Reading Scores . 

pisaTrain_males = subset( pisaTrain , male == 1)
pisaTrain_females = subset( pisaTrain , male == 0)

mean_readingscore_males = mean(pisaTrain_males$readingScore)
mean_readingscore_females = mean(pisaTrain$readingScore)

## Now , since we have to classify the results according to some criterion in the above mentioned problem , we can also use the tapply() function . In this function , we can provide 3 arguments . tapply( arg 1 , arg 2 , arg 3) . The first argument refers to the result we want to calculate . The second refers to the classifier according to which we want to calculate the results . And the third argument is the result we want to calculate .

mean_readingscore_gender = tapply( pisaTrain$readingScore , pisaTrain$male , mean)

## In R , the missing values are labelled as "NA" . To find wether there is missing data present in any of the observations , we can again do 2 things . We can either apply a brute force method of checking our results for each variable or we can simply look at the summary of our dataframe which counts the number of "NA's" and displays the result .

sum(is.na(pisaTrain$grade))
sum(is.na(pisaTrain$male))
sum(is.na(pisaTrain$raceeth))
sum(is.na(pisaTrain$preschool))
sum(is.na(pisaTrain$expectBachelors))
sum(is.na(pisaTrain$motherHS))
sum(is.na(pisaTrain$motherBachelors))
sum(is.na(pisaTrain$motherWork))
sum(is.na(pisaTrain$fatherHS))
sum(is.na(pisaTrain$fatherBachelors))
sum(is.na(pisaTrain$fatherWork))
sum(is.na(pisaTrain$selfBornUS))
sum(is.na(pisaTrain$motherBornUS))
sum(is.na(pisaTrain$fatherBornUS))
sum(is.na(pisaTrain$englishAtHome))
sum(is.na(pisaTrain$computerForSchoolwork))
sum(is.na(pisaTrain$read30MinsADay))
sum(is.na(pisaTrain$minutesPerWeekEnglish))
sum(is.na(pisaTrain$studentsInEnglish))
sum(is.na(pisaTrain$schoolHasLibrary))
sum(is.na(pisaTrain$publicSchool))
sum(is.na(pisaTrain$urban))
sum(is.na(pisaTrain$schoolSize))
sum(is.na(pisaTrain$readingScore))

summary(pisaTrain)

## Linear Regression discards the data with missing values . Therefore , we will also remove that data which contains missing values . For doing this , we will use the omit() function .

pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)

## ------------------------------------------------------------------------------------------------------------------------------

## Problem 2

## In 2.1 , we have to find the various variables which are factor variables with some kind of order or not . For this , there is no need to perform any kind of function in R , but just by looking at the dataframe , we can tell that "race" is an unordered factor variable as it has many levels such as "Hispanic , White, Black " etc. , however they dont have any order . Whereas on the other side, grade is an ordered factor variable as it also has many levels such as 8,9,10, .. wherein they are of a particular order .

## To include unordered variables in our linear regression model , we select one of the unordered levels as a reference level and then we assign binary values to each of the different unordered levels . The reference level is mostly that level which is the most frequently occuring . So , in our example , in the independent variable , 'raceeth' , we choose "White" as our reference level and all other levels are then assigned binary values.

## ------------------------------------------------------------------------------------------------------------------------------

## Problem 3

## The "raceeth" variable takes on text values and therefore , it was loaded in as a factor variable in our dataframe . The problem which arises from this is that , R reads in the different levels then alphabetically and selects the reference variable also alphabetically . Therefore , we have to set the reference variable as "White" on our own.

pisaTrain$raceeth = relevel( pisaTrain$raceeth , "White" )
pisaTest$raceeth = relevel( pisaTrain$raceeth , "White" )


## After doing this , we create a linear regression model wherein we factor for all of the variables. In this case , we will use the shorthand notation to select all the variables in our model .

lmScore = lm( readingScore ~ . , data = pisaTrain )
summary(lmScore)

## Computing the value of SSE and RMSE

SSE = sum((lmScore$residuals)^2)
RMSE = sqrt(SSE/nrow(pisaTrain))

## We can clearly see that there have been different coefficients generated for each level in our raceeth variable . The interpretaion of these coefficients are that this is the predicted difference in their reading score as compared to the reading score of the reference level , in this case , the "White" , assuming all other factors to be the same .


## -------------------------------------------------------------------------------------------------------------------------------

## Problem 4

## Up until now , we created a linear regression model and we trained it on some data which we call as the training data . However, this model will only be of use to us if it can predict values on unseen data or testing data . Therefore , we use this model to predict the reading scores on the testing data .

predTest = predict( lmScore , newdata = pisaTest )
summary(predTest)
predTest

## Computing the values of SSE and RMSE for the test set .

SSE = sum(( pisaTest$readingScore - predTest )^2)
RMSE = sqrt(SSE/nrow(pisaTest))

## Computing baseline predictions and SST .

baseline_prediction = mean(pisaTrain$readingScore)
SST = sum(( baseline_prediction - pisaTest$readingScore )^2)

## Computing the value of R^2

R2 = 1 - SSE/SST
