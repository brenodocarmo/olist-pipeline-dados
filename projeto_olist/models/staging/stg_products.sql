{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'products') }}
),

normalizacao AS (
    SELECT
        product_id AS id_produto,
        COALESCE(product_category_name, 'sem_categoria') AS categoria_produto,
        COALESCE(product_name_lenght, 0) AS tamanho_nome,
        COALESCE(product_description_lenght, 0) AS tamanho_descricao,        
        COALESCE(product_photos_qty, 0) AS qtde_fotos,
        COALESCE(product_weight_g, 0) AS peso_gramas,
        COALESCE(product_width_cm, 0) AS largura_cm,
        COALESCE(product_height_cm, 0) AS altura_cm,
        COALESCE(product_length_cm, 0) AS comprimento_cm

    FROM source
)


SELECT 
    id_produto,
    categoria_produto,
    tamanho_nome,
    tamanho_descricao,
    qtde_fotos,
    peso_gramas,
    largura_cm,
    altura_cm,
    comprimento_cm

FROM normalizacao