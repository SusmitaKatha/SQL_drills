-- a query that returns the owner_id, owners table and  transaction_id and service, transactions table.
-- all records from the transactions table are returned
-- sort the results in ascending order according to owner_id
SELECT owners.owner_id, transaction_id, service
FROM owners RIGHT OUTER JOIN transactions
ON owners.pet_id = transactions.pet_id
ORDER BY owners.owner_id;


--a query that returns the owner_id, pet_id, transaction_id, and visits_count fields from their tables
--Sort in order of transaction_id
--Do not include records where transaction_id is NULL
SELECT owner_id, owners.pet_id, transaction_id, visits_count
FROM owners
JOIN transactions
ON owners.pet_id = transactions.pet_id
JOIN visits
ON transactions.pet_id = visits.pet_id
WHERE transaction_id IS NOT NULL
ORDER BY transaction_id;


-- a query that returns the pet_id and size from the owners table
--and the visits_count (as the alias num_visits) from the visits table
-- Keep only the records where dogs had 10 or more visits 
--sort by the number of visits in descending order
SELECT owners.pet_id, size, visits_count AS num_visits
FROM owners
JOIN visits
ON owners.pet_id = visits.pet_id
WHERE visits_count >= 10
ORDER BY num_visits DESC;


-- the list of all unique dog owners from both tables, owners and owners_2
--  return a single field that shows a list of owner_id records, and order by owner_id
SELECT owner_id FROM owners
UNION
SELECT owner_id FROM owners_2
ORDER BY owner_id;


-- top three customers (owner_id) based upon how many visits they've had
-- some owners have more than one pet, add up all of their visits across all pets
-- list customers (owner_id) in descending order according to number of visits (using the alias num_visits)
SELECT owner_id , SUM(visits_count) AS num_visits
FROM owners
JOIN visits 
ON owners.pet_id = visits.pet_id
GROUP BY owner_id
ORDER BY num_visits DESC
LIMIT 3;


-- a query that returns owner_id from both the owners and owners_2 tables 
--include the transaction_id, date, and service fields from the transactions table
-- Sort results first by date, then by transaction_id, and finally by owner_id in descending order
-- Do not include records where transaction_id is NULL
SELECT owner_id, transaction_id, date, service 
FROM owners JOIN transactions ON owners.pet_id = transactions.pet_id
UNION
SELECT owner_id, transaction_id, date, service 
FROM owners_2 JOIN transactions ON owners_2.pet_id = transactions.pet_id
WHERE transaction_id IS NOT NULL
ORDER BY date, transaction_id, owner_id DESC;


-- Return a table that includes all records from both owners and owners_2 tables
--include a new field, owner_pet which is formatted as owner_id, pet_id 
-- Return only the rows where the number of visits is greater than or equal to 3
-- Sort the results by number of visits (largest to smallest)
--if there's a tie, sort by your newly created owner_petfield
SELECT CONCAT(owner_id,', ', owners.pet_id) AS owner_pet, visits_count
FROM owners JOIN visits 
ON owners.pet_id = visits.pet_id
WHERE visits_count >= 3
UNION
SELECT CONCAT(owner_id,', ', owners_2.pet_id) AS owner_pet, visits_count
FROM owners_2 JOIN visits 
ON owners_2.pet_id = visits.pet_id
WHERE visits_count >= 3
ORDER BY visits_count DESC, owner_pet;


--  the visit counts for each pet, and order the output from most to least visits
-- Include the owner_id, pet_id, and visits_count columns in your output
SELECT owner_id, owners.pet_id, visits_count
FROM owners JOIN visits
ON owners.pet_id = visits.pet_id
ORDER BY visits_count DESC;


-- Write a query that returns the owner_id, pet_id, date, and service for transactions
-- happened on June 17th, 2019, or for transactions where the service provided was a haircut
-- Order your results by date
SELECT owner_id, owners.pet_id, date, service
FROM owners JOIN transactions
ON owners.pet_id = transactions.pet_id
WHERE date = '6/17/19' OR service = 'haircut'
ORDER BY date;


--  a promotion to give a gift to those pets who have had their nails done at the salon
--  the pet_id and service for those pets that used the nails service from transactions
--  sort by those pets first who are receiving a gift
SELECT pet_id, service,
CASE
  WHEN service = 'nails' THEN 'gift'
  ELSE 'no gift' END AS get_gift
 FROM transactions
 ORDER BY get_gift;
 
 
-- how many transactions took place on June 17 and 18
SELECT date, COUNT(transaction_id)
 FROM transactions
 WHERE date IN('2019-06-17', '2019-06-18')
 GROUP BY date; 


-- how many dogs there are of each size (count for each of the three sizes of dogs, small, medium, and large)
--sort the list from smallest to largest
-- final output: the size and count, use the alias all_owners and the alias size_count
SELECT size, COUNT(size) AS size_count
FROM (SELECT * FROM owners
      UNION
      SELECT * FROM owners_2) AS all_owners
GROUP BY size
ORDER BY size DESC;