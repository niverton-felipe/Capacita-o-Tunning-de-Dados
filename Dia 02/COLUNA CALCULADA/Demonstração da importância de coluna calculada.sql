--Criação da tabela para estudo inicial
USE Tunning;


IF (OBJECT_ID('_Clientes') IS NOT NULL) DROP TABLE _Clientes
CREATE TABLE _Clientes (
    Id_Cliente INT IDENTITY(1,1),
    Dados_Serializados VARCHAR(100)
)

INSERT INTO _Clientes ( Dados_Serializados )
SELECT
    CONVERT(VARCHAR(19), DATEADD(SECOND, (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 199999999, '2015-01-01'), 121) + '|' +
    CONVERT(VARCHAR(20), CONVERT(INT, (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 9)) + '|' +
    CONVERT(VARCHAR(20), CONVERT(INT, (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0) * 10)) + '|' +
    CONVERT(VARCHAR(20), CONVERT(INT, 0.459485495 * (ABS(CHECKSUM(PWDENCRYPT(N''))) / 2147483647.0)) * 1999)
GO 10000

INSERT INTO _Clientes ( Dados_Serializados )
SELECT Dados_Serializados
FROM _Clientes
GO 9

CREATE CLUSTERED INDEX SK01_Pedidos ON _Clientes(Id_Cliente)
CREATE NONCLUSTERED INDEX SK02_Pedidos ON _Clientes(Dados_Serializados)
GO

select top 100 * from Dados_Serializados

SET STATISTICS IO ON

--Query com uso otimizado
SELECT *
FROM _Clientes
WHERE Dados_Serializados = '2015-08-17 03:19:50|7|8|0'

--Query com predicado non sargable
SELECT * 
FROM _Clientes
WHERE SUBSTRING(Dados_Serializados, 1, 10) = '2015-08-17'

--Utilizando predicado sargable
SELECT * 
FROM _Clientes
WHERE Dados_Serializados LIKE '2015-08-17%'

/*
Mas e se fosse a função RIGHT, por exemplo? Será que a nossa consulta não vai utilizar a
operação de Seek no índice mesmo?
*/
SELECT
Dados_Serializados
FROM _Clientes
WHERE RIGHT(Dados_Serializados,5) = '7|8|0'

/*
Como vimos acima, a consulta ficou bem ruim, com alto número de logical reads, 
tempo de execução e de CPU. Para resolver esse problema, vamos utilizar o recurso de 
coluna calculada e indexando essa coluna calculada:
*/

-- Cria a nova coluna calculada
ALTER TABLE _Clientes ADD Right_5 AS (RIGHT(Dados_Serializados, 5))
GO

-- Cria um índice para a nova coluna criada
CREATE NONCLUSTERED INDEX SK03_Clientes ON dbo._Clientes(Right_5)
GO

-- Executa a consulta nova
SELECT Right_5
FROM _Clientes
WHERE Right_5 = '1|4|0'

/*
Wow! A consulta ficou bem mais rápida agora! Isso acontece porque na criação do índice, 
ele já calculou esses dados para a coluna toda e os deixou ordenados. Com isso, as 
consultas ficam muito mais rápidas que ter que calcular isso em tempo real para depois comparar os valores.
*/