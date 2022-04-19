--Get a random datetime between two datetimes
CREATE OR REPLACE FUNCTION random_date_bounded(from_time TIMESTAMP, to_time TIMESTAMP)
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
CREATE OR REPLACE FUNCTION rand_numeric(int_length int)
    RETURNS TEXT
    LANGUAGE SQL
AS
$$
SELECT TO_CHAR(((RANDOM()) * POWER(10, int_length))::INT, CONCAT('FM', REPEAT('0', int_length)))
$$;

--Get a random string of uppercase letters and numbers
CREATE OR REPLACE FUNCTION alphanumeric(INTEGER)
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