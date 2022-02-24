Create database if not exists house_price_regression;
use house_price_regression;

Create Table if not exists house_price_data
(id VARCHAR (20), 
date VARCHAR (20),
bedrooms int,
bathrooms int,
sqft_living int,
sqft_lot int,
floors int,
waterfront int,
view int,
cond int,
grade int,
sqft_above int,
sqft_basement int,
yr_built VARCHAR(20),
yr_renovated VARCHAR(20),
zipcode int,
latitud float,
longitud float,
sqft_living15 int,
sqft_lot15 int,
price int);

select * from house_price_data;

# Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
# Select all the data from the table to verify if the command worked. Limit your returned results to 10.

alter table house_price_data drop if exists column grade ; 

# Use sql query to find how many rows of data you have.

select count(*) from house_price_data;

# Now we will try to find the unique values in some of the categorical columns:

# What are the unique values in the column bedrooms?

select count(distinct(bedrooms)) as Number_bedrooms from house_price_data ;

# What are the unique values in the column bathrooms?

select count(distinct(bathrooms)) as Number_bathrooms from house_price_data ;

# What are the unique values in the column floors?

select count(distinct(floors)) as Number_floors from house_price_data ;

# What are the unique values in the column condition?

select count(distinct(cond)) as Number_conditions from house_price_data ;

# What are the unique values in the column grade?

select count(distinct(grade)) as Number_grades from house_price_data ;

# Arrange the data in a decreasing order by the price of the house. 
# Return only the IDs of the top 10 most expensive houses in your data.

select id from house_price_data order by price desc limit 10;

# What is the average price of all the properties in your data?

select avg(price) from house_price_data;

# In this exercise we will use simple group by to check the properties of some of the categorical variables in our data:
	# What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, 
	# bedrooms and Average of the prices. Use an alias to change the name of the second column.

select bedrooms, avg(price) as avg_group_price_bed from house_price_data group by bedrooms;

	# What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, 
    # bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.

select bedrooms, avg(sqft_living) as avg_group_sqft_living from house_price_data group by bedrooms;

	# What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only 
	# two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.

select waterfront, avg(price) as avg_group_price_wf from house_price_data group by waterfront;

	# Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the 
    # variables and then aggregating the results of the other column. Visually check if there is a positive correlation or 
    # negative correlation or no correlation between the variables.
    
select cond, avg(grade) from house_price_data group by cond order by cond; 
select avg(cond), grade from house_price_data group by grade order by grade;
# Visually, it seems there's no kind of correlation .

# One of the customers is only interested in the following houses:
	-- 	Number of bedrooms either 3 or 4
select id, bedrooms, price from house_price_data where bedrooms= 3 or bedrooms=4 order by bedrooms, price;

    
	-- 	Bathrooms more than 3
    
select id, bathrooms, price from house_price_data where bathrooms>3 order by bathrooms, price;    
    
    
	-- 	One Floor
    
select id, floors, price from house_price_data where floors>1 order by floors, price;    
    
    
	-- 	No waterfront
    
select id, waterfront, price from house_price_data where waterfront=0 order by waterfront, price;    
    
    
	-- 	Condition should be 3 at least
    
select id, cond, price from house_price_data where cond>=3 order by cond, price;    
    
	-- 	Grade should be 5 at least
    
select id, grade, price from house_price_data where grade>=5 order by grade, price;    
    
    
	-- 	Price less than 300000
    
select id,price, grade from house_price_data where price<300000 order by price, grade;    
    
    -- All together 
    
select id, price, grade, cond, waterfront, floors, bathrooms, bedrooms from house_price_data 
where (bedrooms= 3 or bedrooms=4) and 
bathrooms>3 and 
floors>1 and 
waterfront=0 and 
cond>=3 and 
grade>=5 and
price<300000;

# Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
# Write a query to show them the list of such properties. You might need to use a sub query for this problem.    

SELECT id, price, (SELECT AVG(price) AS avgPrice
    FROM house_price_data) as AVG_price
FROM house_price_data
WHERE (price/2)>
  (SELECT AVG(price) AS avgPrice
    FROM house_price_data
  );

# Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW view_double_price AS
SELECT id, price, (SELECT AVG(price) AS avgPrice
    FROM house_price_data) as AVG_price
FROM house_price_data
WHERE (price/2)>
  (SELECT AVG(price) AS avgPrice
    FROM house_price_data
  );
  
# Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of 
# the properties with three and four bedrooms?

select distinct (select avg(price) from house_price_data where bedrooms= 4) as avg_4, 
(select avg(price) from house_price_data where bedrooms= 3) as avg_3, 
(select avg(price) from house_price_data where bedrooms= 4)-(select avg(price) from house_price_data where bedrooms= 3) as avg_diff
from house_price_data;

# What are the different locations where properties are available in your database? (distinct zip codes)

select distinct zipcode from house_price_data;

# Show the list of all the properties that were renovated.

select id, yr_renovated, price from house_price_data where yr_renovated != 0 order by yr_renovated;

# Provide the details of the property that is the 11th most expensive property in your database.

-- select * from house_price_data order by price desc limit 11;

select * from ( select * from house_price_data order by price desc limit 11) as 11th_expensive order by price asc limit 1;












# SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go

-- SET GLOBAL local_infile = 1;





