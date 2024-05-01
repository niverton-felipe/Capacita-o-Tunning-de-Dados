/****** Script do comando SelectTopNRows de SSMS  ******/
SET STATISTICS TIME ON
SET STATISTICS IO ON
/*
Como � preciso retornar todos os dados, o otimizador utiliza dois clustered Index Scan percorrendo todas
as p�ginas do �ndice clustered.
Por se tratar de um volume maior dos dados, o operador utilizado � o Merge Join
Como os dados est�o ordenados pelo seu �ndice clustered, esse operador � eficiente
*/
  SELECT A.*,
  B.[EnglishProductName],
  B.Color,
  B.Size
  FROM [AdventureWorksDW2022].[dbo].[FactProductInventory] A
  INNER JOIN [AdventureWorksDW2022].[dbo].[DimProduct] B
  ON A.ProductKey = B.ProductKey