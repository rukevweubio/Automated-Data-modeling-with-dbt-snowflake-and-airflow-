{{ config(materialized='table') }}

with product as (
    select 
        o.ORDERNUMBER,
        o.LINEITEM,
        o.CUSTOMERKEY,
        o.STOREKEY,
        o.PRODUCTKEY,
        o.QUANTITY,
        p.PRODUCTNAME,
        p.BRAND,
        p.COLOR,
        p.UNITCOSTUSD,
        p.UNITPRICEUSD,
        p.SUBCATEGORYKEY,
        p.CATEGORYKEY
    from    
        {{ ref('st_orderstable') }} o
    left join  
        {{ ref('st_productstable') }} p
        on o.productkey = p.productkey
)

select  
    PRODUCTKEY,
    PRODUCTNAME,
    BRAND,
    COLOR,
    UNITCOSTUSD,
    UNITPRICEUSD,
    SUBCATEGORYKEY,
    CATEGORYKEY,
    ORDERNUMBER,
    LINEITEM,
    CUSTOMERKEY,
    STOREKEY,
    sum(QUANTITY * UNITPRICEUSD) as totalsprice,
    sum(QUANTITY * UNITCOSTUSD) as totalcost,
    sum(QUANTITY * UNITPRICEUSD) - sum(QUANTITY * UNITCOSTUSD) as totalrevenue
from 
    product
group by
    PRODUCTKEY,
    PRODUCTNAME,
    BRAND,
    COLOR,
    UNITCOSTUSD,
    UNITPRICEUSD,
    SUBCATEGORYKEY,
    CATEGORYKEY,
    ORDERNUMBER,
    LINEITEM,
    CUSTOMERKEY,
    STOREKEY
