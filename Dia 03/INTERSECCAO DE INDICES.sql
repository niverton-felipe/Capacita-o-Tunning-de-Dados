--SELECT * é utilizado intencionalmente nessa query
SELECT soh.*
FROM Sales.SalesOrderHeader AS soh

WHERE soh.SalesPersonID = 276
 AND soh.OrderDate
 BETWEEN '4/1/2005' AND '7/1/2005';

 CREATE NONCLUSTERED INDEX IX_Test ON Sales.SalesOrderHeader (OrderDate);
