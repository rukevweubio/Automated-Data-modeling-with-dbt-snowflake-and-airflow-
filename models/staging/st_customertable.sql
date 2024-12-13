{{ config(materialized='table') }}  -- Define materialization as 'table'

select  
    CUSTOMERKEY,
    GENDER,
    split_part(NAME, ' ', 0) AS FIRST_NAME,  
    split_part(NAME, ' ', 1) AS LAST_NAME,   
    "State Code",
    STATE,
    "Zip Code",
    COUNTRY,
    CONTINENT,
    BIRTHDAY,
    CONCAT("Zip Code", ' ', "State Code") AS state_zip_code  

from
    {{ source('my_snowflake_database', 'customer') }}  
