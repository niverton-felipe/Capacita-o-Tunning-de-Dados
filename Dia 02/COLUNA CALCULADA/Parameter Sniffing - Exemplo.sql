--CREATE DATABASE Tunning

USE TUNNING

DROP TABLE #DadosDesenvolvedores
-- Criar uma tabela tempor�ria mais realista
CREATE TABLE DadosDesenvolvedores (
    ID INT,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Idade INT,
    Cargo VARCHAR(50),
    Salario DECIMAL(10, 2),
    DataContratacao DATE,
    Departamento VARCHAR(50),
    Telefone VARCHAR(15),
    Email VARCHAR(100),
	Ativo BIT
);

-- Preencher a tabela com dados aleat�rios
;WITH CTE AS (
    SELECT TOP 10000
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM sys.all_columns a
    CROSS JOIN sys.all_columns b
)


INSERT INTO DadosDesenvolvedores (ID, Nome, Sobrenome, Idade, Cargo, Salario, DataContratacao, Departamento, Telefone, Email, Ativo)
SELECT 
    RowNum,
    'Nome' + CAST(RowNum AS VARCHAR(5)),
    'Sobrenome' + CAST(RowNum AS VARCHAR(5)),
    ABS(CHECKSUM(NEWID())) % 40 + 20, -- Idade entre 20 e 59 anos
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 'Desenvolvedor'
        WHEN 1 THEN 'Analista'
        WHEN 2 THEN 'Gerente'
        ELSE 'Consultor'
    END,
    CAST(ABS(CHECKSUM(NEWID())) % 5000 + 3000 AS DECIMAL(10, 2)), -- Sal�rio entre 3000 e 7999
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 3650, GETDATE()), -- Data de contrata��o nos �ltimos 10 anos
    CASE ABS(CHECKSUM(NEWID())) % 5
        WHEN 0 THEN 'TI'
        WHEN 1 THEN 'RH'
        WHEN 2 THEN 'Financeiro'
        WHEN 3 THEN 'Marketing'
        ELSE 'Vendas'
    END,
    '(' + LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 3) + ')' + 
    LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 3) + '-' +
    LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 4), -- Telefone aleat�rio
    'email' + CAST(RowNum AS VARCHAR(5)) + '@empresa.com', -- Email �nico para cada linha,
	case when RowNum % 1000 = 0 THEN 1 ELSE 0 END  -- Todos os colaboradores atividos
FROM CTE;

-- Verificar se os dados foram inseridos corretamente
--SELECT COUNT(*) FROM #DadosDesenvolvedores;


CREATE CLUSTERED INDEX SK01_DADOS_DESENVOLVEDORES_ID
ON DadosDesenvolvedores (ID)

CREATE NONCLUSTERED INDEX SK02_DADOS_DESENVOLVEDORES_ATIVO
ON DadosDesenvolvedores (ATIVO)

CREATE NONCLUSTERED INDEX SK03_DADOS_DESENVOLVEDORES_CARGO
ON DadosDesenvolvedores (Cargo)

SET STATISTICS IO ON 

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = 1

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = 0

--cria��o da procedure de estudo
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
AS
SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO
--------------------------------------------------------------------------------

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1

-- 1� OP��O: UTILIZA��O DO WITH RECOMPILE NA CHAMADA DA PROCEDURE

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1 WITH RECOMPILE
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 WITH RECOMPILE


-- 2� OP��O: UTILIZA��O DO WITH RECOMPILE NA CRIA��O DA PROCEDURE
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
WITH RECOMPILE
AS
SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO

---------------------------------------------------------------------------------


-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1 WITH RECOMPILE
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 WITH RECOMPILE


-- 3� OP��O: UTILIZA��O DE VARI�VEL LOCAL PARA UTILIZAR O PLANO DE EXECU��O CONSERVADOR
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As

DECLARE @VAR_ATIVO BIT = @ATIVO

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @VAR_ATIVO

---------------------------------------------------------------------------------

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0


--4� OP��O: Utilizar o OPTION(RECOMPILE) para for�ar um novo plano de execu��o apenas em um bloco espec�fico
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As


SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO 
OPTION(RECOMPILE)

---------------------------------------------------------------------------------

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0



--5� OP��O: Utilizar o OPTION(OPTIMEZE FOR ) For�a a cria��o de um plano de execu��o �timo para determinado valor de par�metro
--Op��o perigosa pois gerar� planos de execu��o sub�timos para demais par�metros
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO 
OPTION(OPTIMIZE FOR (@ATIVO = 1))

---------------------------------------------------------------------------------

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0

--6� OP��O: Execu��o de querie din�mica que se adapte ao par�metro passado. Neste caso especificamente, essa op��o n�o � �til pois
--estamos trabalhando com o mesmo par�metro. Por�m, ela � muito boa quando estamos trabalhando com outra coluna e precisamos que o comportamento da querie mude radicalmente
--� preciso ter cuidado neste caso com SQL Injection
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
    
    SET @SQL = '
    SELECT *
    FROM DadosDesenvolvedores
    WHERE Ativo = @ATIVO'
    
    EXEC sp_executesql @SQL, N'@ATIVO BIT', @ATIVO
END

---------------------------------------------------------------------------------

-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execu��o da p�gina e quantidade de p�ginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0