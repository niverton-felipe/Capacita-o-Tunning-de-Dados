
SET STATISTICS IO ON

SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Propriet�rio_da_oportunidade LIKE '%Andr�%'


SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE [Propriet�rio_da_oportunidade] LIKE 'Andr�%' 
