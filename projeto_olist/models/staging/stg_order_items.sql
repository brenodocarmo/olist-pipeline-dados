{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'order_items') }}
),

nomalizacao AS (
    SELECT
        order_id AS id_pedido, 
        order_item_id AS num_sequencial_item, 
        product_id AS id_produto, 
        seller_id AS id_vendedor, 
        DATE(shipping_limit_date) AS data_limite_envio, 
        price AS preco, 
        freight_value AS valor_frete,
        current_timestamp as etl_data_insercao
    FROM source
)
SELECT
    id_pedido,
    num_sequencial_item,
    id_produto,
    id_vendedor,
    data_limite_envio,
    preco, 
    valor_frete,
    current_timestamp as etl_data_insercao  

FROM nomalizacao