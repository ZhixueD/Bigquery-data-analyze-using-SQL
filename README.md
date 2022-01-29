# Bigquery-data-analyze-using-SQL

In this project I analyze data from Spotify, datasets is a big csv file, download from kaggle API: "datasets download -d dhruvildave/spotify-charts" 

https://www.kaggle.com/dhruvildave/spotify-charts

This is a big csv data, total 3.4 G, I use ELT pipeline, to do data analyze. 

1. Download data to google cloud storage
2. From google cloud storage directly load data to Bigquery
3. Data transform directly in Bigquery by SQL
4. Data analyze in Bigquery by SQL


## 1. Download data and upload to google cloud storage
 
 In linux:
        sudo apt-get install python3-pip
        pip3 install kaggle
        mkdir ~/.kaggle
        
 copy kaggle.json key file from kaggle, and save it to ~/.kaggle
 
 run command line:
 
        kaggle datasets download -d dhruvildave/spotify-charts
        
 It start to download
After finished, unzip it and upload to google cloud storage bucket.

![google cloud storage data](https://user-images.githubusercontent.com/98153604/151671732-ef7c422b-9b8c-428b-9abe-d8f461377528.JPG)

## 2. From google cloud storage directly load data to Bigquery

  Create a dataset in Bigquery, and create a table directly from google cloud storage

![load data from GCS to bigquery](https://user-images.githubusercontent.com/98153604/151671815-21020780-5b33-4329-9c95-edefec1f5f8c.JPG)

  

  
        
        
        


