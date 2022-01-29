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

![bigquery schema](https://user-images.githubusercontent.com/98153604/151671911-87fb2835-43d0-4e85-8600-cd1d543ab0b3.JPG)


## 3. Data transform directly in Bigquery by SQL

(1). clean data,we need to tidy the data as the artist column contains multiple values in same cell. We will separate each observation into its individual row

     Create or replace table spotify_dataset.spotify2
     SELECT * except (artist), split(artist,',') as artist FROM `t-osprey-337221.spotify_dataset.spotify`;
     
![clean data](https://user-images.githubusercontent.com/98153604/151671931-3c57e6ca-c72a-4a23-9ff7-82302932a2f2.JPG)

You will see artist mode change to repeated, that is an array, we save the result to table spotify2

![clean data2](https://user-images.githubusercontent.com/98153604/151671977-0c666301-a224-40a6-affe-806df1754f36.JPG)

(2). We also found ' -' in artist array field, I should remove this ' -' in artist array field

      SELECT artist FROM `t-osprey-337221.spotify_dataset.spotify2` where ' -' in unnest(artist) LIMIT 1000
      
![sql --](https://user-images.githubusercontent.com/98153604/151672081-9a9582b0-8874-49ed-ad78-3073ec6e336e.JPG)

We run SQL to create table spotify3

      create or replace table spotify_dataset.spotify3 as 
      SELECT * except (artist), array(select * from unnest(artist) as x where x !=" -") as artist FROM `t-osprey-337221.spotify_dataset.spotify2`; 
    
We also flatten the artist field and create table spotify4
      

## 4. Data analyze in Bigquery by SQL
    
    (1). List of unique artists on “Top 200”
            
            with templetable as (select title, date, artist_all FROM `t-osprey-337221.spotify_dataset.spotify3` as p, 
            unnest(p.artist) as artist_all where chart='top200')

            select count(distinct artist_all) from templetable
            
    ![image](https://user-images.githubusercontent.com/98153604/151672306-ab05bd97-421f-43ac-a6a1-a9f89668f547.png)
    
    
    (2). Artist which appeared on the charts maximum number of times
    
    We first flatten the artist field and create table spotify4
    
         Create table spotify_dataset.spotify4 as 
         (select p.* except(artist), artist_all FROM `t-osprey-337221.spotify_dataset.spotify3` as p, 
          unnest(p.artist) as artist_all)
          
    And then:
    
         SELECT artist_all, count(*) as num FROM `t-osprey-337221.spotify_dataset.spotify4` 
         group by artist_all order by num desc
         
![image](https://user-images.githubusercontent.com/98153604/151672418-ece7bb18-bfeb-4ac0-a4d5-1c5560cc8e9b.png)






    
            
    


         



      
      


      





     

  

  
        
        
        


