UPDATE STREAM SET Charge = Charge + 1.5
  WHERE STREAM.MovieId IN (
    SELECT MovieId FROM MOVIE
    WHERE MOVIE.MovieId IN(
      SELECT MovieId FROM MOVIE_ACTOR
      WHERE ActorId IN(
        SELECT ActorId FROM ACTOR WHERE ACTOR.Name = 'Denzel Washington'
      )
    )
);

    JOIN MOVIE_ACTOR USING(MovieId)
    JOIN ACTOR USING(ActorId)
    WHERE ACTOR.Name = 'Denzel Washington'
  );


  JOIN CUSTOMER USING(CustomerId)
  JOIN COUNTRY ON(CUSTOMER.Country = COUNTRY.Name)
  JOIN REGION USING(RegionId)
