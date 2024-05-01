
SET STATISTICS IO ON


SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Proprietário_da_oportunidade  = 'Amanda Alves'
OR Proprietário_da_oportunidade = 'Amanda Castro'
OR Proprietário_da_oportunidade ='Amanda Fernandes'
OR Proprietário_da_oportunidade = 'Amanda Pereira'


SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Proprietário_da_oportunidade 
IN
('Amanda Alves',
'Amanda Castro',
'Amanda Fernandes',
'Amanda Pereira',
'Ana Oliveira',
'Ana Rodrigues',
'Ana Silva',
'André Lima',
'André Rodrigues'
)


CREATE TABLE #TEMP_NOMES (NOME VARCHAR(50) PRIMARY KEY)

INSERT INTO #TEMP_NOMES VALUES
('Amanda Alves'),
('Amanda Castro'),
('Amanda Fernandes'),
('Amanda Pereira'),
('Ana Oliveira'),
('Ana Rodrigues'),
('Ana Silva'),
('André Lima'),
('André Rodrigues')


SELECT 
A.[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada] A
INNER JOIN #TEMP_NOMES B ON A.Proprietário_da_oportunidade = B.NOME