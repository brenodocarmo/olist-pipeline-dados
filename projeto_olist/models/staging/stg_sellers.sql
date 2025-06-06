{{
  config(
    tags = ['comercial']
    )
}}


WITH source AS (
    SELECT 
        * 
    FROM {{ source('raw_data', 'sellers') }}
),

normalizacao_estado AS (
    SELECT
       seller_id AS id_vendedor,
       INITCAP(seller_name) AS nome_completo, 
       TRIM(INITCAP(lower(seller_city))) AS cidade,
       CASE
            WHEN seller_state = 'AC' THEN 'Acre'
            WHEN seller_state = 'AM' THEN 'Amazonas'
            WHEN seller_state = 'BA' THEN 'Bahia'
            WHEN seller_state = 'CE' THEN 'Ceará'
            WHEN seller_state = 'DF' THEN 'Distrito Federal'
            WHEN seller_state = 'ES' THEN 'Espirito Santos'
            WHEN seller_state = 'GO' THEN 'Goiás'
            WHEN seller_state = 'MA' THEN 'Maranhão'
            WHEN seller_state = 'MG' THEN 'Minas Gerais'
            WHEN seller_state = 'MS' THEN 'Mato Grosso do Sul'
            WHEN seller_state = 'MT' THEN 'Mato Grosso'
            WHEN seller_state = 'PA' THEN 'Pará'
            WHEN seller_state = 'PB' THEN 'Paraiba'
            WHEN seller_state = 'PI' THEN 'Piauí'
            WHEN seller_state = 'PE' THEN 'Pernanbuco'
            WHEN seller_state = 'PR' THEN 'Paraná'
            WHEN seller_state = 'RJ' THEN 'Rio de Janeiro'
            WHEN seller_state = 'RN' THEN 'Rio Grande do Norte'
            WHEN seller_state = 'RO' THEN 'Roraima'
            WHEN seller_state = 'RN' THEN 'Rio Grande do Norte'
            WHEN seller_state = 'RS' THEN 'Rio Grande do Sul'
            WHEN seller_state = 'SC' THEN 'Santa Catarina'
            WHEN seller_state = 'SE' THEN 'Sergipe'
            WHEN seller_state = 'SP' THEN 'São Paulo'
        END AS estado,
            
        seller_state AS uf,
       seller_zip_code_prefix AS cep
    FROM source
),

normalizacao_cidade AS (
    SELECT
        id_vendedor,
        nome_completo,
        CASE
            WHEN cidade IN ('Sp / Sp','Sao  Paulo','Sao Paulo Sp','Sao Paulop','Sao Paulo - Sp', 'Sao Paulo', 'Sp', 'SãO Paulo', 'Sao Paluo', 'Sao Paulo / Sao Paulo') THEN 'São Paulo'
            WHEN cidade IN ('Rio De Janeiro, Rio De Janeiro, Brasil', 'Rio De Janeiro / Rio De Janeiro', 'Rio De Janeiro \Rio De Janeiro') THEN 'Rio De Janeiro'
            WHEN cidade IN ('Ribeirao Preto', 'Robeirao Preto', 'Ribeirao Preto', 'Riberao Preto', 'Ribeirao Preto / Sao Paulo') THEN 'Ribeirão Preto'
            WHEN cidade IN ('Ao Bernardo Do Campo', 'Sbc/Sp', 'Sao Bernardo Do Campo') THEN 'São Bernardo Do Campo'
            WHEN cidade IN ('Sao Jose Do Rio Preto', 'S Jose Do Rio Preto') THEN 'São Jose Do Rio Preto'
            WHEN cidade IN ('Novo Hamburgo, Rio Grande Do Sul, Brasil') THEN 'Novo Hamburgo'
            WHEN cidade IN ('Sao Sebastiao Da Grama/Sp') THEN 'São Sebastiao Da Grama'
            WHEN cidade IN ('Arraial D''Ajuda (Porto Seguro)') THEN 'Porto Seguro'
            WHEN cidade IN ('Vendas@Creditparts.Com.Br', '04482255') THEN estado
            WHEN cidade IN ('Mogi Das Cruzes / Sp') THEN 'Mogi Das Cruzes'
            WHEN cidade IN ('Carapicuiba / Sao Paulo') THEN 'Carapicuiba'
            WHEN cidade IN ('Santo Andre/Sao Paulo') THEN 'Santo Andre'
            WHEN cidade IN ('Barbacena/ Minas Gerais') THEN 'Barbacena'
            WHEN cidade IN ('Angra Dos Reis Rj') THEN 'Angra Dos Reis'
            WHEN cidade IN ('Aguas Claras Df') THEN 'Aguas Claras'
            WHEN cidade IN ('Jacarei / Sao Paulo') THEN 'Jacarei'
            WHEN cidade IN ('Cariacica / Es') THEN 'Cariacica'
            WHEN cidade IN ('Sao Goncalo') THEN 'São Gonçalo'
            WHEN cidade IN ('Brasilia Df') THEN 'Brasilia'
            WHEN cidade IN ('Maua/Sao Paulo') THEN 'Maua'
            WHEN cidade IN ('Pinhais/Pr') THEN 'Pinhais'
            WHEN cidade IN ('Lages - Sc') THEN 'Lages'
            WHEN cidade IN ('Andira-Pr') THEN 'Andira'
            ELSE cidade
        END AS cidade,
        estado,
        uf,
        cep
    FROM normalizacao_estado

)

SELECT
    id_vendedor,
    nome_completo,
    cidade,
    uf,
    cep
FROM normalizacao_cidade