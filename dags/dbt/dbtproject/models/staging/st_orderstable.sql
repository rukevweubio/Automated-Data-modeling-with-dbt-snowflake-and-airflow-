{{ config(materialized='table') }} 
select
    ORDERNUMBER,
    LINEITEM,
    ORDERDATE,
    DELIVERYDATE,
    CUSTOMERKEY,
    STOREKEY,
    PRODUCTKEY,
    QUANTITY,
    CURRENCYCODE
from 
    {{source('my_snowflake_database', 'orders')}}