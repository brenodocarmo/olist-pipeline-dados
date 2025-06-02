# Pipeline de Dados - OLIST



### 🚀 Inicio

Esse é um projeto de engenharia de dados que processa informações de e-commerce da base Olist, simulando um pipeline de ERP em um ambiente local. Este projeto implementa a **arquitetura medalhão** (bronze, silver, gold) para organizar e transformar dados brutos em KPIs úteis para análises de negócio.

Desenvolvido com **Python(pandas)** para ingestão de dados e **Dbt** para transformações, o pipeline utiliza **PostgreSQL** como banco de dados local, refletindo fluxos reais de ETL inspirados na minha experiência com pipelines. O projeto demonstra habilidades em ingestão, limpeza, consolidação e agregação de dados, além de práticas modernas de engenharia de dados.

### Sobre o conjunto de dados

Este é um conjunto de dados públicos de e-commerce brasileiro com pedidos feitos na **Olist Store** . O conjunto de dados contém informações de 100 mil pedidos de 2016 a 2018, feitos em diversos marketplaces no Brasil. Seus recursos permitem visualizar um pedido sob diversas dimensões: desde o status do pedido, preço, pagamento e desempenho do frete até a localização do cliente, atributos do produto e, por fim, avaliações escritas por clientes.

### Esquema de Dados

Os dados são divididos em vários conjuntos de dados para melhor compreensão e organização. Consulte o seguinte esquema de dados ao trabalhar com eles:

![Diagrama da base de dados da Olist](diagrama_olist.png)




### *Tecnologias*
- **Python(pandas)**: Ingestão de dados do schema public para a camada bronze.
- **dbt**: Transformações e modelagem de dados (camadas prata e ouro).
- **PostgreSQL**: Banco de dados local para todas as camadas.
- **Git**: Versionamento do código e documentação.
- **Docker**: Para hospedar a instância do postgres


### ✒️ Autor


* **Desenvolvedor** - [Breno do Carmo](https://www.linkedin.com/in/breno-do-carmo/)

### README em contrução


