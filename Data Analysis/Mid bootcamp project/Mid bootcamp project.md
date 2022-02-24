![Ironhack](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Ironhack.jpg)  
# Mid bootcamp project  

-------

# Case Study: Regression/ Predicting the price of houses :moneybag: :euro: :house:
by [Marc Puyol](https://github.com/MpiPuin12/Marc-Puyol-Iniesta) &  [Sergi Guasch](https://github.com/SergiGuasch/sergiguasch), February 2022
<br/><br/>
 - **Code:** Jupyter Notebook - [Link to code folder](https://github.com/SergiGuasch/hangover/blob/main/Mid-project.ipynb) 
 - **Tableau:** Tableau Link - [Link to Tableau file](https://public.tableau.com/app/profile/sergi4264/viz/Hangover_16448685754500/Dashboard1)
 - **SQL:** MySQL file - [Link to MySQL file](https://github.com/SergiGuasch/hangover/blob/main/SQL_hangover.sql)

## 1 Importing and understanding the data
The database is composed of 21,597 rows (each representing a house in the King County in Washington state) and 21 columns. Additionally, we have added two new columns, one that reflects the year in which the house was built or reformed and one that reflects the distance from the center (the most expensive area).

![Data_distribution](https://github.com/SergiGuasch/hangover/blob/main/images/1_Data_distribution.jpg)  
*Fig 1. Data distribution in King County by zipcode*

## 2 Data Cleaning & Standarization
### 2.1. Checking Null values
Our first step was to try to find the null values. The dataset doesn't have any null values so we don't have to deal with them. However, it is important to think about the reason why these nulls do not exist, since this can introduce some kind of bias in the data. We have to observe if data may have been duplicated to avoid nulls, if random values have been incorporated...

### 2.1. Checking for duplicated Values
Our approach to finding duplicates values was first of all checking the reason why a same id was repeated. Due to the fact that we only had data from 2014 and 2015, probably the only reason why a house may be repeated it's because it was sold two times in this period and, therefore, two different prices (but the independent variables remained the same.) That's why we decided to only keep the last date transaction info since it's the one that recaps better the actual price of that house.

![Duplicates](https://github.com/SergiGuasch/hangover/blob/main/images/2_duplicates.jpg)  
*Fig 2. Rows duplicates by Id*

## 3  Pre-processing 
### 3.1  Checking data types
We first thought of converting the bathrooms to an integer but since it can also take decimals values we decided to leave it as a float. However, we did convert floors into an integer.

### 3.2  Checking data shapes
We first plot all the graphs to try to detect clear outliers. At first sight, most of the numerical columns(sqft_living, sqft_living15, sqft_lot, sqft_lot15, sqft_above, sqft_basement) seem to have some outliers. For the sqft_living variables, since it behaves as a kind of normal distribution, we decided to drop the outliers that were outside the range of 3 standard deviations. For the sqft_lot, we drop all the values that were greater than 8-hundred thousand. For both variables we tried to make a log transformation to avoid the skewness of the model but it didn't contribute to the success of the model. We also see a clear correlation between sqft_living and sqft_above so we may only include one of the two in the model.  Regarding the categorical variables such as bedrooms, we'll deal with non-sense outliers such as 33 and 11 bedrooms(not consistent with the rest of the attributes of the house). For the 33 bedrooms house, we'll treat it as a typo and interpret it as 3.

![Scatterplots](https://github.com/SergiGuasch/hangover/blob/main/images/3_scatterplots.jpg)  
*Fig 3. Scatterplots of numerical variables*

### 3.3  Check useless columns
For checking which columns should we add to our model, we run both the correlation matrix and the scatter_matrix so that we could check for multicollinearity, which were the variables more related to the price... After observing the scatter_matrix, and observing that the sqft_living behaved as a kind of normal distribution we decided to deal with it's outliers by droping the values away from it's mean and 3 std. deviations. For the numeric variables, we introduce to the model sqft_living and sqft_basement. The reason for the first (sqft_living) is that is the variable more correlated with the target and it's very correlated with another numeric variable (sqft_above) that we drop to avoid multicollinearity. Regarding sqft_basement, is not as correlated to sqft_living so we'll live it in the model.

![Heatmap](https://github.com/SergiGuasch/hangover/blob/main/images/4_Heatmap.jpg)  
*Fig 4. Heatmap of numerical variables*

### 3.4 Dealing with the categorical variables
As we commented before, we added a categorical variable (Decade build) that shows whether the date it was built or the date it was renovated. We afterwards group them by decades. Another step, it was dummifying all our categorical variables. This was one of the main limitations of the model. When dummifying the zipcode, we created a lot of little subsamples that may not have many observations and therefore drive us to error. This problem gets bigger when we drop some outliers that may reduce even more the size of our subsamples.

## 4  Testing the model

### 4.1  Train test split
Once all the engineering and the pre-processing is finished we, as usual, run and test our model.

### 4.2  Linear regression model
The first model we tried was the linear regression model. We obtained an R2 of 0.8139.

### 4.3 Trying feature selection to simplify our model
As we have already mentioned, the problem with our model was that it had too many variables. That is why, in order to try to reduce this problem, we have tried some kind of feature selection model that allows us to drop the variables that contribute the least to the model. By doing this, we may save some time and computing cost. If from the 95 original variables we shrink to 45(the most important for the model) we only lose 0.1 od the R2 score. The code used was the following.

![Code](https://github.com/SergiGuasch/hangover/blob/main/images/5_code.jpg)  
*Fig 5. Feature selection code*

### 4.4 Testing other models
In order to try to improve the performance of our model, we have tried to use other models that could be better adjusted to the characteristics of the database we were working with. The models we tried were ('RandomForestRegressor', 'KNeighborsRegressor','GradientBoostingRegressor', 'linear_model', 'tree_Regressor'). After testing these models, both the RandomForestRegressor and GradientBoostingRegressor, are slightly better than the LinearRegressionModel.

![Other_models](https://github.com/SergiGuasch/hangover/blob/main/images/6_other_models.jpg)  
*Fig 6. Testing other models*

## 5 Scaling numerical variables
Another of the attempts to improve our model has been to scale the numerical data. For it, we used the maxmin_scaler, the st_scaler and the rob_scaler. However, we can't appreciaate a remarkable difference.
 
 
## 6  MODEL 2 - Setting distance to center as dummie and not dummyfiyng all the zipcodes
In our second model, we tried to think a way of improving the score we obtained on our previous models. As we commented before, one of the main issues in our previous model was dealing with some many subsamples due to the dummification of the zipcode variables. We therefore, tried to reduce the number of subsamples by some kind of aggrupation that had more observations for each subsample. That's why we decided to divide the zipcodes in 5 groups depending how far away were they from the most expensive area (best place to live). It appeared to be a clear pattern that the distance to this point would mean less value of the house (less services, more distance to business area...). That's why we created the distance_to_center column. For the rest of the model, we just follow the same steps as before. However, probably due to the fact that our election of zipcodes group were arbitrary, we didn't manage to find a better performing model.
 
![Model2](https://github.com/SergiGuasch/hangover/blob/main/images/7_model2.jpg)  
*Fig 7. Results of model 2*
 
 ## 7 Limitations of our model: 
 
 The main limitation of our model, as we have been introducing throughout the paper is the excess of variables we had. This harms the model in many different ways. Some are:

- Computational cost and time to run the model (in huge databases it would be unfeasible)
- Since we create so many subsamples within our own sample, we have not very large subsamples, which also limits our ability to deal with outliers and irrelevant data. 

  




