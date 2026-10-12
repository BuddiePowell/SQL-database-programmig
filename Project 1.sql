# Part 2
use Movies;

#Query 1
SELECT Title, ReleaseYear, Runtime, GrossRevenue
FROM Movie
WHERE Title LIKE 'W%'
  AND Runtime >= 105
  AND Runtime <= 135
  AND GrossRevenue IS NOT NULL
ORDER BY ReleaseYear DESC;

#Query #2
SELECT COUNT(DISTINCT Movie.MovieId) AS FamilyFriendlyMovieCount
FROM Movie
JOIN Rating ON Movie.MovieRating = Rating.Code
WHERE Movie.ReleaseYear < 2010 and MovieRating = 'PG'or 'G' or 'A';

  #Query 3
  SELECT 
    M.Title, 
    CONCAT_WS(' ', C.FirstName, NULLIF(C.MiddleName, ''), C.LastName) AS ActorName, 
    MA.BillingRank
FROM 
    Movie as M
JOIN 
    MovieActor as MA ON M.MovieId = MA.MovieId
JOIN 
    Celebrity as C ON MA.CelebrityId = C.CelebrityId
WHERE 
    M.Title LIKE '%Sunshine%'
ORDER BY 
    M.Title, 
    MA.BillingRank;

# Query 4
SELECT 
    G.Genre, 
    COUNT(*) AS TotalMovies, 
    MAX(M.IMDBRating) AS HighestIMDBRating
FROM 
    Movie AS M
inner JOIN 
    MovieGenre AS MG ON M.MovieId = MG.MovieId
inner JOIN 
    Genre AS G ON MG.GenreId = G.GenreId
WHERE 
    M.ReleaseYear >= 2000
GROUP BY 
    G.Genre
ORDER BY 
    TotalMovies DESC, 
    HighestIMDBRating DESC;
# Query 5
SELECT 
    M.Title, 
    M.ReleaseYear, 
    R.Category AS RatingCategory
FROM 
    Movie as M
JOIN 
    MovieGenre MG ON M.MovieId = MG.MovieId
JOIN 
    Genre G ON MG.GenreId = G.GenreId
LEFT outer JOIN 
    Rating as R ON M.MovieRating = R.Code
WHERE 
    G.Genre = 'Horror'
ORDER BY 
    M.ReleaseYear ASC, 
    M.Title ASC; 

SELECT 
    M.Title, 
    M.IMDBRating, 
    CONCAT(C.FirstName, ' ', C.LastName) AS LeadingActorName,
    DirectorId
FROM 
    Movie M
JOIN 
    MovieActor MA ON M.MovieId = MA.MovieId AND MA.BillingRank = 1
JOIN 
    Celebrity C ON MA.CelebrityId = C.CelebrityId
WHERE 
    M.DirectorId = '6'
    AND M.IMDBRating >= 8.0
ORDER BY 
    M.Title ASC;

SELECT 
    M.Title, 
    CONCAT(C.FirstName, ' ', C.LastName) AS StarName
FROM 
    Movie M
JOIN 
    MovieActor MA ON M.MovieId = MA.MovieId AND MA.BillingRank = 1
JOIN 
    Celebrity C ON MA.CelebrityId = C.CelebrityId
inner JOIN 
    MovieGenre MG ON M.MovieId = MG.MovieId
left outer JOIN 
    Genre G ON MG.GenreId = G.GenreId
WHERE 
    M.ReleaseYear = 2017
    AND G.Genre NOT IN ('Adventure', 'Action')
GROUP BY 
    M.Title, C.FirstName, C.LastName
ORDER BY 
    M.Title ASC;

SELECT 
    CONCAT(C.FirstName, ' ', C.LastName) AS ActorName,
    COUNT(MA.MovieId) AS NumberOfMovies,
    ROUND(AVG(M.IMDBRating), 2) AS AverageIMDBRating,
    SUM(M.NumVotes) AS TotalVotes
FROM 
    MovieActor MA
JOIN 
    Celebrity C ON MA.CelebrityId = C.CelebrityId
JOIN 
    Movie M ON MA.MovieId = M.MovieId
GROUP BY 
    C.CelebrityId
HAVING 
    COUNT(MA.MovieId) >= 8 
    AND AVG(M.IMDBRating) >= 8.0
ORDER BY 
    AVG(M.IMDBRating) DESC, 
    COUNT(MA.MovieId) DESC,
    SUM(M.NumVotes) DESC;

# Part 3
SELECT 
    D.FirstName AS DirectorFirstName, 
    D.LastName AS DirectorLastName, 
    A.FirstName AS ActorFirstName, 
    A.LastName AS ActorLastName, 
    COUNT(*) AS NumberOfCollaborations
FROM 
    MovieActor MA
JOIN 
    Celebrity A ON MA.CelebrityId = A.CelebrityId
JOIN 
    Movie M ON MA.MovieId = M.MovieId
JOIN 
    Celebrity D ON M.DirectorId = D.CelebrityId
GROUP BY 
    M.DirectorId, MA.CelebrityId
HAVING 
    COUNT(*) >= 3
ORDER BY 
    NumberOfCollaborations DESC;
