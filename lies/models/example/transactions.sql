{{ config(materialized='table', sort='valid_from') }}
WITH licence_transactions AS (
SELECT licence_number,
                           random_date_bounded(valid_from, valid_until)                  AS transaction_date,
                           random_choice(ARRAY ['true', 'false'])                        AS vat_chargable,
                           to_char((RANDOM() * 10) * (RANDOM() * 10) * (RANDOM() * 10), 'FM999999999.00') AS value,
                           0 as pm
                    FROM {{ ref('licences') }} TABLESAMPLE bernoulli(10)
{% for n in range(100) %}
                    UNION ALL
    SELECT licence_number,
                           random_date_bounded(valid_from, valid_until)                  AS transaction_date,
                           random_choice(ARRAY ['true', 'false'])                        AS vat_chargable,
                           to_char((RANDOM() * 10) * (RANDOM() * 10) * (RANDOM() * 10), 'FM999999999.00') AS value,
    {{n}} as pm
                    FROM {{ ref('licences') }} TABLESAMPLE bernoulli(10)
{% endfor %}
)
SELECT *
FROM licence_transactions limit 10000000

