-- Custom function to count rental occurrences for a given film
CREATE OR REPLACE FUNCTION rent_count(movie_id integer)
RETURNS integer AS
$$
DECLARE rental_count integer;
BEGIN
    SELECT COUNT(rental.rental_date) INTO rental_count
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    WHERE film.film_id = movie_id;
    RETURN rental_count;
END;
$$
LANGUAGE plpgsql;
