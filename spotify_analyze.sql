#List of unique artists on “Top 200”

with templetable as (select title, date, artist_all FROM `t-osprey-337221.spotify_dataset.spotify3` as p, 
unnest(p.artist) as artist_all where chart='top200')

select count(distinct artist_all) from templetable;


#Artist which appeared on the charts maximum number of times

Create table spotify_dataset.spotify4 as 
(select p.* except(artist), artist_all FROM `t-osprey-337221.spotify_dataset.spotify3` as p, 
unnest(p.artist) as artist_all
)

SELECT artist_all, count(*) as num FROM `t-osprey-337221.spotify_dataset.spotify4` 
group by artist_all order by num desc;


#Finding artists with highest number of streams

SELECT artist_all, sum(streams) as total_streams FROM `t-osprey-337221.spotify_dataset.spotify4` 
group by artist_all order by total_streams desc


#Artist with maximum number of songs to feature on chart

SELECT artist_all, count(distinct title) as totol_songs 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
group by artist_all order by totol_songs desc;


#Get the range of timeline of the data

SELECT MIN(date) as begin, MAX(date) as time_end 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE chart = 'top200';

#Total Number of songs by TS has appeared in top 200

SELECT count(distinct title) NoOfSongs 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE artist_all LIKE '%Taylor Swift%';

#Counting number of times Taylor Swift appeared in the TOP 200 trend

SELECT Count(*) N_InTop200 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE artist_all 
LIKE '%Taylor Swift%' 
AND chart = 'top200';


#Listing Taylor's TOP 10

SELECT title, SUM(streams) streams 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE artist_all LIKE '%Taylor Swift%' 
AND streams IS NOT NULL 
GROUP BY title 
ORDER BY streams DESC 
LIMIT 10;


#Seeing how many times each song has appeared in top 200

SELECT title, count(title) AS count 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE artist_all LIKE '%Taylor Swift%' 
AND chart = 'top200' 
GROUP BY title 
ORDER BY count DESC;

#Getting the top1 ranks the songs have attained and the number of times they have been there in that position

SELECT title, count(rank) count_of_top1 
FROM `t-osprey-337221.spotify_dataset.spotify4` 
WHERE artist_all LIKE '%Taylor Swift%' 
AND chart = 'top200' 
AND rank =1
GROUP BY title
order by count_of_top1 desc;

#Highest, Lowest and the mean rank of the songs

SELECT Title, MIN(rank) Highest, MAX(rank) Lowest, AVG(rank) Avg 
FROM `t-osprey-337221.spotify_dataset.spotify4`
WHERE artist_all like '%Taylor Swift%' 
AND chart='top200' 
GROUP BY title 
ORDER BY Avg;











