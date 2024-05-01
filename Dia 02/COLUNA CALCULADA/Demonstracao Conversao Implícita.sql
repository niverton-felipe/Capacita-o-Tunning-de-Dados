---------------- CRIA��O DA ESTRUTURA INICIAL DO ESTUDO --------------------------

CREATE TABLE dbo.Pedidos (
    Id_Pedido INT IDENTITY(1,1),
    Dt_Pedido DATETIME,
    [Status] INT,
    Quantidade INT,
    Ds_Pedido VARCHAR(10),
    Valor NUMERIC(18, 2)
)

CREATE CLUSTERED INDEX SK01_Pedidos ON dbo.Pedidos(Id_Pedido)
CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Pedidos (Ds_Pedido)
GO

INSERT INTO dbo.Pedidos
SELECT 
GETDATE() - CAST(RAND() * 1000 + 1 AS INT) DATA_ALEATORIA,
CAST(RAND() * 10 + 1 AS INT) Status_Aleatorio,
CAST(RAND() * 20 + 1 AS INT) Quantidade_Aleatoria,
CAST(RAND() * 2000 + 1 AS INT) Ds_Aleatoria,
CAST(RAND() * 1000 + 1 AS INT) AS NumeroAleatorio;
GO 1000

SET STATISTICS IO ON

select top 100 * from Pedidos

SELECT * FROM Pedidos
WHERE Ds_Pedido = '1063'


SELECT * FROM Pedidos
WHERE Ds_Pedido = 1063

SELECT * FROM Pedidos
WHERE CONVERT(INT,Ds_Pedido) = 1063

SELECT * FROM Pedidos
WHERE Ds_Pedido = N'1063'

DECLARE @DS_PEDIDO NVARCHAR = '1063'

SELECT * FROM Pedidos
WHERE Ds_Pedido = @DS_PEDIDO

--Ocorre convers�o impl�cita em JOIN tamb�m?

/*
Em qualquer opera��o ou compara��o de express�o com tipos de dados diferentes, pode ocorrer a convers�o 
impl�tica (de acordo com as regras vistas acima), seja no SELECT, WHERE, JOIN, CROSS APPLY, etc,
*/

/*
Criei uma tabela chamada Pedidos2, com a mesma estrutura e dados da tabela Pedidos. Ap�s isso, efetuei uma opera��o
de ALTER TABLE para modificar o tipo de dado da coluna Ds_Pedido para NVARCHAR(10) e com isso, temos o seguinte 
exemplo:
*/

--Criando tabela Pedidos_2 com a mesma estrutura da sua origem
SELECT * INTO Pedidos_2  FROM Pedidos

--Alterando  Campo Ds_Pedido para NVARCHAR
ALTER TABLE Pedidos_2
ALTER COLUMN DS_PEDIDO NVARCHAR(10)

CREATE CLUSTERED INDEX SK01_Pedidos ON dbo.Pedidos_2(Id_Pedido)
CREATE NONCLUSTERED INDEX SK02_Pedidos ON dbo.Pedidos_2 (Ds_Pedido)

SELECT A.* FROM Pedidos A
INNER JOIN Pedidos_2 B
ON A.Ds_Pedido = B.Ds_Pedido
WHERE B.Ds_Pedido = N'1063'


--Supondo que houve apenas um erro grave de modelagem, vamos apenas tentar mudar o tipo do campo Ds_Pedido da tabela Pedidos_2
ALTER TABLE Pedidos_2 ALTER COLUMN Ds_Pedido VARCHAR(10)

/*
AVISO: Como essa coluna � indexada, n�o podemos alterar o tipo. Isso vai exigir que a gente apague o �ndice,
apague poss�veis chaves de foreign keys, fa�a a altera��o da coluna e depois recrie o �ndice e/ou foreign key. Ou seja,
n�o � t�o simples assim resolver esse tipo de problema, especialmente quando estamos falando de ambiente de
produ��o, onde alterar o tipo de uma coluna ou a cria��o de um �ndice podem gerar v�rios locks.
Isso sem falar que podem existir outros relacionamentos entre essa tabela e outras utilizando essa coluna, 
que hoje funcionam bem, e que podem come�ar a ter problema de convers�o impl�cita ao alterar o tipo de dado. Como 
tudo em performance, fazer esse tipo de corre��o exige valida��es, an�lises e muitos testes!

*/

--Neste caso, vamos assumir que houve apenas um erro de modelagem e vamos corrigir o problema apagando o �ndice, 
--alterando o tipo da coluna Ds_Pedido e recriando o �ndice

DROP INDEX SK02_Pedidos ON dbo.Pedidos_2
GO

ALTER TABLE Pedidos_2 ALTER COLUMN Ds_Pedido VARCHAR(10)
GO

CREATE NONCLUSTERED INDEX [SK02_Pedidos] ON [dbo].[Pedidos_2] ([Ds_Pedido])
GO


SELECT A.Ds_Pedido FROM Pedidos A
INNER JOIN Pedidos_2 B
ON A.Ds_Pedido = B.Ds_Pedido
WHERE B.Ds_Pedido = '1063'


DROP INDEX SK02_Pedidos ON dbo.Pedidos_2
GO

ALTER TABLE Pedidos_2 ALTER COLUMN Ds_Pedido NVARCHAR(10)
GO

CREATE NONCLUSTERED INDEX [SK02_Pedidos] ON [dbo].[Pedidos_2] ([Ds_Pedido])
GO


SELECT B.Ds_Pedido FROM Pedidos A
INNER JOIN Pedidos_2 B
ON A.Ds_Pedido = B.Ds_Pedido
WHERE B.Ds_Pedido = N'1063'

/*
Mas e nos casos onde n�o podemos realizar o comando ALTER TABLE devido � outros relacionamentos que j� existem?
Quais alternativas temos para isso ?
R: Existem v�rias solu��es, mas uma que gosto muito � a utiliza��o de colunas calculadas e indexadas, que possuem
baixo impacto para a aplica��o (embora possa ter impacto SIM, especialmente em opera��es de INSERT) e costumam ser
bem eficazes e pr�ticas, j� que sempre que a coluna original for alterada, a coluna calculada � atualizada 
automaticamente tamb�m (assim como �ndices que referenciam a coluna calculada, se existirem). Mas lembrem-se: 
TESTEM ANTES DE IMPLEMENTAR!
*/

ALTER TABLE dbo.Pedidos ADD Ds_Pedido_NVARCHAR AS (CONVERT(NVARCHAR(10), Ds_Pedido)) 
GO

CREATE NONCLUSTERED INDEX SK03_Pedidos ON dbo.Pedidos(Ds_Pedido_NVARCHAR)
GO

SELECT B.* FROM Pedidos A
INNER JOIN Pedidos_2 B
ON A.Ds_Pedido_NVARCHAR = B.Ds_Pedido
WHERE B.Ds_Pedido = N'1063'

SELECT COUNT(Ds_Pedido)
FROM Pedidos
WHERE Ds_Pedido = 1063

--DROP INDEX SK03_Pedidos ON dbo.Pedidos


/*
O SQL Server usa a seguinte ordem de preced�ncia para tipos de dados:

tipos de dados personalizados do usu�rio (maior n�vel)
sql_variant
xml
datetimeoffset
datetime2
datetime
smalldatetime
date
time
float
real
decimal
money
smallmoney
bigint
int
smallint
tinyint
bit
ntext
text
image
timestamp
uniqueidentifier
nvarchar (incluindo nvarchar(max) )
nchar
varchar (incluindo varchar(max) )
char
varbinary (incluindo varbinary(max) )
binary (menor n�vel)

*/
