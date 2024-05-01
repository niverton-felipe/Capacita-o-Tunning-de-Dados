/************************************************************
 Autor: Landry Duailibe

 Filtered Index
*************************************************************/
USE Tunning
go

/*****************************************
 Cria tabela Product para demonstra��o
******************************************/
DROP TABLE IF exists dbo.Product
go
CREATE TABLE dbo.Product(
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
go

DECLARE @i int = 0

SET NOCOUNT ON

WHILE @i <= 20000000 BEGIN

	INSERT dbo.Product
	SELECT p.ProductID + @i as ProductID, p.[Name] + isnull(' - ' + m.[Name],'') as Product_Name,
	ProductNumber, Color, ListPrice, Size, DaysToManufacture, ProductLine, SellStartDate,
	case when @i <= 5000000 then 1 else 0 end as Flag_Discontinued
	FROM AdventureWorks2022.Production.Product p
	JOIN AdventureWorks2022.Production.ProductModel m on m.ProductModelID = p.ProductModelID

	SET @i += 1000
END
go
-- Tempo de execu��o +- 1 min

SELECT count(*) FROM dbo.Product -- 5.900.295 linhas

SELECT TOP 1000 * FROM dbo.Product


dt_ini_vig dt_fim_vig
01/04/2024 12/04/2024
12/04/2024 31/12/2024

	SELECT COLUNA1, COLUNA2, COLUNA
	FROM TBL_X
	WHERE DT_FIM_VIG = '9999-12-31'


-- Produtos que foram descontinuados s�o marcados com Flag_Discontinued = 1
SELECT Flag_Discontinued,count(*) as QtdLinhas
FROM dbo.Product
GROUP BY Flag_Discontinued 
ORDER BY 1

/*
Flag_Discontinued	QtdLinhas
0					4.425.000
1					1.475.295
*/

set statistics time, io on
set statistics io off

CREATE INDEX ix_Product ON dbo.Product (ProductNumber,Flag_Discontinued)
INCLUDE (Product_Name,Color,ListPrice)

CREATE INDEX ix_Product_Filtered ON dbo.Product (ProductNumber,Flag_Discontinued)
INCLUDE (Product_Name,Color,ListPrice)
WHERE Flag_Discontinued = 0

SELECT i.name as Indice, SUM(s.used_page_count) * 8 as Indice_KB
FROM sys.dm_db_partition_stats s 
JOIN sys.indexes i ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.[object_id] = object_id('dbo.Product')
and i.name like 'ix_Product%'
GROUP BY i.name
/*
Indice				Indice_KB
ix_Product			570088
ix_Product_Filtered	427552
*/

--100.000.000
-- 1.0000.000

SELECT ProductID, Product_Name, Color, ListPrice
FROM dbo.Product 
WHERE ProductNumber = 'SB-M891-M'
and Flag_Discontinued = 0
-- Table 'Product'. Scan count 1, logical reads 184

SELECT TOP 1000 * FROM dbo.Product 

/******************
 Index Scan
*******************/
SELECT ProductID, Product_Name, Color, ListPrice
FROM dbo.Product with(index(ix_Product))
WHERE Product_Name = 'Road-750 Black, 52 - Road-750'
and Flag_Discontinued = 0
-- Table 'Product'. Scan count 4, logical reads 54339 (ix_Product_Filtered)
-- Table 'Product'. Scan count 4, logical reads 72758 (ix_Product)

-- Exclui tabela
DROP TABLE IF exists dbo.Product

