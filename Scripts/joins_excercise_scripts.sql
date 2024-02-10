--1.Give the name, release year, and worldwide gross of the lowest grossing movie.


SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
LEFT JOIN revenue 
USING (movie_id)
ORDER BY revenue.worldwide_gross ASC
LIMIT 1;


--answer: "Semi-Tough";1977;37187139


--2.What year has the highest average imdb rating?

SELECT specs.film_title, specs.release_year, rating.imdb_rating
FROM specs
LEFT JOIN rating
USING (movie_id)
ORDER BY rating.imdb_rating DESC
LIMIT 1;

--answer: 2008


--3.What is the highest grossing G-rated movie? Which company distributed it?


SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross, distributors.company_name
FROM specs
LEFT JOIN revenue
USING (movie_id)
LEFT JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating IN ('G') 
ORDER BY worldwide_gross DESC

--answer: Toy Story 4; Walt Disney



--4.Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


SELECT company_name, COUNT(specs.movie_id)
FROM specs
FULL JOIN distributors
ON distributors.distributor_id = specs.domestic_distributor_id
WHERE company_name IS NOT NULL 
GROUP BY company_name




SELECT*
FROM revenue
SELECT*
FROM specs
SELECT*
FROM rating
SELECT*
FROM distributors

5.Write a query that returns the five distributors with the highest average movie budget.















6.How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?


7.Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
