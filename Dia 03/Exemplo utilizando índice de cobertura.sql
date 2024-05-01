


SELECT TOP (1000) [ProdutoID]
      ,[Nome]
      ,[Preco]
      ,[DataCadastro]
      ,[DataUltimaAtualizacao]
      ,[EstoqueAtual]
      ,[CategoriaID]
      ,[FornecedorID]
      ,[Descricao]
      ,[Peso]
  FROM [Tunning].[dbo].[Produtos]
SET STATISTICS IO ON

DROP INDEX INC_NOME_PRODUTO ON [Tunning].[dbo].[Produtos] 

  CREATE NONCLUSTERED INDEX INC_NOME_PRODUTO
  ON [Tunning].[dbo].[Produtos] (NOME)


  SELECT [ProdutoID]
      ,[Nome]
      ,[Preco]
      ,[DataCadastro]
      ,[DataUltimaAtualizacao]
      ,[EstoqueAtual]
      ,[CategoriaID]
      ,[FornecedorID]
      ,[Descricao]
      ,[Peso]
  FROM [Tunning].[dbo].[Produtos]
  WHERE ProdutoID = 6

  
  SELECT *
  FROM [Tunning].[dbo].[Produtos]
  WHERE ProdutoID = 6

    SELECT *
  FROM [Tunning].[dbo].[Produtos]
  WHERE EstoqueAtual = 91

    SELECT 
       [Nome]
      ,[Preco]
      ,[DataCadastro]
	  ,[Peso]
  FROM [Tunning].[dbo].[Produtos]
  WHERE Nome = 'Produto 10'

  DROP INDEX INC_NOME_PRODUTO ON [Tunning].[dbo].[Produtos]

  CREATE NONCLUSTERED INDEX INC_NOME_PRODUTO
  ON [Tunning].[dbo].[Produtos] (NOME)
  INCLUDE ([Preco],[DataCadastro],[Peso])

  /*
  NOME ProdutoID PRECO DATACADASTRO PESO
  
  */