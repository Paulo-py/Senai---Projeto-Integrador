Algoritmo "teste"
// Disciplina   : [Linguagem e Lógica de Programação]
// Professor   :  Taynan De Padua
// Descrição   : Aqui você descreve o que o programa faz! (função)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 28/05/2025
Var
   // Seção de Declarações das variáveis
   // Arrays para armazenar dados dos produtos (até 10 produtos)
   nomes_produtos: vetor[1..10] de caractere
   qtd_atual: vetor[1..10] de inteiro        // Quantidade atual em estoque
   qtd_minima: vetor[1..10] de inteiro       // Estoque mínimo para alerta
   qtd_maxima: vetor[1..10] de inteiro       // Capacidade máxima do estoque
   precos: vetor[1..10] de real              // Preço unitário dos produtos

   // Variáveis de controle
   total_produtos, opcao, codigo_produto, quantidade, i: inteiro
   nome_funcionario, nome_produto: caractere
   preco_unitario, valor_total: real

Inicio
   // Seção de Comandos, procedimento, funções, operadores, etc...
   // Inicialização do sistema
   total_produtos <- 0

   // Pré-cadastro de alguns produtos para demonstração
   total_produtos <- 5

   nomes_produtos[1] <- "Oleo de Soja 900ml"
   qtd_atual[1] <- 15
   qtd_minima[1] <- 5
   qtd_maxima[1] <- 50
   precos[1] <- 4.50

   nomes_produtos[2] <- "Arroz 5kg"
   qtd_atual[2] <- 8
   qtd_minima[2] <- 3
   qtd_maxima[2] <- 30
   precos[2] <- 18.90

   nomes_produtos[3] <- "Feijao 1kg"
   qtd_atual[3] <- 12
   qtd_minima[3] <- 4
   qtd_maxima[3] <- 25
   precos[3] <- 7.80

   nomes_produtos[4] <- "Leite Integral 1L"
   qtd_atual[4] <- 2
   qtd_minima[4] <- 6
   qtd_maxima[4] <- 40
   precos[4] <- 4.20

   nomes_produtos[5] <- "Açucar 1kg"
   qtd_atual[5] <- 20
   qtd_minima[5] <- 8
   qtd_maxima[5] <- 35
   precos[5] <- 3.90

   escreval("========================================")
   escreval("    SISTEMA DE ESTOQUE - MINIMERCADO")
   escreval("========================================")
   escreval()

   escreva("Digite seu nome (funcionário): ")
   leia(nome_funcionario)
   escreval("Bem-vindo(a), ", nome_funcionario, "!")

   // Verificação inicial de alertas
   escreval()
   escreval("=== VERIFICAÇÃO INICIAL DE ALERTAS ===")
   para i de 1 ate total_produtos faca
      se qtd_atual[i] <= qtd_minima[i] entao
         escreval("??  ALERTA: ", nomes_produtos[i], " - Estoque baixo!")
         escreval("   Atual: ", qtd_atual[i], " | Mínimo: ", qtd_minima[i])
      fimse
   fimpara

   // Menu principal
   repita
      escreval()
      escreval("========================================")
      escreval("              MENU PRINCIPAL")
      escreval("========================================")
      escreval("1 - Entrada de produtos (Recebimento)")
      escreval("2 - Saída de produtos (Reposição)")
      escreval("3 - Consultar estoque")
      escreval("4 - Cadastrar novo produto")
      escreval("5 - Relatório de produtos em falta")
      escreval("6 - Relatório completo do estoque")
      escreval("7 - Calcular valor total do estoque")
      escreval("8 - Sair do sistema")
      escreval("========================================")
      escreva("Escolha uma opção: ")
      leia(opcao)

      escolha opcao
      caso 1  // Entrada de produtos
         escreval()
         escreval("=== ENTRADA DE PRODUTOS ===")
         escreval("Produtos disponíveis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o código do produto (1-", total_produtos, "): ")
         leia(codigo_produto)

         se (codigo_produto >= 1) e (codigo_produto <= total_produtos) entao
            escreva("Quantidade recebida: ")
            leia(quantidade)

            se quantidade > 0 entao
               qtd_atual[codigo_produto] <- qtd_atual[codigo_produto] + quantidade
               escreval("? Entrada registrada com sucesso!")
               escreval("Produto: ", nomes_produtos[codigo_produto])
               escreval("Quantidade adicionada: ", quantidade)
               escreval("Estoque atual: ", qtd_atual[codigo_produto])

               // Verificar se excedeu o máximo
               se qtd_atual[codigo_produto] > qtd_maxima[codigo_produto] entao
                  escreval("??  ATENÇÃO: Estoque acima da capacidade máxima!")
                  escreval("   Atual: ", qtd_atual[codigo_produto], " | Máximo: ", qtd_maxima[codigo_produto])
               fimse
            senao
               escreval("? Quantidade inválida!")
            fimse
         senao
            escreval("? Código de produto inválido!")
         fimse

      caso 2  // Saída de produtos
         escreval()
         escreval("=== SAÍDA DE PRODUTOS ===")
         escreval("Produtos disponíveis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o código do produto (1-", total_produtos, "): ")
         leia(codigo_produto)

         se (codigo_produto >= 1) e (codigo_produto <= total_produtos) entao
            escreva("Quantidade retirada: ")
            leia(quantidade)

            se quantidade > 0 entao
               se quantidade <= qtd_atual[codigo_produto] entao
                  qtd_atual[codigo_produto] <- qtd_atual[codigo_produto] - quantidade
                  escreval("? Saída registrada com sucesso!")
                  escreval("Produto: ", nomes_produtos[codigo_produto])
                  escreval("Quantidade retirada: ", quantidade)
                  escreval("Estoque atual: ", qtd_atual[codigo_produto])

                  // Verificar alerta de estoque baixo
                  se qtd_atual[codigo_produto] <= qtd_minima[codigo_produto] entao
                     escreval("?? ALERTA: ESTOQUE MÍNIMO ATINGIDO!")
                     escreval("   Estoque atual: ", qtd_atual[codigo_produto])
                     escreval("   Estoque mínimo: ", qtd_minima[codigo_produto])
                     escreval("   ??  NECESSÁRIO FAZER PEDIDO!")
                  fimse
               senao
                  escreval("? Quantidade insuficiente no estoque!")
                  escreval("   Disponível: ", qtd_atual[codigo_produto])
               fimse
            senao
               escreval("? Quantidade inválida!")
            fimse
         senao
            escreval("? Código de produto inválido!")
         fimse

      caso 3  // Consultar estoque
         escreval()
         escreval("=== CONSULTA DE ESTOQUE ===")
         escreval("Produtos disponíveis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o código do produto para consulta detalhada (1-", total_produtos, "): ")
         leia(codigo_produto)

         se (codigo_produto >= 1) e (codigo_produto <= total_produtos) entao
            escreval()
            escreval("?? DETALHES DO PRODUTO:")
            escreval("Nome: ", nomes_produtos[codigo_produto])
            escreval("Estoque atual: ", qtd_atual[codigo_produto], " unidades")
            escreval("Estoque mínimo: ", qtd_minima[codigo_produto], " unidades")
            escreval("Capacidade máxima: ", qtd_maxima[codigo_produto], " unidades")
            escreval("Preço unitário: R$ ", precos[codigo_produto]:0:2)
            escreval("Valor total em estoque: R$ ", (qtd_atual[codigo_produto] * precos[codigo_produto]):0:2)

            // Status do estoque
            se qtd_atual[codigo_produto] <= qtd_minima[codigo_produto] entao
               escreval("Status: ?? CRÍTICO - Estoque baixo!")
            senao
               se qtd_atual[codigo_produto] >= qtd_maxima[codigo_produto] entao
                  escreval("Status: ?? ATENÇÃO - Estoque no limite!")
               senao
                  escreval("Status: ?? NORMAL")
               fimse
            fimse
         senao
            escreval("? Código de produto inválido!")
         fimse

      caso 4  // Cadastrar novo produto
         escreval()
         escreval("=== CADASTRO DE NOVO PRODUTO ===")

         se total_produtos < 10 entao
            total_produtos <- total_produtos + 1

            escreva("Nome do produto: ")
            leia(nome_produto)
            nomes_produtos[total_produtos] <- nome_produto

            escreva("Quantidade inicial: ")
            leia(qtd_atual[total_produtos])

            escreva("Estoque mínimo: ")
            leia(qtd_minima[total_produtos])

            escreva("Capacidade máxima: ")
            leia(qtd_maxima[total_produtos])

            escreva("Preço unitário: R$ ")
            leia(precos[total_produtos])

            escreval("? Produto cadastrado com sucesso!")
            escreval("Código atribuído: ", total_produtos)
         senao
            escreval("? Limite de produtos atingido (máximo 10)!")
         fimse

      caso 5  // Relatório de produtos em falta
         escreval()
         escreval("=== PRODUTOS EM FALTA/CRÍTICOS ===")

         para i de 1 ate total_produtos faca
            se qtd_atual[i] <= qtd_minima[i] entao
               escreval("?? ", nomes_produtos[i])
               escreval("   Atual: ", qtd_atual[i], " | Mínimo: ", qtd_minima[i])
               escreval("   Sugestão de compra: ", (qtd_maxima[i] - qtd_atual[i]), " unidades")
               escreval()
            fimse
         fimpara

      caso 6  // Relatório completo
         escreval()
         escreval("=== RELATÓRIO COMPLETO DO ESTOQUE ===")
         escreval("Funcionário: ", nome_funcionario)
         escreval("Total de produtos cadastrados: ", total_produtos)
         escreval()

         para i de 1 ate total_produtos faca
            escreval("Produto ", i, ": ", nomes_produtos[i])
            escreval("  Estoque: ", qtd_atual[i], "/", qtd_maxima[i], " (Mín: ", qtd_minima[i], ")")
            escreval("  Preço: R$ ", precos[i]:0:2)
            escreval("  Valor em estoque: R$ ", (qtd_atual[i] * precos[i]):0:2)

            se qtd_atual[i] <= qtd_minima[i] entao
               escreval("  Status: ?? CRÍTICO")
            senao
               escreval("  Status: ?? NORMAL")
            fimse
            escreval()
         fimpara

      caso 7  // Valor total do estoque
         escreval()
         escreval("=== VALOR TOTAL DO ESTOQUE ===")
         valor_total <- 0

         para i de 1 ate total_produtos faca
            valor_total <- valor_total + (qtd_atual[i] * precos[i])
         fimpara

         escreval("?? Valor total investido em estoque: R$ ", valor_total:0:2)

      caso 8  // Sair
         escreval()
         escreval("Obrigado por usar o Sistema de Estoque!")
         escreval("Até logo, ", nome_funcionario, "!")

      outrocaso
         escreval("? Opção inválida! Tente novamente.")
      fimescolha

   ate opcao = 8

Fimalgoritmo