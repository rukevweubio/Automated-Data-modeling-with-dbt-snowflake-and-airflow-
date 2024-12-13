{{config(materialized='table')}}

SELECT 
    PRODUCTKEY,
    PRODUCTNAME,
    BRAND,
    COLOR,
    TRY_CAST(REPLACE(REPLACE(UNITCOSTUSD, '$', ''), ',', '') AS FLOAT) AS UNITCOSTUSD,
    TRY_CAST(REPLACE(REPLACE(UNITPRICEUSD, '$', ''), ',', '') AS FLOAT) AS UNITPRICEUSD,
   
    SUBCATEGORYKEY,
    CATEGORYKEY
   

    FROM {{ source('my_snowflake_database', 'products') }}