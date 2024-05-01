
SET STATISTICS IO ON


SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Propriet�rio_da_oportunidade  = 'Amanda Alves'
OR Propriet�rio_da_oportunidade = 'Amanda Castro'
OR Propriet�rio_da_oportunidade ='Amanda Fernandes'
OR Propriet�rio_da_oportunidade = 'Amanda Pereira'


SELECT 
[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Propriet�rio_da_oportunidade 
IN
('Amanda Alves',
'Amanda Castro',
'Amanda Fernandes',
'Amanda Pereira',
'Ana Oliveira',
'Ana Rodrigues',
'Ana Silva',
'Andr� Lima',
'Andr� Rodrigues'
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
('Andr� Lima'),
('Andr� Rodrigues')


SELECT 
A.[Propriet�rio_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada] A
INNER JOIN #TEMP_NOMES B ON A.Propriet�rio_da_oportunidade = B.NOME