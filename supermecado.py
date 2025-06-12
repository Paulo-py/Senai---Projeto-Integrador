import math
import time
import sys
import os
import getpass

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
        usuario = input("Digite o nome do usuário (digite 'sair' para encerrar cadastro): ")
        if usuario.lower() == 'sair':
            break
        senha = getpass.getpass("Digite a senha do usuário: ")
        if not senha:
            print("Senha não pode ser vazia")
            continue
        # Verifica se a senha é forte o suficiente
        if len(senha) < 8:
            print("Senha fraca! A senha deve ter pelo menos 8 caracteres")
            continue
        usuarios[usuario] = senha
        print(f"Usuário '{usuario}' cadastrado com sucesso!")
    return usuarios

def verificarUsuario(usuarios):
    """
    Função para verificar se o usuário e senha estão corretos.
    Retorna o nome do usuário se autenticado, None caso contrário.
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
            
        if usuario not in usuarios:
            print("Usuário não cadastrado. Tente novamente.")
            continue
            
        senha = getpass.getpass("Digite a senha: ")
    
        if not senha:
            print("Senha não pode ser vazia")
            continue
        
        if usuarios[usuario] == senha:
            print("Usuário autenticado com sucesso!")
            return usuario  # Retorna o nome do usuário
        else:
            tentativas -= 1
            if tentativas > 0:
                print(f"Senha incorreta. Você tem {tentativas} tentativas restantes.")
            else:
                print("Número máximo de tentativas excedido. Acesso negado.")
    
    return None

def entradaProduto():
    produtos = []  # Lista para armazenar os produtos
    precos = {}    # Dicionário para armazenar os preços

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
            preco = float(input(f"Digite o preço do produto {nome}: R$ "))
            if preco < 0:
                print("Preço inválido. O preço não pode ser negativo.")
                continue
        except ValueError:
            print("Por favor, informe um valor numérico válido para o preço.")
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
            "estoque_Max": estoque_Max,
            "preco": preco  # Adicionando preço ao dicionário do produto
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

def calcularValorTotalEstoque(produtos, precos):
    valor_total = 0.0
    for produto in produtos:
        codigo = produto['codigo']
        if codigo in precos:
            valor_total += produto['qntdRecebida'] * precos[codigo]
        else:
            print(f"Preço não cadastrado para o produto {produto['nome']} (código {codigo}).")
    return valor_total

def consultarEstoque(produtos):
    """
    Função para consultar estoque de produtos com detalhes completos.
    Adaptada do código VisuAlg para Python.
    """
    if not produtos:
        print("Nenhum produto cadastrado.")
        return
    
    print()
    print("=== CONSULTA DE ESTOQUE ===")
    print("Produtos disponíveis:")
    
    # Lista todos os produtos disponíveis
    for i, produto in enumerate(produtos, 1):
        print(f"{i} - {produto['nome']} (Estoque: {produto['qntdRecebida']})")
    
    try:
        codigo_produto = int(input(f"Digite o código do produto para consulta detalhada (1-{len(produtos)}): "))
        
        if 1 <= codigo_produto <= len(produtos):
            produto = produtos[codigo_produto - 1]  # Ajuste para índice baseado em 0
            
            print()
            print("DETALHES DO PRODUTO:")
            print(f"Nome: {produto['nome']}")
            print(f"Estoque atual: {produto['qntdRecebida']} unidades")
            print(f"Estoque mínimo: {produto['estoque_Min']} unidades")
            print(f"Capacidade máxima: {produto['estoque_Max']} unidades")
            print(f"Preço unitário: R$ {produto['preco']:.2f}")
            print(f"Valor total em estoque: R$ {(produto['qntdRecebida'] * produto['preco']):.2f}")
            
            # Status do estoque
            if produto['qntdRecebida'] <= produto['estoque_Min']:
                print("Status: CRÍTICO - Estoque baixo!")
            elif produto['qntdRecebida'] >= produto['estoque_Max']:
                print("Status: ATENÇÃO - Estoque no limite!")
            else:
                print("Status: NORMAL")
        else:
            print("Código de produto inválido!")
            
    except ValueError:
        print("Por favor, digite um número válido!")

def relatorioCompleto(produtos, nome_funcionario="Sistema"): #Função para gerar relatório completo do estoque.
    
    if not produtos:
        print("Nenhum produto cadastrado.")
        return
    
    print()
    print("=== RELATÓRIO COMPLETO DO ESTOQUE ===")
    print(f"Funcionário: {nome_funcionario}")
    print(f"Total de produtos cadastrados: {len(produtos)}")
    print()
    
    valor_total_geral = 0
    
    for i, produto in enumerate(produtos, 1):
        valor_produto = produto['qntdRecebida'] * produto['preco']
        valor_total_geral += valor_produto
        
        print(f"Produto {i}: {produto['nome']}")
        print(f"  Estoque: {produto['qntdRecebida']}/{produto['estoque_Max']} (Mín: {produto['estoque_Min']})")
        print(f"  Preço: R$ {produto['preco']:.2f}")
        print(f"  Valor em estoque: R$ {valor_produto:.2f}")
        
        if produto['qntdRecebida'] <= produto['estoque_Min']:
            print("  Status: CRÍTICO")
        else:
            print("  Status: NORMAL")
        print()

# Execução principal
if __name__ == "__main__":
    print("===================================")
    print("ESTOQUE - MERCADO RÁPIDO")
    print("===================================")
    print("Bem-vindo ao sistema de controle de estoque!")
    
    # Autenticação de usuário
    usuarios = cadastroUsuarios()
    usuario_logado = verificarUsuario(usuarios)
    
    if not usuario_logado:
        print("Acesso negado. Encerrando sistema.")
        sys.exit()
    
    print(f"Acesso liberado! Bem-vindo(a), {usuario_logado}!")
    
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
        print("4 - Relatório de produtos em falta")
        print("5 - Relatório completo do estoque")
        print("6 - Calcular valor total do estoque")
        print("7 - Sair do sistema")
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
            print("\nProdutos em falta:")
            produtos_em_falta = False
            for produto in lista_produtos:
                if produto['qntdRecebida'] < produto['estoque_Min']:
                    print(f"{produto['nome']} (Código: {produto['codigo']}) - Estoque: {produto['qntdRecebida']}")
                    produtos_em_falta = True
            if not produtos_em_falta:
                print("Nenhum produto em falta.")
                
        elif opcao == "5":
            print("\nRelatório completo do estoque:")
            relatorioCompleto(lista_produtos, usuario_logado)  # Passa o nome do usuário
            
        elif opcao == "6":
            if lista_produtos:
                valor_total = sum(p['qntdRecebida'] * p['preco'] for p in lista_produtos)
                print(f"\nValor total do estoque: R$ {valor_total:.2f}")
            else:
                print("Nenhum produto cadastrado.")
                
        elif opcao == "7":
            print("Saindo do sistema. Até logo!")
            break
            
        else:
            print("Opção inválida. Tente novamente.")