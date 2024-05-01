
SET STATISTICS IO ON

  SELECT *
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE [ID_da_oportunidade] = '0064T000005wGEI'

--Query com predicado non sargable

  SELECT *
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE SUBSTRING([ID_da_oportunidade], 1, 12) = '0064T000005w'


--Utilizando predicado sargable

  SELECT *
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE [ID_da_oportunidade] LIKE '0064T000005w%'


/*
Mas e se fosse a função RIGHT, por exemplo? Será que a nossa consulta não vai utilizar a
operação de Seek no índice mesmo?
*/
SELECT
*
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE RIGHT([ID_da_oportunidade],3) = 'GEI'

/*
Como vimos acima, a consulta ficou bem ruim, com alto número de logical reads, 
tempo de execução e de CPU. Para resolver esse problema, vamos utilizar o recurso de 
coluna calculada e indexando essa coluna calculada:
*/

-- Cria a nova coluna calculada
ALTER TABLE [Report_SalesForce_Criacao_Manual_Indexada] ADD Right_3 AS (RIGHT([ID_da_oportunidade],3))
GO

-- Cria um índice para a nova coluna criada
CREATE NONCLUSTERED INDEX SK03_Clientes ON [Report_SalesForce_Criacao_Manual_Indexada](Right_3)
GO

-- Executa a consulta nova
SELECT *
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE Right_3 = 'GEI'

SELECT [ID_da_oportunidade]
FROM [Report_SalesForce_Criacao_Manual_Indexada]
WHERE Right_3 = 'GEI'

/*
Wow! A consulta ficou bem mais rápida agora! Isso acontece porque na criação do índice, 
ele já calculou esses dados para a coluna toda e os deixou ordenados. Com isso, as 
consultas ficam muito mais rápidas que ter que calcular isso em tempo real para depois comparar os valores.
*/