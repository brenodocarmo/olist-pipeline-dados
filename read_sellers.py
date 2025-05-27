import pandas as pd
from faker import Faker


# Instaciando a biblioteca
fake = Faker("pt_BR")


def generete_names(amout):
    """
    Gera uma lista de nomes completos aleatórios e distintos, sem prefixos como
    'Dra.', 'Dr.', 'Sr.', 'Sra.' ou 'Srta.'.

    Args:
       amout (int):  Quantidade de nomes que será gerados
    """
    data = {"name": []}

    list_name = set()
    while len(list_name) < amout:
        full_name = fake.unique.name()
        if not full_name.startswith(("Dra.", "Dr.", "Sr.", "Sra.", "Srta.")):
            list_name.add(full_name)
    data["name"] = list(list_name)
    return data


def create_sellers_dataset(path, list_name):
    """
    Cria um novo dataset a partir do arquivo 'olist_sellers_dataset.csv', adicionando a coluna 
    'seller_name' com nomes de vendedores gerados pela função 'generate_names()'.

    Args:
        path (str): Caminho do arquivo dataset
        list_name (list): Conjunto de nomes gerados atraves da função generete_names()
    """

    df = pd.read_csv(path, sep=",")
    full_name = []
    for nomes in list_name:
        for i in list_name[nomes]:
            full_name.append(i)

    # Adicionando uma nova coluna no dataset
    df["seller_name"] = full_name

    # Salvando o arquivo .csv na pasta base_de_dados
    df.to_csv("base_de_dados/new_olist_sellers_dataset.csv", index=False)

    return df


gerar = generete_names(amout=3095)

path = "olist_sellers_dataset.csv"
create_sellers_dataset(path=path, list_name=gerar)
