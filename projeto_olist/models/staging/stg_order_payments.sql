{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'order_payments') }}
),

nomalizacao AS (
    SELECT
        order_id AS id_pedido,
        CASE
            WHEN payment_type = 'credit_card' THEN 'cartao de credito' 
            WHEN payment_type = 'debit_card' THEN 'cartao de debito' 
            WHEN payment_type = 'not_defined' THEN 'indefinido' 
            else payment_type
        END AS tipo_pagamento,
        payment_value AS valor_pagamento,
        payment_sequential AS sequencial_pagamento,
        payment_installments AS qtde_parcelas,
        current_timestamp as etl_data_insercao
    FROM source
)


SELECT
    id_pedido,
    tipo_pagamento,
    valor_pagamento,
    sequencial_pagamento,
    qtde_parcelas,
    etl_data_insercao

FROM nomalizacao