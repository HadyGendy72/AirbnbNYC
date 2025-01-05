USE db2;

SELECT * FROM ab_nyc_2019;

-- Creating a staging set
 
CREATE table ab_nyc_2019_staging
LIKE ab_nyc_2019;

Insert ab_nyc_2019_staging
SELECT * FROM ab_nyc_2019;

-- Show the statging table

SELECT * FROM ab_nyc_2019_staging;

-- to check for dups

SELECT COUNT(id), `name`
FROM ab_nyc_2019_staging
GROUP BY 2
having count(id)>1;

-- standardizing the data 

-- Triming

Update ab_nyc_2019_staging
SET `name` = TRIM(`name`);

-- --misspelled names

SELECT distinct neighbourhood_group
From ab_nyc_2019_staging
Order by 1;

SELECT distinct neighbourhood
From ab_nyc_2019_staging
Order by 1;

SELECT *
From ab_nyc_2019_staging
ORDER BY  Price DESC
limit 10;

SELECT *
From ab_nyc_2019_staging
ORDER BY  calculated_host_listings_count DESC
limit 10;

SELECT *
From ab_nyc_2019_staging
ORDER BY  last_review ASC;

update ab_nyc_2019_staging
SET last_review= 1980-1-1
WHERE last_review = '198%';

update ab_nyc_2019_staging
SET last_review= 1990-1-1
WHERE last_review = '1992' OR last_review= '1990';

update ab_nyc_2019_staging
SET last_review= 1994-1-1
WHERE last_review = '1994';

update ab_nyc_2019_staging
SET last_review= 1996-1-1
WHERE last_review = '1996';

update ab_nyc_2019_staging
SET last_review= 1998-1-1
WHERE last_review = '1998';

-- Update a column to the correct form

update ab_nyc_2019_staging
SET last_review = str_to_date(last_review, '%Y-%m-%d')
WHERE last_review is NOT null AND last_review != '';

update ab_nyc_2019_staging
SET last_review= 2000-1-1
WHERE last_review is Null OR last_review = '';

ALTER table ab_nyc_2019_staging
MODIFY last_review date;

-- Check Nulls or Empty cells

select * 
FROM ab_nyc_2019_staging
WHERE neighbourhood IS NULL or neighbourhood = '';

select * 
FROM ab_nyc_2019_staging
WHERE id IS NULL or id = '';

select * 
FROM ab_nyc_2019_staging
WHERE host_id IS NULL or host_id = '';

select * 
FROM ab_nyc_2019_staging
WHERE number_of_reviews IS NULL or  number_of_reviews= '';

select * 
FROM ab_nyc_2019_staging
WHERE reviews_per_month= '';
-- fix the empty cell to zero

Update ab_nyc_2019_staging
SET reviews_per_month = 0
WHERE reviews_per_month= '';


-- Exploretory Data Analysis


-- List of the the average price for a night in each neighbourhood in a Entire home/apt 
SELECT neighbourhood_group, room_type , avg(price) as Average_Price
From ab_nyc_2019_staging
WHERE room_type = 'Entire home/apt'
GROUP BY neighbourhood_group, room_type
Order by Average_Price DESC;

-- List of the the average price for a night in each neighbourhood in a private room 
SELECT neighbourhood_group, room_type , avg(price) as Average_Price
From ab_nyc_2019_staging
WHERE room_type = 'Private room'
GROUP BY neighbourhood_group, room_type
Order by Average_Price DESC;

SELECT * FROM ab_nyc_2019_staging;

-- list of the most reviewed property in Manhattan
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Manhattan'
Order by number_of_reviews DESC
LIMIT 10;

-- list of the most reviewed property in Queens
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Queens'
Order by number_of_reviews DESC
LIMIT 10;

-- list of the most reviewed property in Brooklyn
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Brooklyn'
Order by number_of_reviews DESC
LIMIT 10;

-- list of the most reviewed property in Bronx
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Bronx'
Order by number_of_reviews DESC
LIMIT 10;

-- List of the cheapest property in Manhattan and it is reviewed by at least 5 people
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Manhattan' AND number_of_reviews > 4
Order by price ASC
LIMIT 10;

-- List of the cheapest property in Brooklyn and it is reviewed by at least 5 people
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Brooklyn' AND number_of_reviews > 4
Order by price ASC
LIMIT 10;

-- List of the cheapest property in Queens and it is reviewed by at least 5 people
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Queens' AND number_of_reviews > 4
Order by price ASC
LIMIT 10;

-- List of the cheapest property in Bronx and it is reviewed by at least 5 people
SELECT name, neighbourhood_group, room_type , price, number_of_reviews
FROM ab_nyc_2019_staging
WHERE neighbourhood_group = 'Bronx' AND number_of_reviews > 4
Order by price ASC
LIMIT 10;

