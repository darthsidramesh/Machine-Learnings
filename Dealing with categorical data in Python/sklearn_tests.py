import sklearn as sk;
from sklearn import tree


titanic_data = pd.read_csv('data/titanic.csv')
#Preprocessing
#sklearn requires some serious preprocessing for categorical data!

le = sk.preprocessing.LabelEncoder()
x = titanic_data.select_dtypes(include=[object])
x = x.drop(['Name', 'Ticket', 'Cabin'], 1)
x = pd.concat([x, titanic_data['Pclass']], axis = 1)
x['Pclass'] = x['Pclass'].astype('object')
x = pd.DataFrame(x)
x = x.fillna('Missing')
x_cats = x.apply(le.fit_transform)
enc = sk.preprocessing.OneHotEncoder()
enc.fit(x_cats)
onehotlabels = enc.transform(x_cats).toarray()
encoded_titanic_data =  
  pd.concat([pd.DataFrame(titanic_data.select_dtypes(include=[np.number])), 
  pd.DataFrame(onehotlabels)], axis = 1)
  
  
#Training
model = tree.DecisionTreeClassifier(max_depth = 50) 
x = encoded_titanic_data.drop(['Survived'], 1)
x = x.fillna(-1)
y = encoded_titanic_data['Survived']
model = model.fit(x,y)