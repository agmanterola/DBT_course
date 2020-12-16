{% set payment_methods=['credit_card','coupon','bank_transfer','gift_card'] %}

with payments as (
    select * from {{ ref('stg_payments') }}
),



pivoted as (
select order_id,
        {%- for pm in payment_methods -%}
        sum (case when PAYMENT_METHOD = '{{ pm }}' then amount else 0 end) as {{ pm }}_amount
        {%- if not loop.last -%}
        ,
        {% endif -%}
        {%- endfor %}
        from payments
        where status='success'
        group by order_id
)

select * from pivoted

