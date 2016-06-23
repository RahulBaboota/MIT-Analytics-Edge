## Solutions for Homework 1

#Firstly , we will read in the climate_change csv file
climate_change = read.csv('climate_change')

#Now , we will seperate this data into training and testing data

#Training data is classified as the data for the year upto and including 2006
climate_change_training = subset( climate_change , Year <= 2006)

#The rest of the data is classified as testing data
climate_change_testing  = subset( climate_change , Year > 2006 )

#Firstly , we create a linear regression model considering all independent variables excluding Year and Month 
TempRegModel1 = lm(Temp ~ MEI + CO2 + CH4 + N20 + CFC.11 + CFC.12 + TSI + Aerosols , data = climate_change_training)
summary(TempRegModel1)

#Now to check the correlation among different independent variables , we can use the cor function.
#The study of correlation will help us to explain some of the anamolous behaviours in our predictions
cor(climate_change_training)



