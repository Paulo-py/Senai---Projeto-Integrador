import math
import time

print("===================================")
print("ESTOQUE - MERCADO RÁPIDO")
print("===================================")


def entradaProduto(): #função para entrada de produtos no recebimento
    while codigoProduto != 0:
        codigoProduto = int(print(input(f"Digite o código do produto: ")))
        nomeProdutos = str(input("Digite o nome do produto: "))
    
