DROP TABLE IF EXISTS dbo.Test1;
GO

--Criando tabela de teste
CREATE TABLE dbo.Test1 (C1 INT, C2 INT);

--Criando CTE para popular tabela
WITH Nums
 AS (SELECT 1 AS n
 UNION ALL
 SELECT n + 1
 FROM Nums
 WHERE n < 100
 )

 --Populando tabela
 INSERT INTO dbo.Test1
 (C1, C2)
 SELECT n,
 2
 FROM Nums;

--Criando índice com tipo INT
CREATE INDEX iTest ON dbo.Test1(C1);

--Verificando quantidade de páginas necessárias para armazenar os dados
SELECT i.name,
 i.type_desc,
 ddips.page_count,
 ddips.record_count,
 ddips.index_level
FROM sys.indexes i
 JOIN sys.dm_db_index_physical_stats( DB_ID(N'AdventureWorks2022'),
 OBJECT_ID(N'dbo.Test1'),
NULL,
NULL,
'DETAILED'
 ) AS ddips
 ON i.index_id = ddips.index_id
WHERE i.object_id = OBJECT_ID(N'dbo.Test1');

--Deletando o índice
DROP INDEX dbo.Test1.iTest;
ALTER TABLE dbo.Test1 ALTER COLUMN C1 CHAR(500); --Alterando a coluna C1 para CHAR(500)
CREATE INDEX iTest ON dbo.Test1(C1); --Criando novo índice com coluna C1
CREATE INDEX iTest2 ON dbo.Test1(C2); --Criando novo índice com coluna C2


--Verificando quantidade de páginas necessárias para armazenar os dados após criação dos novos índices
SELECT i.name,
 i.type_desc,
 ddips.page_count,
 ddips.record_count,
 ddips.index_level
FROM sys.indexes i
 JOIN sys.dm_db_index_physical_stats( DB_ID(N'AdventureWorks2022'),
 OBJECT_ID(N'dbo.Test1'),
NULL,
NULL,
'DETAILED'
 ) AS ddips
 ON i.index_id = ddips.index_id
WHERE i.object_id = OBJECT_ID(N'dbo.Test1');

