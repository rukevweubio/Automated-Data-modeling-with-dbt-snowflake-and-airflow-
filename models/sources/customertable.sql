 SELECT *
FROM {{ source('my_snowflake_database', 'customer') }}