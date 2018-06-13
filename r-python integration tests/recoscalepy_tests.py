import revoscalepy as rp;
import numpy as np;
import pandas as pd;
import sklearn as sk;



titanic_data = pd.read_csv('data/titanic.csv')

titanic_data.head()

#change all string columns to categorical
titanic_data_object_types = titanic_data.select_dtypes(include = ['object'])
titanic_data_object_types_columns = np.array(titanic_data_object_types.columns)
for column in titanic_data_object_types_columns:
    titanic_data[column] = titanic_data[column].astype('category', ordered = False)
titanic_data['Pclass'] = titanic_data['Pclass'].astype('category', ordered = False)

#rx_dtree works with formulas, just like rxDTree in R
form = 'Survived ~ Pclass + Sex + Age  + Parch  + Fare + Embarked'


#train decision tree and extract the tree's information
titanic_data_tree = rp.rx_dtree(form, titanic_data, max_depth = 50)

#test data
test = pd.read_csv('data/test.csv')
test_data_object_types = test.select_dtypes(include=['object'])
test_data_object_types_columns = np.array(test_data_object_types.columns)
for column in test_data_object_types_columns:
    test[column] = test[column].astype('category', ordered = False)

#predict on test data
titanic_data_predictions = rp.rx_predict_rx_dtree(titanic_data_tree, test)


