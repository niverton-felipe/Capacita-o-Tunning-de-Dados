

use tunning
--Criando tabelas de teste com índice de compressão de página
CREATE TABLE dbo.Product_indice_page(
ProductID int NOT NULL primary key,
Product_Name varchar(150) NOT NULL,
ProductNumber char(20) NOT NULL,
Color char(15) NULL,
ListPrice money NOT NULL,
Size char(5) NULL,
DaysToManufacture int NOT NULL,
ProductLine char(2) NULL,
SellStartDate datetime NULL,
Flag_Discontinued bit NOT NULL)

--Criando tabelas de teste com índice de compressão de linha
CREATE TABLE dbo.Product_indice_row(
ProductID int NOT NULL primary key,
Product_Name varchar(150) NOT NULL,
ProductNumber char(20) NOT NULL,
Color char(15) NULL,
ListPrice money NOT NULL,
Size char(5) NULL,
DaysToManufacture int NOT NULL,
ProductLine char(2) NULL,
SellStartDate datetime NULL,
Flag_Discontinued bit NOT NULL)

--Inserido dados nas tabelas
INSERT INTO Product_indice_page
SELECT * FROM [dbo].[Product]

INSERT INTO Product_indice_row
SELECT * FROM [dbo].[Product]


CREATE INDEX ix_Product_Filtered ON [dbo].[Product_indice_page] (ProductNumber,Flag_Discontinued)
INCLUDE (Product_Name,Color,ListPrice)
WHERE Flag_Discontinued = 0
WITH (DATA_COMPRESSION = PAGE)

CREATE INDEX ix_Product_Filtered ON [dbo].[Product_indice_row] (ProductNumber,Flag_Discontinued)
INCLUDE (Product_Name,Color,ListPrice)
WHERE Flag_Discontinued = 0
WITH (DATA_COMPRESSION = ROW)

SELECT i.name as Indice, SUM(s.used_page_count) * 8 as Indice_KB
FROM sys.dm_db_partition_stats s 
JOIN sys.indexes i ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.[object_id] = object_id('dbo.Product')
and i.name like 'ix_Product%'
GROUP BY i.name



SELECT i.name as Indice, SUM(s.used_page_count) * 8 as Indice_KB
FROM sys.dm_db_partition_stats s 
JOIN sys.indexes i ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.[object_id] = object_id('dbo.Product_indice_row')
and i.name like 'ix_Product%'
GROUP BY i.name

SELECT i.name as Indice, SUM(s.used_page_count) * 8 as Indice_KB
FROM sys.dm_db_partition_stats s 
JOIN sys.indexes i ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.[object_id] = object_id('dbo.Product_indice_page')
and i.name like 'ix_Product%'
GROUP BY i.name



SET STATISTICS TIME, IO ON

SELECT ProductID, Product_Name, Color, ListPrice
FROM dbo.Product 
WHERE ProductNumber = 'SB-M891-M'
and Flag_Discontinued = 0
/*
 SQL Server Execution Times:
   CPU time = 33 ms,  elapsed time = 41 ms.
   logical reads 184
*/
SELECT ProductID, Product_Name, Color, ListPrice
FROM dbo.Product_indice_row 
WHERE ProductNumber = 'SB-M891-M'
and Flag_Discontinued = 0

/*
logical reads 141
 SQL Server Execution Times:
   CPU time = 122 ms,  elapsed time = 140 ms.
*/

SELECT ProductID, Product_Name, Color, ListPrice
FROM dbo.Product_indice_page 
WHERE ProductNumber = 'SB-M891-M'
and Flag_Discontinued = 0

/*
logical reads 24
 SQL Server Execution Times:
   CPU time = 40 ms,  elapsed time = 64 ms.
*/
