{{
  config(
    tags = ['comercial']
    )
}}

WITH source AS (
    SELECT * FROM {{ source('raw_data', 'product_category_name') }}
), 

normalizacao AS (
    SELECT
        COALESCE(
            INITCAP(product_category_name), 'sem_categoria') AS categoria_produto,
            current_timestamp as etl_data_insercao
    FROM source
)

SELECT 
    categoria_produto,
    etl_data_insercao
FROM normalizacao