library(tidyverse)
library(pROC)

train <- read.csv("train2.csv")
test <- read.csv("test2.csv")
test$Genre1 = factor(test$Genre1, levels(train$Genre1))

head(select(train, original_title, Genre1, rating))

#train a logistic regression
form = rating ~ Genre1
model = rxLogit(form, train)

#make some predictions and format them
prediction <- rxPredict(model, test) 
test_results <- cbind(test, prediction) %>% subset(select = -c(1,2,id, keywords))
roc_data <- select(test_results, Genre1, rating, rating_Pred)
roc_data

#plot ROC
roc_obj = roc(roc_data$rating, roc_data$rating_Pred)
roc_obj
plot(roc_obj)


#set up cost function
cost1 = 9

cost = cost1*(1-roc_obj$sensitivities)
threshold_cost_table = data.frame(sensitivity = roc_obj$sensitivities, specificity = roc_obj$specificities, cost)
threshold_cost_table[order(threshold_cost_table$cost),]
cost_line = threshold_cost_table[head(order(threshold_cost_table$cost), 1),]%>% select(sensitivity,specificity)
plot(roc_obj) 
points(cost_line$specificity, cost_line$sensitivity, col = "red", pch = 19)


#This model is way to generous - let's add some pickiness
cost1 = 9
cost2 = 10
cost = cost1*(1-roc_obj$sensitivities) + cost2*(1-roc_obj$specificities)
threshold_cost_table = data.frame(sensitivity = roc_obj$sensitivities, specificity = roc_obj$specificities, cost)
threshold_cost_table[order(threshold_cost_table$cost),]
cost_line = threshold_cost_table[head(order(threshold_cost_table$cost), 1),]%>% select(sensitivity,specificity)
plot(roc_obj) 
points(cost_line$specificity, cost_line$sensitivity, col = "red", pch = 19)


#And if you wanted your model to be even more picky
cost1 = 4
cost2 = 9+6+2
cost = cost1*(1-roc_obj$sensitivities) + cost2*(1-roc_obj$specificities)
threshold_cost_table = data.frame(sensitivity = roc_obj$sensitivities, specificity = roc_obj$specificities, cost)
threshold_cost_table[order(threshold_cost_table$cost),]
cost_line = threshold_cost_table[head(order(threshold_cost_table$cost), 1),]%>% select(sensitivity,specificity)
plot(roc_obj) 
points(cost_line$specificity, cost_line$sensitivity, col = "red", pch = 19)
