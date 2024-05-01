USE Tunning

SELECT TOP 1000  * FROM Categorias
SELECT TOP 1000 * FROM Fornecedores
SELECT TOP 100 * FROM Produtos

DROP TABLE Categorias
DROP TABLE Fornecedores
DROP TABLE Produtos

-- Tabela 2: Categorias
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao VARCHAR(255),
    DataCriacao DATE,
    DataUltimaAtualizacao DATETIME,
    Status VARCHAR(20),
    Classificacao INT,
    OrdemExibicao INT,
    Observacao VARCHAR(255),
    UsuarioCriacao VARCHAR(100)
);

-- Tabela 3: Fornecedores
CREATE TABLE Fornecedores (
    FornecedorID INT PRIMARY KEY,
    Nome VARCHAR(100),
    CNPJ VARCHAR(20),
    Telefone VARCHAR(20),
    Endereco VARCHAR(200),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    CEP VARCHAR(10),
    DataCadastro DATE,
    Status VARCHAR(20)
);


-- Tabela 1: Produtos
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Preco DECIMAL(10, 2),
    DataCadastro DATE,
    DataUltimaAtualizacao DATETIME,
    EstoqueAtual INT,
    CategoriaID INT FOREIGN KEY REFERENCES Categorias(CategoriaID),
    FornecedorID INT FOREIGN KEY REFERENCES Fornecedores(FornecedorID),
    Descricao VARCHAR(255),
    Peso DECIMAL(10, 2)
);

-- POPULANDO AS TABELAS

-- Criando uma tabela temporária com 10 mil registros e uma coluna de identidade
CREATE TABLE #Temp (
    ID INT 
);

-- Inserindo 10 mil registros na tabela temporária
;WITH Numbers AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Num
    FROM (
        SELECT TOP 10000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Num
        FROM master.dbo.spt_values t1
        CROSS JOIN master.dbo.spt_values t2
    ) AS Numbers
)

INSERT INTO #Temp
SELECT Num
FROM Numbers
WHERE Num <= 10000;



-- Populando a tabela Categorias com base na tabela temporária
INSERT INTO Categorias (CategoriaID, Nome, Descricao, DataCriacao, DataUltimaAtualizacao, Status, Classificacao, OrdemExibicao, Observacao, UsuarioCriacao)
SELECT 
    t.ID,
    'Categoria ' + CAST(t.ID AS VARCHAR),
    'Descrição da categoria ' + CAST(t.ID AS VARCHAR),
    DATEADD(DAY, -ROUND(RAND() * 3650, 0), GETDATE()),
    DATEADD(DAY, -ROUND(RAND() * 365, 0), GETDATE()),
    'Ativa',
    ROUND(RAND() * 10, 0),
    ROUND(RAND() * 100, 0),
    'Observação da categoria ' + CAST(t.ID AS VARCHAR),
    'Usuário ' + CAST(t.ID AS VARCHAR)
FROM 
    #Temp t;

-- Populando a tabela Fornecedores com base na tabela temporária
INSERT INTO Fornecedores (FornecedorID, Nome, CNPJ, Telefone, Endereco, Cidade, Estado, CEP, DataCadastro, Status)
SELECT 
    t.ID,
    'Fornecedor ' + CAST(t.ID AS VARCHAR),
    CAST(ROUND(RAND() * 99999999999999, 0) AS VARCHAR),
    '(' + CAST(ROUND(RAND() * 999, 0) AS VARCHAR) + ') ' + CAST(ROUND(RAND() * 999999999, 0) AS VARCHAR),
    'Endereço do fornecedor ' + CAST(t.ID AS VARCHAR),
    'Cidade do fornecedor ' + CAST(t.ID AS VARCHAR),
    'Estado' + CAST(t.ID AS VARCHAR),
    CAST(ROUND(RAND() * 99999, 0) AS VARCHAR),
    DATEADD(DAY, -ROUND(RAND() * 3650, 0), GETDATE()),
    'Ativo'
FROM 
    #Temp t;

-- Populando a tabela Produtos com base na tabela temporária
INSERT INTO Produtos (ProdutoID, Nome, Preco, DataCadastro, DataUltimaAtualizacao, EstoqueAtual, CategoriaID, FornecedorID, Descricao, Peso)
SELECT 
    t.ID,
    'Produto ' + CAST(t.ID AS VARCHAR),
    ROUND(RAND() * 1000, 2),
    DATEADD(DAY, -ROUND(RAND() * 3650, 0), GETDATE()),
    DATEADD(DAY, -ROUND(RAND() * 365, 0), GETDATE()),
    ROUND(RAND() * 100, 0),
    ROUND(RAND() * 100, 0), -- Supondo que haja 100 categorias
    ROUND(RAND() * 100, 0), -- Supondo que haja 100 fornecedores
    'Descrição do produto ' + CAST(t.ID AS VARCHAR),
    ROUND(RAND() * 10, 2)
FROM 
    #Temp t;


-- Removendo a tabela temporária
DROP TABLE #Temp;

SET STATISTICS IO ON

-- Consulta utilizando as três tabelas
SELECT 
    p.ProdutoID,
    p.Nome AS NomeProduto,
    p.Preco,
    c.Nome AS NomeCategoria,
    f.Nome AS NomeFornecedor
FROM 
    Produtos p
INNER JOIN 
    Categorias c ON p.CategoriaID = c.CategoriaID
INNER JOIN 
    Fornecedores f ON p.FornecedorID = f.FornecedorID;

--DROP VIEW VW_CONSULTA_TESTE
CREATE OR ALTER VIEW VW_CONSULTA_TESTE
WITH SCHEMABINDING
AS
-- Consulta utilizando as três tabelas
SELECT 
    p.ProdutoID,
    p.Nome AS NomeProduto,
    p.Preco,
    c.Nome AS NomeCategoria,
    f.Nome AS NomeFornecedor
FROM 
    dbo.Produtos p
INNER JOIN 
    dbo.Categorias c ON p.CategoriaID = c.CategoriaID
INNER JOIN 
    dbo.Fornecedores f ON p.FornecedorID = f.FornecedorID;

CREATE UNIQUE CLUSTERED INDEX IC_VIEW_CONSULTA_TESTE_PRODUTOID
ON VW_CONSULTA_TESTE (ProdutoID, NomeProduto)

SELECT * FROM VW_CONSULTA_TESTE

-- Consulta utilizando as três tabelas também utilizarão a view indexada
SELECT 
    p.ProdutoID,
    p.Nome AS NomeProduto,
    p.Preco,
    c.Nome AS NomeCategoria,
    f.Nome AS NomeFornecedor
FROM 
    dbo.Produtos p
INNER JOIN 
    dbo.Categorias c ON p.CategoriaID = c.CategoriaID
INNER JOIN 
    dbo.Fornecedores f ON p.FornecedorID = f.FornecedorID;