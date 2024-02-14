--1.Give the name, release year, and worldwide gross of the lowest grossing movie.


SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
LEFT JOIN revenue 
USING (movie_id)
ORDER BY revenue.worldwide_gross ASC
LIMIT 1;


--answer: "Semi-Tough";1977;37187139


--2.What year has the highest average imdb rating?

SELECT specs.release_year, avg (rating.imdb_rating)
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY specs.release_year
ORDER BY  avg (rating.imdb_rating) DESC
LIMIT 1;

--answer: 1991


--3.What is the highest grossing G-rated movie? Which company distributed it?


SELECT specs.film_title, specs.mpaa_rating, revenue.worldwide_gross, distributors.company_name
FROM specs
INNER JOIN revenue
USING (movie_id)
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating IN ('G') 
ORDER BY worldwide_gross DESC

--answer: Toy Story 4; Walt Disney



--4.Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.


SELECT company_name, COUNT(specs.movie_id)
FROM specs
LEFT JOIN distributors
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name
ORDER BY COUNT(specs.movie_id)


--5.Write a query that returns the five distributors with the highest average movie budget.


SELECT distributors.company_name, avg (revenue.film_budget)
FROM specs
INNER JOIN revenue
USING (movie_id)
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE film_budget IS NOT NULL 
GROUP BY distributors.company_name
ORDER BY avg (revenue.film_budget) DESC
LIMIT 5;



--6.How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT distributors.company_name,specs.film_title, rating.imdb_rating,distributors.headquarters
FROM specs
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating
USING (movie_id)
WHERE distributors.headquarters NOT ILIKE  '%, CA%' 
GROUP BY distributors.company_name, rating.imdb_rating, distributors.headquarters,specs.film_title
ORDER BY rating.imdb_rating DESC

--answer: 2, Dirty Dancing 

--7.Which have a higher average rating, movies which are over two hours long or movies which are under two hours?


SELECT movie_length, avg(imdb_rating)
FROM rating 
INNER JOIN (
 	SELECT CASE 
	WHEN length_in_min  > 120 then 'OVER 120'
	WHEN length_in_min < 120 then 'UNDER 120'
	ELSE '120' 
	END as movie_length, movie_id
	FROM specs
)
USING (movie_id)
GROUP BY movie_length 

--answer: over 120

SELECT 
	CASE
	 WHEN length_in_min  > 120 then 'OVER 120'
	 WHEN length_in_min < 120 then 'UNDER 120'
	 ELSE '120' 
	 END AS under_over_2_hours,
	 ROUND (AVG(imdb_rating),2)
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY under_over_2_hours