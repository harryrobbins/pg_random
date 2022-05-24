random 0.0.1
==========

Synopsis
--------

Provides a set of (fairly) performant random functions that you might need including:

* `random_choice` - get a random item back from an array of strings
* `random_timestamp` - get a random timestamp between two timestamps
* `random_numeric` - get a random numeric string of fixed length
* `random_alphanumeric` - get a random string of uppercase letters and numbers of fixed length
* `random_in_range` - get a random int between two ints, or random float between two floats

Most of the functions rely on the underlying postgres `random()` function.

Currently (and possibly always) in early stage of development. It's not designed for cryptography or similar 
applications that require a high degree of randomness. 

It was created to facilitate the creation of fake data within Postgres. e.g. like a postgres-native version of the 
excellent [pg_faker](https://gitlab.com/dalibo/postgresql_faker) library but without the performance overhead of handing
off the functions to python.

Description
-----------

This library contains some helper functions to generate random data in a reasonably performant way.

It can be used for generating fake/synthetic data of for testing.


Usage
-----

    % CREATE EXTENSION random;
    CREATE EXTENSION

    % SELECT random_choice(ARRAY['cow', 'horse', 'sheep']);
        random_choice
    ------------
     sheep

    % SELECT random_timestamp( '1983-08-04'::TIMESTAMP, NOW()::TIMESTAMP);
        random_timestamp
    ------------
     1994-10-28 12:03:42.724724

    % SELECT random_numeric( 18); -- currently cannot be longer than 18
        random_numeric
    ------------
     367617646010025088

    % SELECT  SELECT random_alphanumeric( 65);
        random_alphanumeric
    ------------
     4280C932B4C6BC5553C7DC69967376B23B4E1582DD205720B36B5DC583603BB15

    % SELECT  SELECT random_in_range( 1,100);
        random_in_range
    ------------
     81

    % SELECT  SELECT random_in_range( 1.1,1.9);
        random_in_range
    ------------
     1.3019755756844091

Author
------
[Harry Robbins](https://surprisingly.ltd). Several of the functions were taken from 
[szymon_lipinski's excelent blog on the subject](https://www.simononsoftware.com/generating-random-data-in-postgresql/) 
with the author's permission. One of the functions (random_alphanumeric) was apparently suggested in a comment in that blog by a user called 
Pavel. The comment is no longer available but, as Szymon says, thanks Pavel for suggesting the fastest solution.

Copyright and License
---------------------

Copyright (c) 2010-2022 Surprisingly Ltd.

This module is free software; you can redistribute it and/or modify it under
the [PostgreSQL License](https://www.opensource.org/licenses/postgresql).

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose, without fee, and without a written agreement is
hereby granted, provided that the above copyright notice and this paragraph
and the following two paragraphs appear in all copies.

In no event shall Surprisingly Ltd be liable to any party for direct,
indirect, special, incidental, or consequential damages, including lost
profits, arising out of the use of this software and its documentation, even
if David E. Wheeler has been advised of the possibility of such damage.

Surprisingly Ltd specifically disclaims any warranties, including, but not
limited to, the implied warranties of merchantability and fitness for a
particular purpose. The software provided hereunder is on an "as is" basis,
and Surprisingly Ltd has no obligations to provide maintenance, support,
updates, enhancements, or modifications.
