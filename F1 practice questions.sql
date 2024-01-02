--- These are practice questions that I have completed on a data set about F1 races and participants. These Queries were run on a Snowflake server




-- Find each Driver
SELECT driverid, forename, surname
FROM drivers;




-- Fastest lap speeds per driver per race
SELECT d.driverid, d.forename, d.surname, r.raceid, r.fastestlapspeed
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
WHERE r.fastestlapspeed IS NOT NULL;




-- Fastest lap per driver
SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) as "Fastest Speed"
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
WHERE r.fastestlapspeed IS NOT null
GROUP BY d.driverid, d.forename, d.surname;




-- Monaco 2021 fastest lap speeds per driver
SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) as "Fastest Speed"
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
JOIN races ON r.raceid = races.raceid
WHERE r.fastestlapspeed is not null 
    AND races.name ilike '%Monaco%'
    AND races.year = 2021
GROUP BY d.driverid, d.forename, d.surname
ORDER BY max(r.fastestlapspeed) DESC;




-- drivers and fastest lap speed of all time
SELECT forename,
        surname,
        (SELECT max(fastestlapspeed) FROM results)
FROM drivers;




--drivers and fastest lap speed in Monaco 2021
SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) AS "Fastest Speed",
(SELECT max(fastestlapspeed) FROM results)
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
JOIN races ON r.raceid = races.raceid
WHERE r.fastestlapspeed is not null 
    AND races.name ilike '%Monaco%'
    AND races.year = 2021
GROUP BY d.driverid, d.forename, d.surname
ORDER BY max(r.fastestlapspeed) DESC;




-- per driver, fastest lap speed monaco 2021 and how many times they won in monaco before
SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) as "Fastest Speed", total_wins
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
JOIN races ON r.raceid = races.raceid
JOIN (
    SELECT standings.driverid, sum(standings.wins) AS total_wins
    FROM driver_standings AS standings 
    JOIN races ON races.raceid = standings.raceid
    WHERE races.name ilike '%Monaco%'
    GROUP BY standings.driverid) AS Wins ON d.driverid = Wins.driverid
WHERE r.fastestlapspeed is not null 
    AND races.name ilike '%Monaco%'
    AND races.year = 2021
GROUP BY d.driverid, d.forename, d.surname, total_wins;


SELECT standings.driverid, sum(standings.wins) 
FROM driver_standings AS standings 
JOIN races ON races.raceid = standings.raceid
WHERE races.name ilike '%Monaco%'
GROUP BY standings.driverid;




-- CTE example
WITH pts
    AS (SELECT driverid,sum(points) 
    FROM results
    GROUP BY driverid)
    
SELECT drivers.driverid, pts.*
FROM drivers
JOIN pts ON pts.driverid = drivers.driverid;

SELECT driverid, sum(points)
FROM results 
GROUP BY driverid;




-- list of drivers with fastest lap speeds in monaco in2021 and how many times they won  (with CTE)
WITH wins AS
    (SELECT driverid, sum(wins) AS numbers
    FROM driver_standings AS standings
    JOIN races ON standings.raceid = races.raceid
    WHERE races.name ilike '%Monaco%' 
    GROUP BY driverid)

SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) AS "Fastest Speed", max(numbers)
FROM drivers AS d
JOIN results AS r ON d.driverid = r.driverid
JOIN races ON r.raceid = races.raceid
JOIN wins ON wins.driverid = d.driverid
WHERE r.fastestlapspeed IS NOT null 
    AND races.name ilike '%Monaco%'
    AND races.year = 2021
GROUP BY d.driverid, d.forename, d.surname;




-- recursive CTE
WITH numbers AS (SELECT 1 AS n 
                UNION ALL
                SELECT n + 1 as n 
                FROM numbers
                WHERE n + 1 <= 10)
SELECT n FROM numbers;




-- list of drivers fastest lap speed in monaco in 2021 and 2019
WITH results_2021 AS 
       (SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) as fastest_2021
        FROM drivers AS d
        JOIN results AS r ON d.driverid = r.driverid
        JOIN races ON r.raceid = races.raceid
        WHERE r.fastestlapspeed is not null 
            AND races.name ilike '%Monaco%'
            AND races.year = 2021
        GROUP BY d.driverid, d.forename, d.surname
        ORDER BY max(r.fastestlapspeed) DESC
        ),
    results_2019 AS
       (SELECT d.driverid, d.forename, d.surname, max(r.fastestlapspeed) AS fastest_2019
        FROM drivers AS d
        JOIN results AS r ON d.driverid = r.driverid
        JOIN races ON r.raceid = races.raceid
        WHERE r.fastestlapspeed is not null 
            AND races.name ilike '%Monaco%'
            AND races.year = 2019
        GROUP BY d.driverid, d.forename, d.surname
        ORDER BY max(r.fastestlapspeed) DESC
        )
SELECT drivers.driverid, drivers.forename, drivers.surname, fastest_2021, fastest_2019
FROM drivers
JOIN results_2021 ON results_2021.driverid = drivers.driverid
JOIN results_2019 ON results_2019.driverid = drivers.driverid ;
