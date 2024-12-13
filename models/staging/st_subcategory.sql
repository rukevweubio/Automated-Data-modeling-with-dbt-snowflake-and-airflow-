{{config(materialized='table')}}

select 
    subcategorykey
    subcategory
from    
    {{ref('productstable')}}