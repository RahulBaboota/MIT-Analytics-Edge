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

