-- query that selects column_name and data_type from information_schema.columns
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';

-- query to select the first fifty records of the naep table
SELECT *
FROM naep
LIMIT 50;


-- query that returns summary statistics for avg_math_4_score by state,
-- summary statistics include count, average, min, and max values
-- sort the results alphabetically by state name
SELECT COUNT(avg_math_4_score) AS count_4
      , AVG(avg_math_4_score) AS avg_4
      , MIN(avg_math_4_score) AS min_4
      , MAX(avg_math_4_score) AS max_4
      , state
FROM naep
GROUP BY state
ORDER BY state;


-- query that summary statistics for avg_math_4_score by state
-- with differences in max and min values that are greater than 30
SELECT COUNT(avg_math_4_score) AS count_4
      , AVG(avg_math_4_score) AS avg_4
      , MIN(avg_math_4_score) AS min_4
      , MAX(avg_math_4_score) AS max_4
      , state
FROM naep
GROUP BY state
-- your code goes here
HAVING (MAX(avg_math_4_score) - MIN(avg_math_4_score)) > 30;


-- query that returns the avg_math_4_score as the alias avg_score 
-- the state as the alias bottom_10_states
-- lists the states in the bottom 10 for avg_math_4_score in the year 2000
SELECT avg_math_4_score::float AS avg_score
       , state AS bottom_10_states
FROM naep
WHERE year = 2000
ORDER BY avg_score
LIMIT 10;


-- query that calculates the average avg_math_4_score 
-- rounded to the nearest 2 decimal places over all states in the year 2000
SELECT ROUND(AVG(avg_math_4_score), 2) AS avg_math_4_score
FROM naep
WHERE year = 2000;


-- query that returns a field called below_250 that lists all states
-- with an avg_math_4_score less than 250, over all states in the year 2000
SELECT state AS below_250
FROM naep
WHERE year = 2000
      AND avg_math_4_score < 250;


-- query that returns a field called scores_missing_y2000 that lists any states 
-- with missing values in the avg_math_4_score column of the naep data table for the year 2000
SELECT state AS scores_missing_y2000
FROM naep
WHERE year = 2000
      AND avg_math_4_score IS NULL;


-- query that returns, for the year 2000, the state, avg_math_4_score, and total_expenditure fields 
-- from the naep table left outer joined on the finance table
-- ordered by total_expenditure, from largest to smallest
-- round avg_math_4_score to the nearest 2 decimal places
-- filter out NULL from avg_math_4_scores 
SELECT naep.state
      , ROUND(avg_math_4_score, 2) AS avg_math_4_score
      , total_expenditure
FROM naep LEFT OUTER JOIN finance 
ON naep.id = finance.id
WHERE naep.year = 2000
      AND avg_math_4_score IS NOT NULL
ORDER BY total_expenditure DESC;