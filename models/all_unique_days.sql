{{ config (
    materialized="table"
)}}

select 
    {{ dbt_utils.surrogate_key(['DATE_DAY']) }} as DATE_KEY,
    DATE_DAY
from {{ ref('all_dates') }}