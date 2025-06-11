import math
import time
import sys

"""
Este é um sistema de controle de estoque para um mercado rápido.
O sistema permite o cadastro de produtos, controle de estoque e vendas.
"""

def cadastroUsuarios():
    """
    Função para cadastrar usuários com senha.
    Retorna um dicionário com os usuários e suas respectivas senhas.
    """
    usuarios = {}
    print("=== CADASTRO DE USUÁRIOS ===")
    while True:
        usuario = input("Digite o nome do usuário (ou 'sair' para encerrar): ")
        if usuario.lower() == 'sair':
            break
        senha = input("Digite a senha do usuário: ")
        usuarios[usuario] = senha
        print(f"Usuário '{usuario}' cadastrado com sucesso!")
    return usuarios

def verificarUsuario(usuarios):
    """
    Função para verificar se o usuário e senha estão corretos.
    Permite até 3 tentativas de login apenas para senhas incorretas.
    """
    if not isinstance(usuarios, dict):
        raise ValueError("usuarios deve ser um dicionário")

    if not usuarios:
        print("Nenhum usuário cadastrado. Acesso negado.")
        return False

    tentativas = 3  # Total de tentativas permitidas para senha incorreta
    print("=== LOGIN ===")
    
    while tentativas > 0:
        usuario = input("Digite o nome do usuário: ").strip()
        if not usuario:
            print("Usuário não pode ser vazio")
            continue
            
        # Verifica se o usuário existe
        if usuario not in usuarios:
            print("Usuário não cadastrado. Tente novamente.")
            continue  # Não desconta tentativa
            
        senha = input("Digite a senha do usuário: ").strip()
        if not senha:
            print("Senha não pode ser vazia")
            continue
        
        # Verifica se a senha está correta
        if usuarios[usuario] == senha:
            print("Usuário autenticado com sucesso!")
            return True
        else:
            tentativas -= 1  # Só desconta tentativa para senha errada
            if tentativas > 0:
                print(f"Senha incorreta. Você tem {tentativas} tentativas restantes.")
            else:
                print("Número máximo de tentativas excedido. Acesso negado.")
    
    return False

def entradaProduto():
    produtos = []  # Lista para armazenar os produtos

    while True:
        try:
            codigo = int(input("Digite o código do produto (ou 0 para sair): "))
            
            if codigo == 0:  # Se o código for 0, encerra o loop
                print("Cadastro de produtos finalizado!")
                break
                
            if codigo < 0:  # Se o código for negativo, avisa o usuário
                print("CÓDIGO DE PRODUTO INVÁLIDO")
                continue
                
            # Verifica se o código já existe na lista
            produto_existente = False
            for produto in produtos:
                if produto['codigo'] == codigo:
                    print("CÓDIGO JÁ CADASTRADO!")
                    print(f"Produto já cadastrado: {produto['nome']}")
                    produto_existente = True
                    break
            
            if produto_existente:
                continue
                
        except ValueError:  # exceção caso o usuário digite algo além de números
            print("CÓDIGO DE PRODUTO INVÁLIDO")
            continue

        nome = input("Digite o nome do produto: ").strip()
        if not nome:
            print("NOME DE PRODUTO INVÁLIDO")
            continue
        
        try:
            qntdRecebida = int(input("Informe a quantidade recebida: "))
            if qntdRecebida <= 0:
                print("Quantidade inválida")
                continue
        except ValueError:
            print("Por favor, informe um número válido.")
            continue
        
        try:
            estoque_Min = int(input("Informe a quantidade mínima de estoque recomendada: "))
            if estoque_Min <= 0:
                print("QUANTIDADE MÍNIMA INVÁLIDA!")
                continue
        except ValueError:
            print("Por favor, informe um número válido.")
            continue
        
        try:
            estoque_Max = int(input("Informe a quantidade máxima de estoque permitida: "))
            if estoque_Max <= 0 or estoque_Max < estoque_Min:
                print("QUANTIDADE MÁXIMA INVÁLIDA! (deve ser maior que o mínimo)")
                continue
        except ValueError:
            print("Por favor, informe um número válido.")
            continue
            
        produtos.append({
            "codigo": codigo, 
            "nome": nome, 
            "qntdRecebida": qntdRecebida, 
            "estoque_Min": estoque_Min, 
            "estoque_Max": estoque_Max
        })
        print(f"Produto {nome} cadastrado com sucesso!")

    return produtos

def alertaEstoque(produtos):
    for produto in produtos:
        if produto['qntdRecebida'] < produto['estoque_Min']:
            print(f"ALERTA: O produto {produto['nome']} está abaixo do estoque mínimo recomendado ({produto['estoque_Min']}).")
        elif produto['qntdRecebida'] > produto['estoque_Max']:
            print(f"ALERTA: O produto {produto['nome']} excede o estoque máximo permitido ({produto['estoque_Max']}). Considere ajustar a quantidade recebida.")

def saidaProduto(produtos):
    while True:
        try:
            codigo = int(input("Digite o código do produto para saída (ou 0 para sair): "))
            if codigo == 0:
                print("Saída de produtos encerrada.")
                break

            produto_encontrado = next((p for p in produtos if p['codigo'] == codigo), None)
            if not produto_encontrado:
                print("Produto não encontrado.")
                continue

            qntd_saida = int(input(f"Informe a quantidade a ser retirada do produto {produto_encontrado['nome']}: "))
            if qntd_saida <= 0 or qntd_saida > produto_encontrado['qntdRecebida']:
                print("Quantidade inválida ou maior que a quantidade disponível.")
                continue

            produto_encontrado['qntdRecebida'] -= qntd_saida
            print(f"Saída de {qntd_saida} unidades do produto {produto_encontrado['nome']} realizada com sucesso!")
            
            if produto_encontrado['qntdRecebida'] < produto_encontrado['estoque_Min']:
                print(f"ALERTA: O produto {produto_encontrado['nome']} está abaixo do estoque mínimo recomendado ({produto_encontrado['estoque_Min']}).")
                
        except ValueError:
            print("Entrada inválida. Por favor, insira um número válido.")

def cadastrarPrecos(produtos):
    precos = {}
    for produto in produtos:
        while True:
            try:
                preco = float(input(f"Digite o preço do produto {produto['nome']} (código {produto['codigo']}): R$ "))
                if preco < 0:
                    print("Preço inválido. O preço não pode ser negativo.")
                    continue
                precos[produto['codigo']] = preco
                break
            except ValueError:
                print("Entrada inválida. Por favor, insira um valor numérico válido.")
    return precos

def consultarEstoque(produtos):
    print("\nEstoque de produtos:")
    if not produtos:
        print("Nenhum produto cadastrado no estoque.")
        return
        
    for produto in produtos:
        print(f"Código: {produto['codigo']} | Nome: {produto['nome']} | Quantidade em Estoque: {produto['qntdRecebida']} | Estoque Mínimo: {produto['estoque_Min']} | Estoque Máximo: {produto['estoque_Max']}")

def calcularValorTotalEstoque(produtos, precos):
    valor_total = 0.0
    for produto in produtos:
        codigo = produto['codigo']
        if codigo in precos:
            valor_total += produto['qntdRecebida'] * precos[codigo]
        else:
            print(f"Preço não cadastrado para o produto {produto['nome']} (código {codigo}).")
    return valor_total

# Execução principal
if __name__ == "__main__":
    print("===================================")
    print("ESTOQUE - MERCADO RÁPIDO")
    print("===================================")
    print("Bem-vindo ao sistema de controle de estoque!")
    
    # Autenticação de usuário
    usuarios = cadastroUsuarios()
    
    if not verificarUsuario(usuarios):
        print("Acesso negado. Encerrando sistema.")
        sys.exit()
    
    print("Acesso liberado!")
    
    # Inicialização das variáveis
    lista_produtos = []
    precos = {}

    while True:
        print("\n========================================")
        print("              MENU PRINCIPAL")
        print("========================================")
        print("1 - Entrada de produtos (Recebimento)")
        print("2 - Saída de produtos (Reposição)")
        print("3 - Consultar estoque")
        print("4 - Cadastrar novo produto")
        print("5 - Relatório de produtos em falta")
        print("6 - Relatório completo do estoque")
        print("7 - Cadastrar preços dos produtos")
        print("8 - Calcular valor total do estoque")
        print("9 - Sair do sistema")
        print("========================================")
        
        opcao = input("Escolha uma opção: ").strip()

        if opcao == "1":
            novos_produtos = entradaProduto()
            lista_produtos.extend(novos_produtos)
            if novos_produtos:
                alertaEstoque(lista_produtos)
                
        elif opcao == "2":
            if lista_produtos:
                saidaProduto(lista_produtos)
            else:
                print("Nenhum produto cadastrado.")
                
        elif opcao == "3":
            consultarEstoque(lista_produtos)
            
        elif opcao == "4":
            novos = entrada
            Produto()
            lista_produtos.extend(novos)
                
                
        elif opcao == "5":
            print("\nProdutos em falta:")
            produtos_em_falta = False
            for produto in lista_produtos:
                if produto['qntdRecebida'] < produto['estoque_Min']:
                    print(f"{produto['nome']} (Código: {produto['codigo']}) - Estoque: {produto['qntdRecebida']}")
                    produtos_em_falta = True
            if not produtos_em_falta:
                print("Nenhum produto em falta.")
                
        elif opcao == "6":
            print("\nRelatório completo do estoque:")
            consultarEstoque(lista_produtos)
            
        elif opcao == "7":
            if lista_produtos:
                precos = cadastrarPrecos(lista_produtos)
                print("Preços cadastrados com sucesso!")
            else:
                print("Nenhum produto cadastrado.")
                
        elif opcao == "8":
            if lista_produtos and precos:
                valor_total = calcularValorTotalEstoque(lista_produtos, precos)
                print(f"\nValor total do estoque: R$ {valor_total:.2f}")
            else:
                print("É necessário ter produtos cadastrados e preços definidos.")
                
        elif opcao == "9":
            print("Saindo do sistema. Até logo!")
            break
            
        else:
            print("Opção inválida. Tente novamente.")