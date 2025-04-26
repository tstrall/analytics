with source as (

    select * from {{ source('raw', 'orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        order_date,
        order_total
    from source

)

select * from renamed
