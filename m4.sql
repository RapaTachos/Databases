--||A||--
SELECT Title, Year
FROM MOVIE
WHERE Duration>=180;

--||B||--
SELECT Name, City, Country
FROM CUSTOMER
WHERE Name LIKE 'Ch%';

--||C||--
SELECT SUM(Charge)
FROM STREAM
WHERE YEAR(StreamDate) = 2018;

--||D||--
SELECT YEAR(StreamDate), COUNT(*), SUM(Charge)
FROM STREAM
GROUP BY YEAR(StreamDate);

--||E||--
SELECT Year, COUNT(*)
FROM MOVIE
WHERE Duration >=120
GROUP BY YEAR
HAVING COUNT(*)>=20;

--||F||--
SELECT StaffId FROM STAFF
WHERE Supervisor IS NULL
UNION
SELECT StaffId FROM DEPARTMENT D, STAFF S
WHERE D.Manager = S.StaffId;

--||G||--
SELECT D.DepId, D.Name, D.Manager, S.Name
FROM DEPARTMENT D, STAFF S
WHERE D.MANAGER = S.StaffId;

--||H||--
SELECT M.Title, A.Name
FROM MOVIE M, MOVIE_ACTOR MA, ACTOR A
WHERE M.Title LIKE '%Superman%'
  AND A.ActorId = MA.ActorId
  AND MA.MovieId = M.MovieId;

--||I||--
SELECT M.Title, M.Duration, M.Year, S.StreamDate
FROM MOVIE M, STREAM S
WHERE M.Duration >= 140
  AND M.Year = YEAR(StreamDate) - 1
  AND M.MovieId = S.MovieId;

--||J||--
SELECT R.Name, COUNT(*)
FROM REGION R, CUSTOMER CU, COUNTRY C
WHERE CU.Country = C.Name AND C.RegionId = R.RegionId
GROUP BY R.NAME;
