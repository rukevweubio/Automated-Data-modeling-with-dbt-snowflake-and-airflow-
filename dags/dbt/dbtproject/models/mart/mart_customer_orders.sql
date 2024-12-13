{{ config(materialized='table') }}

with customer_table as (
    select
        c.*, 
        o.ORDERNUMBER,
        o.LINEITEM,
        o.ORDERDATE,
        o.DELIVERYDATE,
        o.CUSTOMERKEY AS o_customerkey, -- Alias to avoid ambiguity
        o.STOREKEY,
        o.PRODUCTKEY,
        o.QUANTITY
    from
        {{ ref('st_customertable') }} c
    right join  
        {{ ref('orderstable') }} o
    on  
        c.customerkey = o.customerkey
)
select 
    ORDERNUMBER,
    LINEITEM,
    TO_CHAR(ORDERDATE, 'Day') AS day_name,
    TO_CHAR(ORDERDATE, 'Month') AS month_name,
    TO_CHAR(DELIVERYDATE, 'Day') AS delivery_day,
    TO_CHAR(DELIVERYDATE, 'Month') AS delivery_month,
    o_customerkey AS CUSTOMERKEY, -- Ensure the correct alias is used
    STOREKEY,
    PRODUCTKEY,
    QUANTITY,
    GENDER,
    FIRST_NAME,  
    LAST_NAME,   
    "State Code", 
    STATE,
    "Zip Code",   
    COUNTRY,
    CONTINENT,
    BIRTHDAY,
    state_zip_code
from 
    customer_table
