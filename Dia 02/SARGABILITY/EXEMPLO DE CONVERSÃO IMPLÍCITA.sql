
SET STATISTICS IO ON

DECLARE @NOME_VARCHAR VARCHAR(50) = 'Amanda Alves'
DECLARE @NOME_NVARCHAR NVARCHAR(50) = 'Amanda Alves'

SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Propriet�rio_da_oportunidade = @NOME_VARCHAR

DECLARE @NOME_VARCHAR VARCHAR(50) = 'Amanda Alves'
DECLARE @NOME_NVARCHAR NVARCHAR(50) = 'Amanda Alves'

SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE [Propriet�rio_da_oportunidade] = @NOME_NVARCHAR

DECLARE @NOME_NVARCHAR NVARCHAR(50) = 'Amanda Alves'
SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE CONVERT(NVARCHAR,[Propriet�rio_da_oportunidade]) = @NOME_NVARCHAR
