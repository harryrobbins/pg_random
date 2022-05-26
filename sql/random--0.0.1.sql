SET client_min_messages = warning;

--Get a random datetime between two datetimes
CREATE OR REPLACE FUNCTION random_timestamp(from_time TIMESTAMP, to_time TIMESTAMP)
    RETURNS TIMESTAMP
    LANGUAGE sql
AS
$$

SELECT TO_TIMESTAMP(EXTRACT(EPOCH FROM from_time) +
                    RANDOM() * (EXTRACT(EPOCH FROM (to_time - from_time)))::INT) AT TIME ZONE 'UTC'
$$;

-- Get a random item from a set of options
CREATE OR REPLACE FUNCTION random_choice(options TEXT[])
    RETURNS TEXT
    LANGUAGE SQL
AS
$$
SELECT options[CEIL(RANDOM() * ARRAY_LENGTH(options, 1))]
$$;


--get a random string of numerals of fixed length
CREATE OR REPLACE FUNCTION  random_numeric(int_length integer) RETURNS text
    LANGUAGE sql
AS
$$
SELECT TO_CHAR(((RANDOM()) * POWER(10, int_length))::BIGINT, CONCAT('FM', REPEAT('0', int_length)))
$$;

CREATE OR REPLACE FUNCTION random_alpha(
         string_length integer,
         characters TEXT DEFAULT '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    ) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    output TEXT = '';
    i INT4;
BEGIN
    FOR i IN 1..string_length LOOP
        output := output || substr(possible_chars, 1 + (random() * ( length(characters) - 1))::int4, 1);
    END LOOP;
    RETURN output;
END;
$$;






--Get a random string of uppercase letters and numbers
CREATE OR REPLACE FUNCTION random_alphanumeric(INTEGER)
    RETURNS TEXT
    LANGUAGE SQL
AS
$$
    --FROM https://www.simononsoftware.com/random-string-in-postgresql/#combined-md5-and-sql
SELECT UPPER(
               SUBSTRING(
                       (SELECT STRING_AGG(MD5(RANDOM()::TEXT), '')
                        FROM GENERATE_SERIES(
                                1,
                                CEIL($1 / 32.)::integer)), 1, $1));
$$;

-- FROM https://www.simononsoftware.com/generating-random-data-in-postgresql/#generating-random-integer-in-a-range
CREATE OR REPLACE FUNCTION
random_in_range(INTEGER, INTEGER) RETURNS INTEGER
AS $$
    SELECT floor(($1 + ($2 - $1 + 1) * random()))::INTEGER;
$$ LANGUAGE SQL;


-- https://www.simononsoftware.com/generating-random-data-in-postgresql/#generating-random-floating-point-within-range
CREATE FUNCTION random_in_range(
  DOUBLE PRECISION,
  DOUBLE PRECISION
)
RETURNS DOUBLE PRECISION
LANGUAGE SQL
AS $$
    SELECT greatest($1, least($2, $1 + ($2 - $1) * random()));
$$;