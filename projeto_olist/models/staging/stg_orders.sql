{{
  config(
    tags = ['comercial']
    )
}}



WITH source AS (
    SELECT * FROM {{ source('raw_data', 'orders') }}
),

transformado AS (
    SELECT

        order_id AS id_pedido,
        customer_id AS id_parceiro,
        
        CASE
            WHEN order_status = 'approved' THEN 'Pedido Aprovado'
            WHEN order_status = 'canceled' THEN 'Pedido Cancelado'
            WHEN order_status = 'created' THEN 'Pedido Criado'
            WHEN order_status = 'delivered' THEN 'Pedido Entregue'
            WHEN order_status = 'invoiced' THEN 'Pedido Faturado'
            WHEN order_status = 'processing' THEN 'Pedido Em Processamento'
            WHEN order_status = 'shipped' THEN 'Pedido Em Processamento'
            WHEN order_status = 'unavailable' THEN 'Pedido Indisponivel'
        END AS situ_pedido,
        
        DATE(order_purchase_timestamp) AS data_compra,
        COALESCE(DATE(order_approved_at)) AS pedido_aprovado_em,
        COALESCE(DATE(order_delivered_carrier_date), '1902-01-01') AS data_entrega_transportadora,
        COALESCE(DATE(order_delivered_customer_date), '1902-01-01') AS data_entrega_parceiro,
        COALESCE(DATE(order_estimated_delivery_date), '1902-01-01') AS data_estimada_entrega,
        current_timestamp as etl_data_insercao

    FROM source
)

SELECT
    id_pedido,
    id_parceiro,
    situ_pedido,
    data_compra,
    pedido_aprovado_em,
    data_entrega_transportadora,
    data_entrega_parceiro,
    data_estimada_entrega,
    etl_data_insercao
FROM transformado