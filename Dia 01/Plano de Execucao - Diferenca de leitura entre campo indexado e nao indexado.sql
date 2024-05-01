


SET STATISTICS TIME ON
SET STATISTICS IO ON


  SELECT [Data_da_última_modificação]
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual]
  WHERE [Data_da_última_modificação] = '2023-10-27'

    SELECT
	 [ID_da_oportunidade]
      ,[Proprietário_da_oportunidade]
      ,[Data_da_última_mudança_de_fase]
      ,[Data_da_última_modificação]
      ,[Nome_da_conta]
      ,[Nome_da_oportunidade]
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual]
  WHERE [Data_da_última_modificação] = '2023-10-27'

/*
Diferença de esforço para fazer leitura de um campo indexado e não indexado
*/
  SELECT DISTINCT  
  [Data_da_última_modificação]
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual]

  SELECT DISTINCT  
  [Data_da_última_modificação]
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Automatica]