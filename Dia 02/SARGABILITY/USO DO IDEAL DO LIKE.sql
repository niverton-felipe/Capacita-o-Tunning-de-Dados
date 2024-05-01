
SET STATISTICS IO ON

SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Proprietário_da_oportunidade LIKE '%André%'


SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE [Proprietário_da_oportunidade] LIKE 'André%' 
