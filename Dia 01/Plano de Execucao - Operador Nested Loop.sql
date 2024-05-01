SET STATISTICS TIME ON
SET STATISTICS IO ON
/*
N�mero de leituras diminui consideravelmente
Maior esfor�o continua sendo no seek da tabela maior
Linhas s�o bem mais finas que na consulta pela tabela inteira
Aparecimento do operador Loops Aninhanhados (que aparece em situa��es onde � preciso fazer jun��es entre
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