{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT * FROM {{ source('raw_data', 'customers') }}
),

nomalizacao_estados AS (
    SELECT
        customer_id AS id_parceiro,
        TRIM(INITCAP(lower(customer_city))) cidade,

        CASE
            WHEN customer_state = 'AC' THEN 'Acre'
            WHEN customer_state = 'AM' THEN 'Amazonas'
            WHEN customer_state = 'BA' THEN 'Bahia'
            WHEN customer_state = 'CE' THEN 'Ceará'
            WHEN customer_state = 'DF' THEN 'Distrito Federal'
            WHEN customer_state = 'ES' THEN 'Espirito Santos'
            WHEN customer_state = 'GO' THEN 'Goiás'
            WHEN customer_state = 'MA' THEN 'Maranhão'
            WHEN customer_state = 'MG' THEN 'Minas Gerais'
            WHEN customer_state = 'MS' THEN 'Mato Grosso do Sul'
            WHEN customer_state = 'MT' THEN 'Mato Grosso'
            WHEN customer_state = 'PA' THEN 'Pará'
            WHEN customer_state = 'PB' THEN 'Paraiba'
            WHEN customer_state = 'PI' THEN 'Piauí'
            WHEN customer_state = 'PE' THEN 'Pernanbuco'
            WHEN customer_state = 'PR' THEN 'Paraná'
            WHEN customer_state = 'RJ' THEN 'Rio de Janeiro'
            WHEN customer_state = 'RN' THEN 'Rio Grande do Norte'
            WHEN customer_state = 'RO' THEN 'Roraima'
            WHEN customer_state = 'RN' THEN 'Rio Grande do Norte'
            WHEN customer_state = 'RS' THEN 'Rio Grande do Sul'
            WHEN customer_state = 'SC' THEN 'Santa Catarina'
            WHEN customer_state = 'SE' THEN 'Sergipe'
            WHEN customer_state = 'SP' THEN 'São Paulo'
        END AS estado,
        customer_state AS uf,
        customer_unique_id AS id_unico_parceiro,
        customer_zip_code_prefix AS prefixo_cep
    FROM source
)

SELECT
    id_parceiro,
    id_unico_parceiro
    cidade,
    estado,
    uf,
    prefixo_cep
FROM nomalizacao_estados