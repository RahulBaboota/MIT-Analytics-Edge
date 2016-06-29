## Solutions for Homework 3

###									Setting up the file and variable names

## In this R script , we can load the data in either of the 2 ways. The first way isthe conventional way of loading a dataframe 
## the read.csv() function .

statedata = read.csv('statedata.csv')

## The other method is to access the dataframe directly from the R bindings .

data(state)
statedata = cbind(data.frame(state.x77), state.abb, state.area, state.center,  state.division, state.name, state.region)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1 

## First off , we will create a plot between the x-coordinate and the y-coordinate of the centers of the states . When we look at 
## the plot , we will find that the shape resembles The United States of America .

plot( statedata$x , statedata$y )

## Now , we have to find the state regions where the average number of high school graduates is the highest . Since we want to 
## classify the results of some variable according to some other variable , we will use the tapply() function .

tapply( statedata$HS.Grad , statedata$state.region , mean )

## Next , we have to create a boxplot of the number of murders according to state regions . For this , we will use the boxplot()
## function in R .

boxplot( statedata$Murder , statedata$state.region )

## From the above boxplot , we can see that the median value is highest for south region . Also , we notice that there is an 
## outlier value in the Northeast region . To find which state that outlier belongs to we can study the subset of the dataframe
## which contains only the observations for the Northeast region.

northeast_region = subset( statedata , statedata$state.region == 'Northeast' )
max_murder_row_number = which.max( northeast_region$Murder )
max_murder_state = northeast_region$state.name[max_murder_row_number]
max_murder_state


## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2

## Now , lets build a linear regression model in which our dependent variable is "Life Expectancy" and other plausible variables
## are taken as the dependent variables .

LifeExpectModel = lm( LifeExp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data = statedata )
summary(LifeExpectModel)

## After that , we will construct a plot between the Income and the Life Expectancy to see what kind of relation they have .

plot ( statedata$Income , statedata$Life.Exp )

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## We know that it is not a wise decision to include all the independent variables in our model as it causes overfitting . Therefore 
## we remove the models that are not significant by looking at their t-value and their significant stars . By doing so , we
## obtain a model which has the following four independent variables .

LifeExpectModel2 = lm ( LifeExp ~ Population + Murder + HS.Grad + Frost, data = statedata )
summary(LifeExpectModel2)

## By looking at the summary , we get that the R^2 value almost remains the same , so this ensures that our model is a good one .
## It is to be noted that when we remove independent variables from our model , the value of our multiple R^2 decreases only .
## However , if the decrease is negligible or it remains the same , then it is a good tradeoff as we are not decreasing the 
## accuracy by a big margin while making the model much more simpler . On the other hand , we can expect the adjusted R^2 to 
## increase as it takes into account the number of variables used in our model as compared to the total number of variables 
## present .

## Now , we will make predictions using our model on the training set itself .

Predictions = predict( LifeExpectModel2 , data = statedata )
Predictions

## Next , we will check the correctness of our model by looking at what predictions our model made and what the actual values were .

min_life_exp_predict = sort( Predictions )
min_life_exp_actual = statedata$state.name[which.min(statedata$Life.Exp)]

max_life_exp_predict = sort( Predictions )
max_life_exp_actual = statedata$state.name[which.max(statedata$Life.Exp)]

## Next , we want to check that the value of the residuals ( errors ) i.e. the difference in the actual values and the predicted 
## values for each of the state . More importantly , we want the states for which the errors are maximum and minimum .

state_errors_min = statedata$state.name[which.min(LifeExpectModel2$residuals)]
state_errors_max = statedata$state.name[which.max(LifeExpectModel2$residuals)]

## -----------------------------------------------------------------------------------------------------------------------------
