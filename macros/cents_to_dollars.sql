{% macro cents_to_dollars(field, decimals=2) -%}
      round(1.0*{{ field }}/100,{{ decimals }})
{%- endmacro %}