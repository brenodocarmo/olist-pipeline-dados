from sqlalchemy import create_engine
from dotenv import load_dotenv
from os import getenv, listdir, path, rename
from time import sleep

import pandas as pd


load_dotenv()

# Variaveis de ambientes
my_password = getenv("MY_PASSWORD_POSTGRES")
my_database = getenv("DATABASE_NAME")
my_user = getenv("USER_NAME")


def create_connection(user_name, user_password, host_name, number_port, db_name):
    """
    Cria a conexão com o banco de dados PostgreSQL
    """
    conexao_postgres = None
    try:
        conexao_postgres = create_engine(
            f"postgresql://{user_name}:{user_password}@{host_name}:{number_port}/{db_name}"
        )
        with conexao_postgres.connect():
            print("Postgres conectado com sucesso", "\n")
    except Exception as e:
        print(f"Deu ruim {e}")

    return conexao_postgres


def rename_file(path_file):
    """
    Altera a nomeclatura da base da Olist

    """

    list_file = []
    for old_file in listdir(path_file):
        if path.isfile(path.join(path_file, old_file)):
            if old_file.startswith("olist"):
                file_change = old_file.replace("olist_", "")
                file_change = file_change.replace("_dataset.csv", ".csv")

                old_name = path.join(path_file, old_file)
                new_name = path.join(path_file, file_change)

                rename(old_name, new_name)

                list_file.append(file_change)

            elif old_file == "product_category_name_translation.csv":
                file_change = old_file.replace("_translation.csv", ".csv")

                old_name = path.join(path_file, old_file)
                new_name = path.join(path_file, file_change)

                rename(old_name, new_name)

                list_file.append(file_change)
    return None


def insert_table(path_file, db_connection):
    """
    Crias as tabelas no banco de dados e realiza a inseção do dados
    """
    for new_file in listdir(path_file):
        if path.isfile(path.join(path_file, new_file)):
            read_file = pd.read_csv(path.join(path_file, new_file))
            file_change = new_file.replace("_dataset.csv", "").replace(".csv", "")

            # print(file_change)
            print(f"Iniciado a a criação da tabela {file_change}")
            read_file.to_sql(
                name=file_change, con=db_connection, index=False, if_exists="replace"
            )

            print(f"Fim da inserção do dados na tabela {file_change}")
            sleep(2)
            print("\n")


dados = create_connection(
    user_name=my_user,
    user_password=my_password,
    host_name="localhost",
    number_port="5437",
    db_name=my_database,
)

path_file = "base_de_dados"
rename_file(path_file=path_file)
# insert_table(path_file=path_file, db_connection=dados)
