{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'geolocation') }}
),

nomalizacao AS (
    SELECT 
        geolocation_lat AS latitude,
        geolocation_lng AS longitude,
        INITCAP(LOWER(geolocation_city)) AS cidade,
        geolocation_state AS estado,
        geolocation_zip_code_prefix AS prefixo_cep,
        current_timestamp as etl_data_insercao
    FROM source
)

SELECT 
    cidade,
    estado,
    latitude,
    longitude,
    prefixo_cep,
    etl_data_insercao

FROM nomalizacao

