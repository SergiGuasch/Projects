![Ironhack](https://github.com/SergiGuasch/sergiguasch/blob/main/labs/week4/Lab2/Ironhack.jpg)  
# Final project  

-------

# Webscraping and Sentiment Analysis from reviews of Barcelona restaurants from TripAdvisor 🍽️ ⭐ 🦉  
by [Sergi Alvarez Guasch](https://github.com/SergiGuasch) March 2022  
<br/><br/>
 - **Code:** Jupyter Notebook1 - [Link to code folder](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Restaurants.ipynb)
 - **Code:** Jupyter Notebook2 - [Link to code folder](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Full_Reviews.ipynb) 
 - **Tableau:** Tableau Link1 - [Link to Tableau file](https://public.tableau.com/app/profile/sergi4264/viz/TripAdvisor_Restaurants/Heatmap)
 - **Tableau:** Tableau Link2 - [Link to Tableau file](https://public.tableau.com/app/profile/sergi4264/viz/TripAdvisor_Reviews/Words)
 - **Presentation:** Powerpoint - [Link to ppt folder](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/TripAdvisor.pptx)

## Table of contents  

- [Introduction](#Introduction)
- [Scraping TripAdvisor](#Scraping)
- [Data Cleaning](#Data-cleaning)
- [Geocoding](#Geocoding)
- [Mapping](#Mapping)  
- [Scraping Cervecería Catalana](#scraping-cerveceria-catalana)
- [Dealing webscrape](#dealing-webscrape)
- [Cleaning reviews](#cleaning-reviews)
- [Sentiment Analysis](#sentiment-analysis)
- [Lexical analysis](#lexical-analysis)  
- [Conclusions](#Conclusions)  
 
## Introduction (Purpose)  <a name="Introduction"/> 

The purpose of the project is to get the data from the website TripAdvisor, to analyze the number of restaurants that are in Barcelona as well as to get the reviews of the restaurant most reviewed/visited by the TripAdvisor users in Barcelona city. Also, we want to analyze the reviews from this restaurant in order to know the overall trend of its customers/TripAdvors users.  

## Scraping the data from the TripAdvisor website  <a name="Scraping"/>

The first step is to get the data from the next website:  [Link to the TripAdvisor website ](https://www.tripadvisor.es/Search?q=Barcelona&searchSessionId=51C8E5CE54DA772C3953CD9DA7D126D31646914148673ssid&searchNearby=false&sid=6CE36F5C961D4332A3DC16D3040AA0ED1646914152244&blockRedirect=true&ssrc=e&rf=43)  

We need to get the information most relevant for the future analysis and visualizations/maps. In this sense, we get the information from the title of the restaurant, the rating of the restaurant, the number of reviews and finally we can get also the address. The results it will be a dataframe of four columns with this information.

![Dataframe](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/restaurants.jpg)  
*Fig 1. Dataframe obtained from the scrape*

## Data Cleaning: Standarization & Checking Null values  <a name="Data-cleaning"/>


Before the technical cleaning we could drop some restaurants bearing in mind their names, cause we have found some restaurants that they have the word Barcelona in their names but not in the address. 

Next, we need to prepare the dataframe to be able to geocode the addresses with the geopy module. Doing the webscraping there aren't null values, but we have to standarize some names in the address, make it lower case and delete some special characters.  

## Geocoding  
<a name="#Geocoding"/> 

Once we have the dataframe we can run the code with the geopy module to get the longitud and latitud variables. Also we can get a column locator to check if the location got it from geopy algorithm is the same than the location from the address scraped. The dataframe resulting from the geocoding it gave us some null values but also some wrong addresses. To deal with this we could transform manually the null addresses to longitud latitud, but we decided to drop it. 

![Geocoding](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/Geocoding.jpg)  
*Fig 2. DataFrame with the location column as result from geocode*

## Mapping  
<a name="#Mapping"/>  

To visualize the maps properly, we need to deal with some restaurants that they are in Barcelona province, but the geopy module has not been able to locate it in Barcelona city. To deal with this we can use some GIS tools (as spatial join) in order to select just the restaurants are inside the limits of Barcelona city, and aggregate in the polygon shape the attributes of our dataframe geocoded.

The shapefile used is a neighborhood administrative boundary from the next website:  [Link to the source ](https://github.com/martgnz/bcn-geodata/blob/master/barris/barris.geojson)  

Then we can get the maps of the number of restaurants by neighborhood, or the maps of the mean rating restaurants by neighboordhood.
These two maps have been built in QGIS.

Next step is to built a density map with Tableau, from the csv file that has been filtered before with the spatial join.

![Density](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/Density.jpg)  
*Fig 3. Density map*

## Scraping Cervecería Catalana  <a name="scraping-cerveceria-catalana"/>   

The next part of the project is focus on the restaurant with most reviews in Barcelona. So, from this one we have also scrapped all its reviews bearing in mind the description of the review, the date of the review and the rating acording to the reviews of the users of TripAdvisor. 

The restaurant in particular is Cervecería Catalana, and the website of its reviews are in the next url: [Link to the Cervecería Catalana in TripAdvisor website ](https://www.tripadvisor.es/Restaurant_Review-g187497-d782944-Reviews-Cerveceria_Catalana-Barcelona_Catalonia.html)

## Dealing with the webscrape  <a name="dealing-webscrape"/>   

To get the dataframe with the information requested it has been necessary to scrape the first page of the review separately from the rest of the pages. So, once we get the 2 dataframes, we need to concatenate both to get just one dataframe to work.

## Cleaning the reviews dataframe  <a name="cleaning-reviews"/> 

To clean the dataframe we have to transform some strings into datetime. So to deal with this, we need to use the time library. Also we need to extract the numbers from rating columns using an extract method.

![Datetime](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/Time.jpg)  
*Fig 4. Datetime algorithm*

## Sentiment Analysis  <a name="sentiment-analysis"/> 
 
The last part of the project is about the an analysis of the emotions of the sentences for each review. To do this it has been necessary implement the TextBlob library in order to get the polarity. From this one we can get some analysis to check the most positive polarity (close to 1), the most negative (close to -1), and also, to check the mean for the whole reviews from that restaurant. 

The results from this Sentiment Analysis are that the trend of the reviews looks positive from a general point of view. Also, we have compared the results of this Sentiment Analysis with the mean of the reviews that the users have done. 

![SentimentAnalysis](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/SentAn.jpg)  
*Fig 5. Polarity score per review*

## Lexical analysis  <a name="lexical-analysis"/>  
 
Finally, as an extra feature, we have been created a list of tokens, the most used words in the reviews. We also exclude the non stop words, and visualizing the results in Tableau.  

![LexicalAnalysis](https://github.com/SergiGuasch/Projects/blob/main/Data%20Analysis/Final%20Project/Images/words.jpg)
*Fig 5. Most frequency words in Cervecería Catalana reviews*
 
## Conclusions  <a name="Conclusions"/>   

As results from the different analysis extracted from the TripAdvisor we can conclude that the major density of restaurants in Barcelona are in the neighborhood "la Dreta de l'Eixample", and the neighborhoods that surround it. Also we can see that the general rating in Barcelona is about 4 of 5 stars, which means a notable score.

On the other hand, analysing the reviews extracted from the TripAdvisor website of Cervecería Catalana, we can appreciate a positive general trend of the whole reviews. Comparing this result with the mean ratings from the total number of reviews posted for this restaurant, we can also say that the model is not so accurate. However, in both cases the percentage of positive reviews indicates that Cerveceria Catalana is a recommendable restaurant for most of the people. 
  




