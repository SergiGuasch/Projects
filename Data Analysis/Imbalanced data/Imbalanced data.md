![Ironhack](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Ironhack.jpg)  

# A beautiful Readme! 

## Imbalanced data

by [Sergi Alvarez Guasch](https://github.com/SergiGuasch/sergiguasch)  


 - **Code:** Jupyter Notebook - [Link to code folder](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Lab%20Imbalanced%20data.ipynb)

## Classification in order to predict the customer churn from a given dataframe.


### Metodology
1. *Load the dataset and explore the variables*    
2. *Select the variables tenure, SeniorCitizen, MonthlyCharges to predict the target variable Churn using a logistic regression*    
3. *Extract the target variable*   
4. *Extract the independent variables and scale*    
5. *Build the logistic regression model*    
6. *Evaluate the model*    
7. *Why in this dataset a simple model will give us more than 70% accuracy?*    
8. *Synthetic Minority Oversampling TEchnique (SMOTE)*    
9. *Tomek links*    


### 1. Load the dataset and explore the variables 
The first step it was to import the different libraries we are going to use to apply a logistic regression model. Then we can load to jupyter notebook as a dataframe with the next sintax: df=pd.read_csv('customer_churn.csv')  
 
That's the result once imported:  

![1](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/Load.jpg) 

Also, in this step it's the time to get more information about data with describe() and info() methods.

### 2. Select the variables tenure, SeniorCitizen, MonthlyCharges to predict the target variable Churn using a logistic regression
Here it has been used the .loc[] method to select the diferent variables required to analyse with the logistic regression model, so in that case it has been needed 'tenure','SeniorCitizen','MonthlyCharges' and the target variable 'Churn'.  
![2](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/Select.jpg)

### 3. Extract the target variable
Next it has used to determine the dependent target variable (y), using the next sintaxis: y=df['Churn']  
We can use this step also to explore the dependent variable with .value_counts(). The result is that we have 5174 No and 1869 Yes of customers churn. 

### 4. Extract the independent variables and scale  
Following the metodology, it has been extracted the different independent variables (x). For this purpose it has been used the next steps:  

- X=df.drop('Churn',axis=1) -- *here it's necessary to drop the dependent variable from the dataframe, in order to assign just the independent variables to x.*   
- X_num=X.select_dtypes(include=np.number) -- *here we use the columns from the df which are numerical and we asigned to the variable X_num.*  
- scaler= RobustScaler() -- *we asign the method to scale 'RobustScaler' to the variable scaler.*  
- scaler.fit(X_num) -- *the fit method permits using scaler to scale over the variable X_num.*  
- X_full= pd.DataFrame(scaler.transform(X_num),columns=X_num.columns) -- *finally we can asign to a new variable, the dataframe with the scaled variable X_num using the transform method.*  

### 5. Build the logistic regression model  
To build the logistic model it has been used the next equation, the train test split:   

X_train,X_test,y_train,y_test=train_test_split(X_full,y,test_size=0.45,random_state=40)

X_full and y are the independent and dependent variables respectively, which are the variable obtained in the last steps. Also, in the equation it has been assigned a random_state of 40 and a test_size of =.45, which are the standard values used to do the logistic regression model. Also it is important to bear in mind that in a logistic regression the dependent variable y it is not necessary to encode it as a number to use it for train-test.

### 6. Evaluate the model  
To evaluate the model, first of all we are going to check the accuracy score of the result of the train test split. SO the mtodology to get this accuracy value is shown here:  

- classification= LogisticRegression(max_iter=500) -- *here we use the LogisticRegression method/model which is going to iterate multiple times, and we assign the result to the classification variable*   
- classification.fit(X_train,y_train) -- *now the variable is fitted in the X_train,y_train variables that have been got it during the train test split.*
- y_test_pred=classification.predict(X_test) -- *the next step is use through the predict() method applied to the independent variable text X_test (which it has been got it during the train test split). The result is going to be the predicted y_test*
- accuracy_score(y_test,y_test_pred) -- *finally using the accuracy_score() between the y_test obtained during the train test split equation, and the y_test predicted before, we can get an score number.*  

Another step to visualize the model is using a confusion matrix. This matrix is useful in order to get a better idea if the classification model is getting right and what types of errors it is making.    
To get the confusion matrix its necessary to follow the next steps: 

- from sklearn.metrics import confusion_matrix, plot_confusion_matrix -- *here its the code to import the confusion matrix algorithms from the sklearn.metrics library.*
- confusion_matrix(y_test,y_test_pred) -- *the confusion matrix method is applied to the the y_test obtained during the train test split equation, and the y_test predicted in the last steps about the classification. So we are using the same variables than in accuracy_score method*
- plot_confusion_matrix(classification,X_test, y_test) -- *to visualize matrix is plotted thanks to plot_confusion_matrix method, which it requires the same variables than before, as well as the variable of the classification.*  

![3](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/Confusion_Matrix.jpg)  

Also, to get more information about the model applied, it's possible to use a heatmap of the same confusion_matrix from before. So, to get this heatmap we follow the next sintax:  

- cmx=confusion_matrix(y_test,y_test_pred) --*here we just assign the result of the confusion matrix method to a variable called cmx*
- sns.heatmap(cmx/np.sum(cmx), annot=True, fmt='.2%', cmap='Blues'); --*here using the seaborn library, it permits to visualize a heatmap, with the heatmap method. Also we can define some parameters in order to visualize better the heatmap, as well as we can show the values in percentatge.*  

![4](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/Heatmap.jpg)  

Finally, we try to obtain the Receiver Operating Characteristic (ROC) Curve in order to know how good is the model implemented. If the line is closer to the perfection (90 degrees, in the axis of the plot), then means that the model is good.   
Here are the steps to visualize the ROC Curve:  

- from sklearn.metrics import roc_auc_score, roc_curve --*here its the code to import the ROC algorithms from the sklearn.metrics library.*  
- y_pred_probs=classification.predict_proba(X_test)[::,1] --*we assign to the y prediction the probability using predict_proba method which it gives you the probability for the target*  
- y_cat=pd.get_dummies(y, drop_first=True) --*to use the roc_curve in the next steps, here it is necessary to encode into numbers the target variable using the get_dummies method*  
- X_train,X_test,y_train,y_test=train_test_split(X_full,y_cat,test_size=0.45,random_state=40) --*and its also necessary to get the new y_test using the train test split equation again, but now with the y encoded*
- fpr,tpr, _ = roc_curve(y_test,y_pred_probs) --*Once we know the probability (two steps before), we can use it with the y_test and apply it into the roc_curve method* 
- auc=roc_auc_score(y_test,y_pred_probs) --*Also, we can obtain the score of the Area Under the Curve applying the roc_auc_score method*  
- plt.plot(fpr,tpr,label='roc mode, auc='+str(auc)) --*here the last results are plotted into a graph*  
- plt.legend(loc=4) --*add a legend*  
- plt.show(); --*shows the plot*  

![5](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/ROC_Curve.jpg)  

### Why in this dataset a simple model will give us more than 70% accuracy?  

Cause as we can see in the sample of the dataset, the target variable has just 1869 Churn, while the no Churn are 5174. That means that the model can predict most of the times no Churn, but taking into account just this, there's a lack of information, cause the target is to predict the churn cases. So the data accuracy by itself it is not enough.  

------  

Once the model it has been evaluated we can use some techniques of resampling data:

### Synthetic Minority Oversampling Technique (SMOTE)

SMOTE is an oversampling technique used for the imbalanced classification. In this scenario the results of the accuracy_score, confusion_matrix and the ROC Curve became worse than the results of evaluate the model without any resampling technique.

![6](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/6.jpg)  
![7](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/7.jpg)  
![8](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/8.jpg)  

### Tomek links  

Tomek links is an undersampling technique used for the imbalanced classification. This model identify pairs of nearest neighbors in a dataset that have different classes. In this scenario there is a minimal improvment about 0,1% compares with the Logistic Regression classification non resampled. 

![9](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/9.jpg)  
![10](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/10.jpg)  
![11](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Images/11.jpg)  
