-- Easy Challenges completed in HackerRank. Many but not all are inclded. I used DB2 for most of them (that was the default)
-- The question will be in a comment followed by the query. 


-- Query all columns for a city in CITY with the ID 1661.
SELECT * 
FROM CITY  
WHERE CITY.ID = 1661;


-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
SELECT * 
FROM CITY 
WHERE POPULATION > 100000 AND COUNTRYCODE = 'USA';



-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
SELECT NAME FROM CITY
WHERE POPULATION > 120000 
    AND COUNTRYCODE = 'USA'; 


-- Query all columns (attributes) for every row in the CITY table.
SELECT * 
FROM CITY;


-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT * 
FROM CITY 
WHERE COUNTRYCODE = 'JPN';


-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME 
FROM CITY 
WHERE COUNTRYCODE = 'JPN';


-- Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE 
FROM STATION;


-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY 
FROM STATION 
WHERE ID%2 = 0;


-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) 
FROM STATION;


/* Query the two cities in STATION with the shortest and longest CITY names, as well as their 
respective lengths (i.e.: number of characters in the name). If there is more than one smallest 
or largest city, choose the one that comes first when ordered alphabetically. */
SELECT CITY, LENGTH(CITY) 
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1 ;

SELECT CITY, LENGTH(CITY) 
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY
LIMIT 1 ;


-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY LIKE 'A%' 
    OR CITY LIKE 'E%' 
    OR CITY LIKE 'I%' 
    OR CITY LIKE 'O%' 
    OR CITY LIKE 'U%';


-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT city 
FROM station 
WHERE right(city, 1) IN ('a','e','i','o','u');



-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
SELECT DISTINCT CITY 
FROM STATION
WHERE left(CITY,1) IN ('A','E','I','O','U') 
    AND right(CITY,1) IN ('a','e','i','o','u');


-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');


-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('a' ,'e' ,'i' ,'o' ,'u' );


-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A','E','I','O','U')
    OR RIGHT(CITY, 1) NOT IN ('a','e','i','o','u');


-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY ,1) NOT IN ('A','E','I','O','U')
    AND RIGHT(CITY,1) NOT IN ('a','e','i','o','u');


-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT NAME 
FROM Employee
ORDER BY NAME ASC;


-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary 
-- greater than 2000 per month who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT name 
FROM Employee 
WHERE salary > 2000 
    AND months < 10;




































