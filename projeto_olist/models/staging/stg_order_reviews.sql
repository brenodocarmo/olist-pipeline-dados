{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'order_reviews') }}
),

nomalizacao AS (
    SELECT
        order_id AS id_pedido,
        review_id AS id_avaliacao,
        COALESCE(review_score, 0) AS nota_avaliacao,
        COALESCE(review_comment_title, 'sem avaliacao') AS titulo_avaliacao,
        COALESCE(DATE(review_creation_date), DATE('1902-01-01')) AS data_avaliacao,
        COALESCE(review_comment_message, 'sem comentario') AS comentario,
        COALESCE(DATE(review_answer_timestamp), DATE('1902-01-01')) AS data_resposta_avaliacao,
        current_timestamp as etl_data_insercao
    FROM source
)


SELECT 
    id_pedido,
    id_avaliacao,
    nota_avaliacao,
    titulo_avaliacao,
    data_avaliacao,
    comentario,
    data_resposta_avaliacao,
    etl_data_insercao

FROM nomalizacao