{{config(materialized='table')}}
select  
    categorykey,
    category
    from 
        {{ref('productstable')}}