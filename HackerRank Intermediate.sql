-- Easy Challenges completed in HackerRank. Many but not all are inclded. I used DB2 for most of them (that was the default)
-- The question will be in a comment followed by the query. 




/*Generate the following two result sets:
1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
   For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.

where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. 
If more than one Occupation has the same [occupation_count], they should be ordered alphabetically. */

SELECT Name || '(' || LEFT(Occupation,1) || ')' 
FROM OCCUPATIONS
ORDER BY Name ASC;

SELECT 'There are a total of'|| ' ' || COUNT(Name) || ' ' || Lower(Occupation) || 's.' 
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Name) ASC, Occupation ASC;




/*Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation. */

WITH Original AS -- First get the data we need for the table
(SELECT Name, Occupation, 
        row_number() over(PARTITION BY Occupation ORDER BY Name ASC) AS ROWNUMBER -- Need row numbers for order
FROM OCCUPATIONS)
SELECT -- Create each column individually
    MAX(CASE WHEN Occupation = 'Doctor' THEN NAME ELSE Null END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN NAME ELSE Null END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN NAME ELSE Null END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN NAME ELSE Null END) AS Actor
FROM Original
GROUP BY ROWNUMBER 
ORDER BY ROWNUMBER;




/* You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node. */

SELECT N,
    (CASE 
        WHEN P is NULL THEN 'Root' --No preceding values means root
        WHEN N in (SELECT P FROM BST) THEN 'Inner' --Being both a node and parent means inner
        ELSE 'Leaf' END) --Only other possibility is leaf
FROM BST
ORDER BY N;




/*Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2. */

WITH Temp AS --Get all the data we need first, did not need to use cte but it makes things easier
(   SELECT C.company_code, C.founder, 
    E.employee_code, E.manager_code, E.senior_manager_code, E.lead_manager_code 
    FROM Company AS C
    JOIN Employee AS E ON C.company_code = E.company_code    )

SELECT company_code, founder,
    COUNT(DISTINCT Temp.lead_manager_code),
    COUNT(DISTINCT Temp.senior_manager_code),
    COUNT(DISTINCT Temp.manager_code),
    COUNT(DISTINCT Temp.employee_code)
FROM Temp
GROUP BY company_code, founder
ORDER BY company_code;


