--CREATE DATABASE Tunning

USE TUNNING

DROP TABLE #DadosDesenvolvedores
-- Criar uma tabela temporária mais realista
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

-- Preencher a tabela com dados aleatórios
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
    CAST(ABS(CHECKSUM(NEWID())) % 5000 + 3000 AS DECIMAL(10, 2)), -- Salário entre 3000 e 7999
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 3650, GETDATE()), -- Data de contratação nos últimos 10 anos
    CASE ABS(CHECKSUM(NEWID())) % 5
        WHEN 0 THEN 'TI'
        WHEN 1 THEN 'RH'
        WHEN 2 THEN 'Financeiro'
        WHEN 3 THEN 'Marketing'
        ELSE 'Vendas'
    END,
    '(' + LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 3) + ')' + 
    LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 3) + '-' +
    LEFT(CAST(ABS(CHECKSUM(NEWID())) % 1000000000 AS VARCHAR(10)), 4), -- Telefone aleatório
    'email' + CAST(RowNum AS VARCHAR(5)) + '@empresa.com', -- Email único para cada linha,
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

--criação da procedure de estudo
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
AS
SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO
--------------------------------------------------------------------------------

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1

-- 1ª OPÇÃO: UTILIZAÇÃO DO WITH RECOMPILE NA CHAMADA DA PROCEDURE

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1 WITH RECOMPILE
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 WITH RECOMPILE


-- 2ª OPÇÃO: UTILIZAÇÃO DO WITH RECOMPILE NA CRIAÇÃO DA PROCEDURE
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
WITH RECOMPILE
AS
SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO

---------------------------------------------------------------------------------


-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1 WITH RECOMPILE
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0 WITH RECOMPILE


-- 3ª OPÇÃO: UTILIZAÇÃO DE VARIÁVEL LOCAL PARA UTILIZAR O PLANO DE EXECUÇÃO CONSERVADOR
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As

DECLARE @VAR_ATIVO BIT = @ATIVO

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @VAR_ATIVO

---------------------------------------------------------------------------------

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0


--4ª OPÇÃO: Utilizar o OPTION(RECOMPILE) para forçar um novo plano de execução apenas em um bloco específico
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

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0



--5ª OPÇÃO: Utilizar o OPTION(OPTIMEZE FOR ) Força a criação de um plano de execução ótimo para determinado valor de parâmetro
--Opção perigosa pois gerará planos de execução subótimos para demais parâmetros
--EXECUTAR APENAS O BLOCO DESTACADO
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE P_FILTRAR_COLABORADRES_ATIVO (@ATIVO BIT)
As

SELECT * FROM DadosDesenvolvedores
WHERE Ativo = @ATIVO 
OPTION(OPTIMIZE FOR (@ATIVO = 1))

---------------------------------------------------------------------------------

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0

--6ª OPÇÃO: Execução de querie dinâmica que se adapte ao parâmetro passado. Neste caso especificamente, essa opção não é útil pois
--estamos trabalhando com o mesmo parâmetro. Porém, ela é muito boa quando estamos trabalhando com outra coluna e precisamos que o comportamento da querie mude radicalmente
--É preciso ter cuidado neste caso com SQL Injection
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

-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 1
-- Observar plano de execução da página e quantidade de páginas lidas
EXEC P_FILTRAR_COLABORADRES_ATIVO 0