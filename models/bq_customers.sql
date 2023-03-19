{{ config(materialized='table') }}

with accounts as (
    select 
        accountId,
        birthdate,
        country,
    from tous_curated.view_360_account
    where date(_PARTITIONTIME) = current_date()
),

kpis as (
    select
        accountId,
        AVT,
        annualAmount,
        lastPurchaseDate,
    from tous_curated.view_360_kpis
    where date(_PARTITIONTIME) = current_date()
),

customers_kpis as (
    select 
        a.accountId,
        a.birthdate,
        a.country,
        k.AVT,
        k.annualAmount,
        k.lastPurchaseDate,
    from accounts a INNER JOIN kpis k ON a.accountId = k.accountId
)

select 
    *
from 
    customers_kpis

