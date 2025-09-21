-- Extract and populate detailed table with film data and popularity metrics
INSERT INTO detailed_table (film_id, title, genre, popularity, description, release_year)
SELECT DISTINCT 
    film.film_id, 
    title, 
    category.name AS genre,
    rent_count(film.film_id) AS popularity, 
    description, 
    release_year
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN category ON film_category.category_id = category.category_id
ORDER BY popularity ASC;
