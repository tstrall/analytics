with customer_orders as (

    select
        customer_id,
        count(order_id) as total_orders,
        sum(order_total) as total_revenue,
        avg(order_total) as average_order_value
    from {{ ref('stg_orders') }}
    group by customer_id

)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.created_at,
    co.total_orders,
    co.total_revenue,
    co.average_order_value
from {{ ref('stg_customers') }} c
left join customer_orders co
    on c.customer_id = co.customer_id
