/****** Script do comando SelectTopNRows de SSMS  ******/
SET STATISTICS TIME ON
SET STATISTICS IO ON
/*
Como é preciso retornar todos os dados, o otimizador utiliza dois clustered Index Scan percorrendo todas
as páginas do índice clustered.
Por se tratar de um volume maior dos dados, o operador utilizado é o Merge Join
Como os dados estão ordenados pelo seu índice clustered, esse operador é eficiente
*/
  SELECT A.*,
  B.[EnglishProductName],
  B.Color,
  B.Size
  FROM [AdventureWorksDW2022].[dbo].[FactProductInventory] A
  INNER JOIN [AdventureWorksDW2022].[dbo].[DimProduct] B
  ON A.ProductKey = B.ProductKey