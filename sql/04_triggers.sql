-- Trigger function to automatically update summary table
CREATE OR REPLACE FUNCTION my_trigger_function()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Only insert if film doesn't already exist in summary table
    IF NOT EXISTS (
        SELECT *
        FROM summary_table
        WHERE film_id = NEW.film_id
    ) THEN
        INSERT INTO summary_table(film_id, title, popularity, avg_amount)
        SELECT DISTINCT 
            film.film_id, 
            title, 
            rent_count(film.film_id) AS popularity,
            AVG(payment.amount) AS avg_amount
        FROM film
        JOIN inventory ON film.film_id = inventory.film_id
        JOIN rental ON inventory.inventory_id = rental.inventory_id
        JOIN payment ON rental.customer_id = payment.customer_id
        WHERE film.film_id = NEW.film_id
        GROUP BY film.film_id, title
        ORDER BY popularity ASC;
    END IF;
    RETURN NEW;
END;
$$;

-- Create trigger to execute function after insert on detailed_table
CREATE TRIGGER my_trigger
    AFTER INSERT
    ON detailed_table
    FOR EACH ROW
    EXECUTE PROCEDURE my_trigger_function();
