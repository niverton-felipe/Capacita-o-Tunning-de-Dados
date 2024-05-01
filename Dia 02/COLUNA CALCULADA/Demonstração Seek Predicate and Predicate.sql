----------------------------- PREPARAÇÃO DA TABELA DE ESTUDO --------------------------------

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

-- VISUALIZANDO CONTEÚDO DA TABELA
SELECT TOP 100 * FROM dbo.Vendas


---------------------------- PRIMEIRO EXEMPLO -------------------------------

SET STATISTICS IO ON

-- Consulta retorna um seek, mas realiza alto volume de leitura de páginas de dados
SELECT *
FROM dbo.Vendas
WHERE Dt_Pedido >= '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] < 5

--Observando a distribuição de valores da coluna status

SELECT
[Status],
COUNT(*) QTD
FROM dbo.Vendas
GROUP BY [Status]
ORDER BY QTD DESC

-- Observando a distribuição de valores da coluna Dt_Pedido

SELECT
Dt_Pedido,
COUNT(*) QTD
FROM dbo.Vendas
GROUP BY Dt_Pedido
ORDER BY QTD DESC


-- Recriando o índice para utilizar a coluna mais seletiva (Dt_Pedido) com ordem de precedência maior.
DROP INDEX SK02_Pedidos ON dbo.Vendas
GO

CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Vendas (Dt_Pedido, [Status]) INCLUDE(Quantidade, Valor)
GO

--E agora vamos executar a consulta novamente e analisar o plano de execução:
SELECT *
FROM dbo.Vendas
WHERE Dt_Pedido >= '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] < 5


/*
E se ao invés do status < 5 fosse status = 5, por exemplo? Como ficaria o plano de execução ?
*/

SELECT Quantidade * Valor
FROM dbo.Vendas
WHERE Dt_Pedido > '2019-02-06'
AND Dt_Pedido < '2019-02-09'
AND [Status] = 5

-- Para query acima, dá para melhorar ainda sua performance? 
-- Sim, mas apenas se voltarmos para o índice anterior
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
Como sempre falo em Performance, tudo tem que ser testado e avaliado.. Nesse caso, uma das 2 consultas ficará
prejudicada pela alteração no índice, ou você pode ter os 2 índices criados (consumindo o dobro de espaço em disco)
e forçar o melhor índice para cada situação.

É muito importante observar que a criação de índices deve ser muito bem pensada, porque não dá pra ficar criando 
índice pra qualquer consulta do banco. Índices ocupam espaço e deixam operações de escritas mais lentas e complexas
para o SQL Server, então devem ser criados quando necessário.

*/

/* REFERÊNCIA
https://dirceuresende.com/blog/sql-server-dicas-de-performance-tuning-qual-a-diferenca-entre-seek-predicate-e-predicate/
*/