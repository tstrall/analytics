select
    order_id,
    customer_id,
    order_date,
    order_total
from {{ ref('stg_orders') }}
