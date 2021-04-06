--||A||--
SELECT COUNT(DepId) FROM DEPARTMENT;

--||B||--
SELECT AVG(Duration) FROM MOVIE
WHERE Year >=2000;

--||C||--
SELECT COUNT(DISTINCT City) FROM CUSTOMER;

--||D||--
SELECT MIN(Charge), MAX(Charge),
        AVG(Charge), SUM(Charge)
FROM STREAM WHERE Year(StreamDate) = 2017;

--||E||--
SELECT Year, COUNT(MovieId)
FROM MOVIE
GROUP BY Year
ORDER BY Year DESC;

--||F||--
SELECT Year,Count(Title)
FROM MOVIE
GROUP BY Year
ORDER BY Count(MovieID) DESC
LIMIT 5;

--||G||--
SELECT Year,Count(*) AS count
FROM MOVIE
WHERE Duration >= 120
GROUP BY Year
HAVING count>=10
ORDER BY count DESC, year ASC;

--||H||--
SELECT HOUR(StreamDate),COUNT(*)
FROM STREAM
GROUP BY HOUR(StreamDate)
ORDER BY HOUR(StreamDate) ASC;

--||I||--
SELECT YEAR(StreamDate),MONTH(StreamDate), SUM(Charge)
FROM STREAM
GROUP BY YEAR(StreamDate),MONTH(StreamDate)
ORDER BY YEAR(StreamDate),MONTH(StreamDate);

--||J||--
SELECT CustomerId, SUM(Charge) AS sum
FROM STREAM
GROUP BY CustomerId
HAVING sum<=100
ORDER BY sum DESC, CustomerId ASC;
