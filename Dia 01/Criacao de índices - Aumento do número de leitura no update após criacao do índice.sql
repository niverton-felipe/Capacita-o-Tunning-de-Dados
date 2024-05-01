DROP TABLE IF EXISTS dbo.Test1;
GO

SET STATISTICS IO ON

CREATE TABLE dbo.Test1
(
 C1 INT,
 C2 INT,
 C3 VARCHAR(50)
);

WITH Nums
AS (SELECT TOP (10000)
 ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS n
 FROM master.sys.all_columns ac1
 CROSS JOIN master.sys.all_columns ac2
 )


INSERT INTO dbo.Test1
(
 C1,
 C2,
 C3
)
SELECT n,
 n,
 'C3'
FROM Nums;


UPDATE dbo.Test1
SET C1 = 1,
 C2 = 1
WHERE C2 = 1;

--logical reads antes do índice: 46

CREATE CLUSTERED INDEX iTest
ON dbo.Test1(C1);


UPDATE dbo.Test1
SET C1 = 1,
C2 = 1
WHERE C2 = 1;

--logical reads após criação do índice: 48
