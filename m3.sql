--||A||--
SELECT REGION.Name, STAFF.Name
FROM REGION, STAFF
WHERE REGION.RegionManager = STAFF.StaffID
ORDER BY REGION.Name;

--||B||--
SELECT REGION.Name, COUNT(COUNTRY.RegionId) AS count
FROM REGION, COUNTRY
WHERE REGION.RegionId = COUNTRY.RegionId
GROUP BY REGION.Name
ORDER BY count;

--||C||--
SELECT Name, MAX(Charge) AS max
FROM CUSTOMER,STREAM
WHERE Country = 'United States' AND
YEAR(StreamDate)=2018 AND
STREAM.CustomerId = CUSTOMER.CustomerId
GROUP BY CUSTOMER.Name
ORDER BY max DESC, CUSTOMER.Name;

--||D||--
SELECT Title FROM MOVIE M, MOVIE_ACTOR MA, ACTOR A
WHERE A.ActorId = MA.ActorId AND
MA.MovieId = M.MovieId AND
A.Name = 'Tom Cruise'
ORDER BY Title;

--||E||--
SELECT Name,COUNT(*) AS count FROM MOVIE M, MOVIE_ACTOR MA, ACTOR A
WHERE A.ActorId = MA.ActorId AND
MA.MovieId = M.MovieId
GROUP BY Name
ORDER BY count DESC, Name
LIMIT 20;

--||F||--
SELECT Name FROM CUSTOMER C, STREAM S, MOVIE M
WHERE C.CustomerId = S.CustomerId AND
S.MovieID = M.MovieId AND
HOUR(S.StreamDate) >=20 AND
M.Duration >= 180
GROUP BY Name
ORDER BY Name;

--||G||--
DELETE FROM STREAM
WHERE
  Charge <= 5.5
AND
  CustomerId IN (
    SELECT CustomerId
    FROM CUSTOMER
    WHERE Country = 'China'
  );

  --||H||--
DELETE FROM MOVIE_ACTOR
WHERE
  MOVIE_ACTOR.ActorId IN (
    SELECT ActorId
    FROM ACTOR
    WHERE Name = 'Tom Cruise'
  )
  AND
  MOVIE_ACTOR.MovieID IN (
    SELECT MovieID
    FROM MOVIE_GENRE MG
    WHERE MG.GenreId IN (
      SELECT GenreId
      FROM GENRE
      WHERE Label = 'Action'
    )
  );

--||I||--
UPDATE CUSTOMER C SET Active=FALSE
WHERE NOT EXISTS
(SELECT * FROM STREAM
WHERE CustomerId = C.CustomerId)
AND
C.Country = 'China';

--||J||--
UPDATE STREAM S SET Charge = Charge + 1.5
WHERE S.MovieId IN (
  SELECT M.MovieId FROM MOVIE M
  WHERE Duration >=180)
  AND
 S.CustomerId IN (
  SELECT C.CustomerId FROM CUSTOMER C
  WHERE Country IN (
    SELECT Name FROM COUNTRY
    WHERE RegionId = (
      Select RegionId FROM REGION WHERE Name = 'Europe'
    )
  )
);
