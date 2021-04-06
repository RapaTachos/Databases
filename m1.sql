--||A||--
SELECT *
FROM MOVIE
WHERE Title = 'Thor';

--||B||--
SELECT Name, City
FROM CUSTOMER
WHERE Country = 'France'
ORDER BY City Asc;

--||C||--
UPDATE CUSTOMER
SET Phone = NULL
WHERE (Active = False && Country = 'China');

--||D||--
DELETE FROM STREAM WHERE charge>10;

--||E||--
SELECT Title, Year
FROM MOVIE
WHERE Title LIKE "Star Wars%"
ORDER BY Year ASC;
