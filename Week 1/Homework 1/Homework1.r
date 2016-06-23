## Solutions for Homework 1

###									Setting up the file and variable names

#Firstly , we will read in the climate_change csv file
climate_change = read.csv('climate_change')

#Now , we will seperate this data into training and testing data

#Training data is classified as the data for the year upto and including 2006
climate_change_training = subset( climate_change , Year <= 2006)

#The rest of the data is classified as testing data
climate_change_testing  = subset( climate_change , Year > 2006 )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1 

#Firstly , we create a linear regression model considering all independent variables excluding Year and Month 
TempRegModel1 = lm( Temp ~ MEI + CO2 + CH4 + N20 + CFC.11 + CFC.12 + TSI + Aerosols , data = climate_change_training)
summary(TempRegModel1)

## ------------------------------------------------------------------------------------------------------------------------------

## Problem 2

#Now to check the correlation among different independent variables , we can use the cor function.
#The study of correlation will help us to explain some of the anamolous behaviours in our predictions
cor(climate_change_training)

## ------------------------------------------------------------------------------------------------------------------------------

## Problem 3

#Since we saw that our TempRegModel1 was producing some weird predictions such as increasing concentration of greenhouse gases were leading to a drop in temperature , we try to reduce some variables and make our model better . 
TempRegModel2 = lm( Temp ~ MEI + TSI + N2O + Aerosols , data = climate_change_training)
summary(TempRegModel2)

## -------------------------------------------------------------------------------------------------------------------------------

## Problem 4

#In this problem we have many variables and in the solution to the above problem , we saw that we can create a better model by droppping some variables which dont affect the precision of the model and also is a bit simpler . However , to do this , we have to carefully look at what variables we can drop without affecting the accuracy of the model by a big margin . To automate this process , we have a function in R which basically automates the process of trying out different combinations of variables and selects a model which has a good tradeoff between model simplicity and the R^2 value . In step function , the argument that we provide to it should be that model which contains the most basic case i.e assumes all independent variables in the model .
TempRegModel3 = step(TempRegModel1)
summary(TempRegModel3)

## --------------------------------------------------------------------------------------------------------------------------------






