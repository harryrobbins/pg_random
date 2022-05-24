ALTER EXTENSION random ADD FUNCTION random_timestamp(timestamp, timestamp);
ALTER EXTENSION random ADD FUNCTION parandom_choice(text[]);
ALTER EXTENSION random ADD FUNCTION random_numeric(int);
ALTER EXTENSION random ADD FUNCTION random_alpha(int);
ALTER EXTENSION random ADD FUNCTION random_alphanumeric(int);
ALTER EXTENSION random ADD FUNCTION random_in_range(int, int);
ALTER EXTENSION random ADD FUNCTION random_in_range(double precision, double precision);
