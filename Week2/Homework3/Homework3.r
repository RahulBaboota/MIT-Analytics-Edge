## Solutions for Homework 3

###									Setting up the file and variable names

# Firstly , we will read in the loans.csv file
loans = read.csv('loans.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## In this problem , our dependent variable is not.fully.paid and it takes a value 1 if it is not fully paid . So to check the 
## proportion of the loans that were not fully paid , we can create a table to find the number of cases in which the loan was 
## fully paid or not .

table(loans.csv$not.fully.paid)

## Next , we have to check for those observations for which the data contains some missing values . We can do this by looking at the
## summary of the dataset .

summary(loans)

## We see that there are some observations for which there are missing values . So , we have to fill in these missing values. 
## It is not a good practice to just delete the missing values because that would lead to loss of data and what we want to do with
## our models is to predict the loans for all of the observations and not only for those which have the proper filled in data .

## Reading in the file with imputed values for cross-checking results .
loans_imputed = read.csv('loans_imputed.csv')

## Now , we fill in the missing values using R's package "MICE".

library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loans), "not.fully.paid")
imputed = complete(mice(loans[vars.for.imputation]))
loans[vars.for.imputation] = imputed

## Notice that in the variable defined as variables for imputation "vars.for.imputation" ,  we have included all of the variables 
## except for not.fully.paid because we want to impute the values of the missing independent variables using the previous independent
## variables and the the dependent variables . What we have done above is basically , we have tried to predict the values of the 
## missing observations using the available values of the independent variables for that particular observation .

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 2 

## Now , we will split our dataset into training and testing data using R's package "caTools" . After that , we will create a 
## logistic regression model in which we will train our model on the training data . To create our model , we will use all of 
## the available independent variables .

library(caTools)
set.seed(144)
spl = sample.split( loans , SplitRatio = 0.7 )
Train = subset( loans , spl == TRUE )
Test = subset( loans , spl == FALSE )
Model1 = glm( not.fully.paid ~ . , data = Train , family = binomial ) 
summary(Model1)

## Next , we test our predictions on the testing set and compare the accuracy of our created model with the baseline model .

## To test for our model , we set the threshhold value at 0.5 

Test$predicted.risk = predict( Model1 , newdata = Test , type = "response" )
table( Test$not.fully.paid , Test$predicted.risk > 0.5 )

## Our baseline model will predict the most frequent output for all of the observations which is "0" . Therefore , we can 
## compute the accuracy of our baseline model too by looking at the confusion matrix .

## Next , we compute the AUC of the model by using the ROCR package .

library(ROCR)
set.seed(144)
Pred = prediction( Test$predicted.risk , Test$not.fully.paid )
as.numeric(performance(pred, "auc")@y.values)

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 3

## In our dataset , we have an independent variable interest rate which is given as "int.rate" . This value is decided depending on 
## the probability of wether the loan will be paid back or not . If the risk of not paying back the loan is high , the interest 
## rate is also increased and vice - versa .

## Let us now create a bivariate logistic regression model ( a model with only 1 independent variable ) in which our independent
## variable will be "int.rate" . 

Model2 = glm( not.fully.paid ~ int.rate , family = binomial , data = Train )
summary(Model2)

## By looking at the summary of the model created above , we can see that now int.rate is a significant variable whereas in the model
## that we created initially in which we used all of the variables ,  int.rate was not significant . This mostly happens due to
## a strong correlation between the independent variables and on further investigating , we can see that int.rate and fico are
## somewhat highly correlated .

cor( Train$int.rate , Train$fico )

## Next , we try to create a smarter baseline model using the model that we just created above . 

PredTest2 = predict( Model2 , newdata = Test , type = "response" )
summary(PredTest2)

## Looking at the summary of the model , we can clearly see that the maximum probability that the model returns on the testing set
## is less than 0.5 , which means that if we take the threshold to be 0.5 , the model would predict that all of the loans would
## be paid .

## Next , let us calculate the AUC of this model .

Pred2 = prediction( PredTets2 , Test$not.fully.paid )
as.numeric(performance(pred , "auc")@y.values)

## -----------------------------------------------------------------------------------------------------------------------------



