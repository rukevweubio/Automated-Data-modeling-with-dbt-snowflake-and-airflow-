{{ config(materialized='table') }}

with mart_product_table as (
    select
        p.productkey,
        p.productname,
        p.brand,
        p.color,
        p.unitcostusd,
        p.unitpriceusd,
        p.categorykey,
        p.subcategorykey,
        p.customerkey,
        p.storekey,
        p.totalsprice,
        p.totalcost,
        p.totalrevenue,
        c.ordernumber,
        c.lineitem,
        c.day_name,
        c.month_name,
        c.delivery_day,
        c.delivery_month,
        c.quantity
    from 
        {{ ref('mart_products_orders') }} p
    left join
        {{ ref('mart_customer_orders') }} c
    on 
        p.productkey = c.productkey 
        and p.customerkey = c.customerkey
)

select 
    row_number() OVER (ORDER BY productkey DESC) AS fact_id,
    productkey,
    productname,
    brand,
    color,
    unitcostusd,
    unitpriceusd,
    categorykey,
    subcategorykey,
    customerkey,
    storekey,
    totalsprice,
    totalcost,
    totalrevenue,
    ordernumber,
    lineitem,
    day_name,
    month_name,
    delivery_day,
    delivery_month,
    quantity
from 
    mart_product_table
