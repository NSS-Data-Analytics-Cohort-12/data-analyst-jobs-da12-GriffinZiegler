-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?

SELECT count(*)
FROM data_analyst_jobs;

-- 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT count(location)
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
GROUP BY location;

--21 in TN, 6 in KY, 27 total.

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT count(location) AS TN4STARS
FROM data_analyst_jobs
WHERE star_rating > 4 AND location IN ('TN');

-- 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT count(star_rating)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 151

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT AVG(star_rating) AS avg_rating, location AS state
FROM data_analyst_jobs
	WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;

-- NE

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT count(DISTINCT title)
FROM data_analyst_jobs;

-- 881

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(distinct title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- 230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, avg(star_rating)
FROM data_analyst_jobs
	WHERE company IS NOT NULL
GROUP BY company, review_count
HAVING review_count > 5000;

-- 45

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, avg(star_rating), review_count
FROM data_analyst_jobs
	WHERE company IS NOT NULL
GROUP BY company, review_count
HAVING review_count > 5000
ORDER BY avg(star_rating) DESC, review_count DESC;

-- Kaiser Permanente, 4.199 8164 review counts

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT count(DISTINCT title)
FROM data_analyst_jobs
WHERE title LIKE ('%Analyst%');

-- 754

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%analyst%' AND title NOT LIKE '%analytics%';

--

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--  - Disregard any postings where the domain is NULL. 
--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT domain AS industry, count(title) AS numofjobs, days_since_posting
FROM data_analyst_jobs
WHERE domain IS NOT NULL --Disregard postings where domain is NULL
	AND skill LIKE '%SQL%' --Require SQL
	AND days_since_posting > 21 --Posted longer than 3 weeks
	GROUP BY industry, days_since_posting
ORDER BY numofjobs DESC -- order result so domain with greatest # of "hard to fill jobs" is at top
LIMIT 4; -- Top 4

-- These results are of # of jobs listed per industry that have been vacant for 30 days
-- Bank & Financial Services, 51 Jobs
-- Internet and Software, 49 Jobs
-- Health Care, 44 Jobs
-- Consulting and Business Services, 44 Jobs



