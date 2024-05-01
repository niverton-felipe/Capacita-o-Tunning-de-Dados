SET STATISTICS TIME ON
SET STATISTICS IO ON
/*
Número de leituras diminui consideravelmente
Maior esforço continua sendo no seek da tabela maior
Linhas são bem mais finas que na consulta pela tabela inteira
Aparecimento do operador Loops Aninhanhados (que aparece em situações onde é preciso fazer junções entre
tabelas que retornam menor quantidade de linhas
*/
  
  SELECT A.*,
  B.[EnglishProductName],
  B.Color,
  B.Size
  FROM [AdventureWorksDW2022].[dbo].[FactProductInventory] A
  INNER JOIN [AdventureWorksDW2022].[dbo].[DimProduct] B
  ON A.ProductKey = B.ProductKey
  WHERE A.ProductKey = 1