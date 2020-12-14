with orders as (

    select * from {{ ref('stg_orders')}}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_payment as (
    select 
        orders.order_id as order_id,
        orders.customer_id as customer_id,
        sum(case when orders.status = 'success' then payments.amount end) as amount
    from orders inner join payments on orders.order_id = payments.order_id
    group by orders.order_id,orders.customer_id
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payment.amount, 0) as amount

    from orders
    left join order_payment using (order_id)
)

select * from final where order_date is null