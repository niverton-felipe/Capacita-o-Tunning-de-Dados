


 SELECT COUNT(DISTINCT e.[N�_Proposta_Oportunidade]) AS NumeroValoresDistintos,
 COUNT(e.[N�_Proposta_Oportunidade]) AS NumeroTotalLinhas,
 (CAST(COUNT(DISTINCT e.[N�_Proposta_Oportunidade]) AS DECIMAL)
 / CAST(COUNT(e.[N�_Proposta_Oportunidade]) AS DECIMAL)) AS Seletividade,
 (1.0 / (COUNT(DISTINCT e.[N�_Proposta_Oportunidade]))) AS Densidade
FROM [dbo].[Report_SalesForce_Criacao_Manual] AS e;

 SELECT COUNT(DISTINCT e.[Cliente_Estrat�gico]) AS DistinctColValues,
 COUNT(e.[Cliente_Estrat�gico]) AS NumberOfRows,
 (CAST(COUNT(DISTINCT e.[Cliente_Estrat�gico]) AS DECIMAL)
 / CAST(COUNT(e.[Cliente_Estrat�gico]) AS DECIMAL)) AS Selectivity,
 (1.0 / (COUNT(DISTINCT e.[Cliente_Estrat�gico]))) AS Density
FROM [dbo].[Report_SalesForce_Criacao_Manual] AS e;

CREATE NONCLUSTERED INDEX INC_NUMERO_PROPOSTA
ON [dbo].[Report_SalesForce_Criacao_Manual] ([N�_Proposta_Oportunidade])

CREATE NONCLUSTERED INDEX INC_CLIENTE_ESTRATEGICO
ON [dbo].[Report_SalesForce_Criacao_Manual] ([Cliente_Estrat�gico])




SET STATISTICS TIME ON
SET STATISTICS IO ON

--Avaliando quantidade de leituras utilizando o �ndice do campo Cliente_Estrat�gico
SELECT
[N�_Proposta_Oportunidade]
FROM [dbo].[Report_SalesForce_Criacao_Manual]
WHERE [N�_Proposta_Oportunidade] = 'ENELPV06921-22'

--Avaliando quantidade de leituras utilizando o �ndice do campo Cliente_Estrat�gico
SELECT
[Cliente_Estrat�gico]
FROM [dbo].[Report_SalesForce_Criacao_Manual]
WHERE [Cliente_Estrat�gico] = 1

--Avaliando n�mero de p�ginas de cada �ndice criado
SELECT i.name,
 i.type_desc,
 ddips.page_count,
 ddips.record_count,
 ddips.index_level
FROM sys.indexes i
 JOIN sys.dm_db_index_physical_stats( DB_ID(N'AdventureWorks2022'),
 OBJECT_ID(N'dbo.Report_SalesForce_Criacao_Manual'),
NULL,
NULL,
'DETAILED'
 ) AS ddips
 ON i.index_id = ddips.index_id
WHERE i.object_id = OBJECT_ID(N'dbo.Report_SalesForce_Criacao_Manual');