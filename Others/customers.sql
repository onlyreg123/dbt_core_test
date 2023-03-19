with customer as (
    select 
        id as customer_id,
        first_name,
        last_name
    from `dbt-tutorial`.jaffle_shop.customers
),

orders as (
    select
        o.id as order_id,
        o.user_id as customer_id,
        o.order_date,
        o.status
    from `dbt-tutorial`.jaffle_shop.orders as o
),

customers_orders as (
    select 
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_date) as number_of_date,
    from orders
    group  by 1
)

select 
    c.id,
    c.first_name,
    c.last_name,
    first_order_date,
    most_recent_order_date,
    number_of_date
from 
    customer c
    INNER JOIN customers_orders o ON c.customer_id = o.customer_id;

