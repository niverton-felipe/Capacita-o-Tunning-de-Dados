----------------------------- PREPARA��O DA TABELA DE ESTUDO --------------------------------

USE master

IF (OBJECT_ID('dbo.Vendas') IS NOT NULL) DROP TABLE dbo.Vendas
CREATE TABLE dbo.Vendas (
    Id_Pedido INT IDENTITY(1,1),
    Dt_Pedido DATETIME,
    [Status] INT,
    Quantidade INT,
    Valor NUMERIC(18, 2)
)

CREATE CLUSTERED INDEX SK01_Pedidos ON dbo.Vendas(Id_Pedido)
CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Vendas ([Status], Dt_Pedido) INCLUDE(Quantidade, Valor)
GO


INSERT INTO dbo.Vendas ( Dt_Pedido, [Status], Quantidade, Valor )
SELECT
    DATEADD(SECOND, (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 199999999, '2015-01-01'),
    (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 9,
    (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 10,
    0.459485495 * (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 1999
GO 10000


INSERT INTO dbo.Vendas ( Dt_Pedido, [Status], Quantidade, Valor )
SELECT Dt_Pedido, [Status], Quantidade, Valor FROM dbo.Vendas
GO 9

-- VISUALIZANDO CONTE�DO DA TABELA
SELECT TOP 100 * FROM dbo.Vendas


---------------------------- PRIMEIRO EXEMPLO -------------------------------

SET STATISTICS IO ON

-- Consulta retorna um seek, mas realiza alto volume de leitura de p�ginas de dados
SELECT *
FROM dbo.Vendas
WHERE Dt_Pedido >= '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] < 5

--Observando a distribui��o de valores da coluna status

SELECT
[Status],
COUNT(*) QTD
FROM dbo.Vendas
GROUP BY [Status]
ORDER BY QTD DESC

-- Observando a distribui��o de valores da coluna Dt_Pedido

SELECT
Dt_Pedido,
COUNT(*) QTD
FROM dbo.Vendas
GROUP BY Dt_Pedido
ORDER BY QTD DESC


-- Recriando o �ndice para utilizar a coluna mais seletiva (Dt_Pedido) com ordem de preced�ncia maior.
DROP INDEX SK02_Pedidos ON dbo.Vendas
GO

CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Vendas (Dt_Pedido, [Status]) INCLUDE(Quantidade, Valor)
GO

--E agora vamos executar a consulta novamente e analisar o plano de execu��o:
SELECT *
FROM dbo.Vendas
WHERE Dt_Pedido >= '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] < 5


/*
E se ao inv�s do status < 5 fosse status = 5, por exemplo? Como ficaria o plano de execu��o ?
*/

SELECT Quantidade * Valor
FROM dbo.Vendas
WHERE Dt_Pedido > '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] = 5

-- Para query acima, d� para melhorar ainda sua performance? 
-- Sim, mas apenas se voltarmos para o �ndice anterior
DROP INDEX SK02_Pedidos ON dbo.Vendas
GO

CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Vendas ([Status], Dt_Pedido) INCLUDE(Quantidade, Valor)
GO

-- Refazendo o teste
SELECT Quantidade * Valor
FROM dbo.Vendas
WHERE Dt_Pedido > '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] = 5

/*
Como sempre falo em Performance, tudo tem que ser testado e avaliado.. Nesse caso, uma das 2 consultas ficar�
prejudicada pela altera��o no �ndice, ou voc� pode ter os 2 �ndices criados (consumindo o dobro de espa�o em disco)
e for�ar o melhor �ndice para cada situa��o.

� muito importante observar que a cria��o de �ndices deve ser muito bem pensada, porque n�o d� pra ficar criando 
�ndice pra qualquer consulta do banco. �ndices ocupam espa�o e deixam opera��es de escritas mais lentas e complexas
para o SQL Server, ent�o devem ser criados quando necess�rio.

*/

/* REFER�NCIA
https://dirceuresende.com/blog/sql-server-dicas-de-performance-tuning-qual-a-diferenca-entre-seek-predicate-e-predicate/
*/