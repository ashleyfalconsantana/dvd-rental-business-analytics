-- Create detailed table for comprehensive film analysis
CREATE TABLE detailed_table(
    film_id INTEGER,
    title VARCHAR(50),
    genre VARCHAR(25),
    popularity INTEGER,
    description TEXT,
    release_year INTEGER
);

-- Create summary table for high-level business metrics
CREATE TABLE summary_table(
    film_id INTEGER,
    title VARCHAR(50),
    popularity INTEGER,
    avg_amount NUMERIC(5,2)
);

-- Verification queries
SELECT * FROM detailed_table;
SELECT * FROM summary_table;
SELECT COUNT(*) FROM detailed_table;
SELECT COUNT(*) FROM summary_table;
