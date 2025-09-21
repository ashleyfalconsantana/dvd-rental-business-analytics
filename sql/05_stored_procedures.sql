-- Stored procedure to refresh all data in both tables
CREATE PROCEDURE refresh_data()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Clear existing data
    DELETE FROM detailed_table;
    DELETE FROM summary_table;
    
    -- Repopulate detailed table with fresh data
    INSERT INTO detailed_table(film_id, title, genre, popularity, description, release_year)
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
END;
$$;

-- Execute the refresh procedure
-- CALL refresh_data();
