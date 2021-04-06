--||A||--
SELECT C.Name
FROM CUSTOMER C
LEFT OUTER JOIN STREAM S
ON(C.CustomerId = S.CustomerId)
WHERE C.Country = 'China' AND StreamId IS NULL;

--||B||--
SELECT C.COUNTRY, COUNT(*)
FROM STREAM S
RIGHT OUTER JOIN CUSTOMER C
ON(C.CustomerId = S.CustomerId)
WHERE S.StreamId IS NULL
GROUP BY C.Country;

--||C||--
SELECT M.Title, COUNT(StreamId) AS count
FROM MOVIE M
LEFT OUTER JOIN STREAM S
ON(M.MovieId = S.MovieId)
WHERE M.Year = 2015
GROUP BY M.Title
HAVING count <= 5 ;

--||D||--
SELECT A.Name, COUNT(B.Supervisor) AS cnt
FROM STAFF A
LEFT OUTER JOIN STAFF B
ON (A.StaffId = B.Supervisor)
GROUP BY A.Name
ORDER BY  cnt DESC, A.Name;

--||E||--
SELECT A.Name, COUNT(MA.ActorId) AS cnt
FROM ACTOR A
LEFT OUTER JOIN MOVIE_ACTOR MA
ON(A.ActorId = MA.ActorId)
GROUP BY A.Name
HAVING cnt>=15
ORDER BY cnt DESC, A.Name;

--||F||--
SELECT Title, A2.Name
FROM
  (MOVIE_ACTOR MA1 NATURAL JOIN ACTOR A1)
  JOIN
  (MOVIE_ACTOR MA2 NATURAL JOIN ACTOR A2)
USING(MovieId)
NATURAL JOIN MOVIE
WHERE A1.Name = 'Johnny Depp' AND A2.Name <>A1.Name
ORDER BY Title, A2.Name;

--||G||--
SELECT A1.Name, A2.Name, count(A2.Name) AS count
FROM
  (MOVIE_ACTOR MA1 NATURAL JOIN ACTOR A1)
  LEFT OUTER JOIN
  (MOVIE_ACTOR MA2 NATURAL JOIN ACTOR A2)
  USING(MovieId)
WHERE A1.Name < A2.Name
GROUP BY A1.Name, A2.Name
HAVING count >=4
ORDER BY COUNT DESC, A1.NAME ASC, A2.NAME ASC;

--||H||--
SELECT GENRE.Label, REGION.Name, COUNT(StreamId)
FROM (REGION JOIN GENRE)
    LEFT OUTER JOIN
    (
      CUSTOMER
      NATURAL JOIN STREAM
      NATURAL JOIN MOVIE_GENRE
      JOIN COUNTRY ON(CUSTOMER.Country = COUNTRY.Name)
    )
    USING(RegionId,GenreId)
    GROUP BY GENRE.Label, REGION.Name
    ORDER BY GENRE.Label, REGION.Name;


    --/ ! \ NOTA SOBRE O H / ! \ --
select GenreId, RegionId, count(StreamId) as cont
from CUSTOMER
  NATURAL JOIN STREAM
  NATURAL JOIN MOVIE_GENRE
  JOIN COUNTRY ON(CUSTOMER.Country = COUNTRY.Name)
  Group by GenreId, RegionId;
--DEPOIS É SÓ FAZER JOIN COM AS TABELAS GENRE E REGION
