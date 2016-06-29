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



