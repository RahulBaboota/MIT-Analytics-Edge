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

## Problem 4

## We saw from the previous problems that there are two main factors which determine the risk and the reward of the loans , mainly ,
## "int.rate" and "not.fully.paid" . Now , let us assume that the lender loans a principle amount "c" to the borrower . The amount
## is compounded annually so if the borrower returns the money along with interest , the total money received by the lender will
## be c*exp(rt) where r is the rate of interest and t is the time period . In such a case , the profit netted by the lender will
## be ( c*exp(rt) - c ) . However , if the borrower fails to pay back the loan , then the lender goes in a loss equal to c or 
## he nets a profit of -c . Therefore , while lending the money , there is another factor which should be taken into consideration
## which is the profit that the lender will earn . 

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 5

## As we saw in Problem 4 that there is a need to add the profit in our dataset while building our model . Therefore , we 
## incorporate a variable "profit" in our dataset which does exactly that . However , we will compute the profit values on a 
## loan value equal to $1 which can be scaled for other numbers .

Test$profit = exp(Test$int.rate*3) - 1
Test$profit[Test$not.fully.paid == 1] = -1

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 6

## Now , we know what factors are important to look while devicing an investment strategy with the maximum returns . It is quite 
## clear that we would invest in those loans wherein the interest rate is high ( i.e high reward ) and the probabilty of the loan
## not being paid back is low ( i.e low risk ) . Therefore , we device a strategy in which we would only invest in those loans
## where the interest rate is at least 15% . To do this , we create a subset of our Test Data to include only those observations
## where the interest rate is greater than or equal to 15% .

highInterest = subset( Test , int.rate >= 0.15 )
summary(highInterest)

## Now that we have created a subset of the loans sorted according to interest rates , we will now further filter our datapool 
## according to the risks of the loan being paid or not . To do this , we find out the 100 topmost loans which have the lowest
## risk probabilities . To create this subset , we calculate the maximum risk probability we will include in our subset .

cutoff = sort(highInterest$predicted.risk, decreasing=FALSE)[100]

selectedLoans = subset( Test , predicted.risk <= cutoff )
summary(selectedLoans)

## -----------------------------------------------------------------------------------------------------------------------------
