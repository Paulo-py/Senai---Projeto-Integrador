Algoritmo "teste"
// Disciplina   : [Linguagem e L�gica de Programa��o]
// Professor   :  Taynan De Padua
// Descri��o   : Aqui voc� descreve o que o programa faz! (fun��o)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 28/05/2025
Var
   // Se��o de Declara��es das vari�veis
   // Arrays para armazenar dados dos produtos (at� 10 produtos)
   nomes_produtos: vetor[1..10] de caractere
   qtd_atual: vetor[1..10] de inteiro        // Quantidade atual em estoque
   qtd_minima: vetor[1..10] de inteiro       // Estoque m�nimo para alerta
   qtd_maxima: vetor[1..10] de inteiro       // Capacidade m�xima do estoque
   precos: vetor[1..10] de real              // Pre�o unit�rio dos produtos

   // Vari�veis de controle
   total_produtos, opcao, codigo_produto, quantidade, i: inteiro
   nome_funcionario, nome_produto: caractere
   preco_unitario, valor_total: real

Inicio
   // Se��o de Comandos, procedimento, fun��es, operadores, etc...
   // Inicializa��o do sistema
   total_produtos <- 0

   // Pr�-cadastro de alguns produtos para demonstra��o
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

   nomes_produtos[5] <- "A�ucar 1kg"
   qtd_atual[5] <- 20
   qtd_minima[5] <- 8
   qtd_maxima[5] <- 35
   precos[5] <- 3.90

   escreval("========================================")
   escreval("    SISTEMA DE ESTOQUE - MINIMERCADO")
   escreval("========================================")
   escreval()

   escreva("Digite seu nome (funcion�rio): ")
   leia(nome_funcionario)
   escreval("Bem-vindo(a), ", nome_funcionario, "!")

   // Verifica��o inicial de alertas
   escreval()
   escreval("=== VERIFICA��O INICIAL DE ALERTAS ===")
   para i de 1 ate total_produtos faca
      se qtd_atual[i] <= qtd_minima[i] entao
         escreval("??  ALERTA: ", nomes_produtos[i], " - Estoque baixo!")
         escreval("   Atual: ", qtd_atual[i], " | M�nimo: ", qtd_minima[i])
      fimse
   fimpara

   // Menu principal
   repita
      escreval()
      escreval("========================================")
      escreval("              MENU PRINCIPAL")
      escreval("========================================")
      escreval("1 - Entrada de produtos (Recebimento)")
      escreval("2 - Sa�da de produtos (Reposi��o)")
      escreval("3 - Consultar estoque")
      escreval("4 - Cadastrar novo produto")
      escreval("5 - Relat�rio de produtos em falta")
      escreval("6 - Relat�rio completo do estoque")
      escreval("7 - Calcular valor total do estoque")
      escreval("8 - Sair do sistema")
      escreval("========================================")
      escreva("Escolha uma op��o: ")
      leia(opcao)

      escolha opcao
      caso 1  // Entrada de produtos
         escreval()
         escreval("=== ENTRADA DE PRODUTOS ===")
         escreval("Produtos dispon�veis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o c�digo do produto (1-", total_produtos, "): ")
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

               // Verificar se excedeu o m�ximo
               se qtd_atual[codigo_produto] > qtd_maxima[codigo_produto] entao
                  escreval("??  ATEN��O: Estoque acima da capacidade m�xima!")
                  escreval("   Atual: ", qtd_atual[codigo_produto], " | M�ximo: ", qtd_maxima[codigo_produto])
               fimse
            senao
               escreval("? Quantidade inv�lida!")
            fimse
         senao
            escreval("? C�digo de produto inv�lido!")
         fimse

      caso 2  // Sa�da de produtos
         escreval()
         escreval("=== SA�DA DE PRODUTOS ===")
         escreval("Produtos dispon�veis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o c�digo do produto (1-", total_produtos, "): ")
         leia(codigo_produto)

         se (codigo_produto >= 1) e (codigo_produto <= total_produtos) entao
            escreva("Quantidade retirada: ")
            leia(quantidade)

            se quantidade > 0 entao
               se quantidade <= qtd_atual[codigo_produto] entao
                  qtd_atual[codigo_produto] <- qtd_atual[codigo_produto] - quantidade
                  escreval("? Sa�da registrada com sucesso!")
                  escreval("Produto: ", nomes_produtos[codigo_produto])
                  escreval("Quantidade retirada: ", quantidade)
                  escreval("Estoque atual: ", qtd_atual[codigo_produto])

                  // Verificar alerta de estoque baixo
                  se qtd_atual[codigo_produto] <= qtd_minima[codigo_produto] entao
                     escreval("?? ALERTA: ESTOQUE M�NIMO ATINGIDO!")
                     escreval("   Estoque atual: ", qtd_atual[codigo_produto])
                     escreval("   Estoque m�nimo: ", qtd_minima[codigo_produto])
                     escreval("   ??  NECESS�RIO FAZER PEDIDO!")
                  fimse
               senao
                  escreval("? Quantidade insuficiente no estoque!")
                  escreval("   Dispon�vel: ", qtd_atual[codigo_produto])
               fimse
            senao
               escreval("? Quantidade inv�lida!")
            fimse
         senao
            escreval("? C�digo de produto inv�lido!")
         fimse

      caso 3  // Consultar estoque
         escreval()
         escreval("=== CONSULTA DE ESTOQUE ===")
         escreval("Produtos dispon�veis:")
         para i de 1 ate total_produtos faca
            escreval(i, " - ", nomes_produtos[i], " (Estoque: ", qtd_atual[i], ")")
         fimpara

         escreva("Digite o c�digo do produto para consulta detalhada (1-", total_produtos, "): ")
         leia(codigo_produto)

         se (codigo_produto >= 1) e (codigo_produto <= total_produtos) entao
            escreval()
            escreval("?? DETALHES DO PRODUTO:")
            escreval("Nome: ", nomes_produtos[codigo_produto])
            escreval("Estoque atual: ", qtd_atual[codigo_produto], " unidades")
            escreval("Estoque m�nimo: ", qtd_minima[codigo_produto], " unidades")
            escreval("Capacidade m�xima: ", qtd_maxima[codigo_produto], " unidades")
            escreval("Pre�o unit�rio: R$ ", precos[codigo_produto]:0:2)
            escreval("Valor total em estoque: R$ ", (qtd_atual[codigo_produto] * precos[codigo_produto]):0:2)

            // Status do estoque
            se qtd_atual[codigo_produto] <= qtd_minima[codigo_produto] entao
               escreval("Status: ?? CR�TICO - Estoque baixo!")
            senao
               se qtd_atual[codigo_produto] >= qtd_maxima[codigo_produto] entao
                  escreval("Status: ?? ATEN��O - Estoque no limite!")
               senao
                  escreval("Status: ?? NORMAL")
               fimse
            fimse
         senao
            escreval("? C�digo de produto inv�lido!")
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

            escreva("Estoque m�nimo: ")
            leia(qtd_minima[total_produtos])

            escreva("Capacidade m�xima: ")
            leia(qtd_maxima[total_produtos])

            escreva("Pre�o unit�rio: R$ ")
            leia(precos[total_produtos])

            escreval("? Produto cadastrado com sucesso!")
            escreval("C�digo atribu�do: ", total_produtos)
         senao
            escreval("? Limite de produtos atingido (m�ximo 10)!")
         fimse

      caso 5  // Relat�rio de produtos em falta
         escreval()
         escreval("=== PRODUTOS EM FALTA/CR�TICOS ===")

         para i de 1 ate total_produtos faca
            se qtd_atual[i] <= qtd_minima[i] entao
               escreval("?? ", nomes_produtos[i])
               escreval("   Atual: ", qtd_atual[i], " | M�nimo: ", qtd_minima[i])
               escreval("   Sugest�o de compra: ", (qtd_maxima[i] - qtd_atual[i]), " unidades")
               escreval()
            fimse
         fimpara

      caso 6  // Relat�rio completo
         escreval()
         escreval("=== RELAT�RIO COMPLETO DO ESTOQUE ===")
         escreval("Funcion�rio: ", nome_funcionario)
         escreval("Total de produtos cadastrados: ", total_produtos)
         escreval()

         para i de 1 ate total_produtos faca
            escreval("Produto ", i, ": ", nomes_produtos[i])
            escreval("  Estoque: ", qtd_atual[i], "/", qtd_maxima[i], " (M�n: ", qtd_minima[i], ")")
            escreval("  Pre�o: R$ ", precos[i]:0:2)
            escreval("  Valor em estoque: R$ ", (qtd_atual[i] * precos[i]):0:2)

            se qtd_atual[i] <= qtd_minima[i] entao
               escreval("  Status: ?? CR�TICO")
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
         escreval("At� logo, ", nome_funcionario, "!")

      outrocaso
         escreval("? Op��o inv�lida! Tente novamente.")
      fimescolha

   ate opcao = 8

Fimalgoritmo