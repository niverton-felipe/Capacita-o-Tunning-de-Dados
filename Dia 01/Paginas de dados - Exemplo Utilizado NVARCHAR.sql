--------------------------- ENTENDENDO O EFEITO DO USO DO NVARCHAR ------------------------
/*
  Como discutimos durante a capacita��o, cada caracter do VARCHAR armazena 1 byte de dados enquanto
  no NVARCHAR o mesmo caracter ocupada 2 bytes. Por este motivo, caso n�o  seja necess�rio com internacionaliza��es
  ou s�mbolos espec�ficos que s� estejam presentes no tipo NVARCHAR, � interessante substitu�-lo pelo VARCHAR.
  Para exemplificar, a diferen�a pr�tica entre os tipos, n�s criaremos a mesma tabela que j� utilizamos antes e mudaremos todos os campos 
  VARCHAR para NVARCHAR.
*/

--Cria��o da tabela substituindo os campos VARCHAR por NVARCHAR

CREATE TABLE [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR](
	[ID_da_oportunidade] [nvarchar](max) NULL,
	[Propriet�rio_da_oportunidade] [nvarchar](max) NULL,
	[Data_da_�ltima_mudan�a_de_fase] [nvarchar](max) NULL,
	[Data_da_�ltima_modifica��o] [nvarchar](max) NULL,
	[Cliente_Estrat�gico] [bigint] NULL,
	[Nome_da_conta] [nvarchar](max) NULL,
	[Nome_da_oportunidade] [nvarchar](max) NULL,
	[Fase] [nvarchar](max) NULL,
	[Motivo_da_perda] [nvarchar](max) NULL,
	[Gestor] [nvarchar](max) NULL,
	[Gestor_2] [nvarchar](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [nvarchar](max) NULL,
	[Dura��o] [bigint] NULL,
	[Data_de_fechamento] [nvarchar](max) NULL,
	[Data_de_cria��o] [nvarchar](max) NULL,
	[Pr�xima_etapa] [float] NULL,
	[Origem_do_lead] [nvarchar](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [nvarchar](max) NULL,
	[Criado_por] [nvarchar](max) NULL,
	[Modificado_pela_�ltima_vez_por] [nvarchar](max) NULL,
	[Valor_Moeda] [nvarchar](max) NULL,
	[Valor] [nvarchar](max) NULL,
	[�ltima_atividade] [nvarchar](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_cria��o] [nvarchar](max) NULL,
	[Valor_(convertido)_Moeda] [nvarchar](max) NULL,
	[Valor_(convertido)] [nvarchar](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Dura��o_da_fase] [bigint] NULL,
	[Propriet�rio_da_conta] [nvarchar](max) NULL,
	[Tipo_de_conta] [nvarchar](max) NULL,
	[Autoprodu��o] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [nvarchar](max) NULL,
	[Origem_da_Oportunidade] [nvarchar](max) NULL,
	[Nome_da_Consultoria] [nvarchar](max) NULL,
	[Cota��o_em_andamento] [bigint] NULL,
	[Cota��es] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [nvarchar](max) NULL,
	[N�_Proposta_Oportunidade] [nvarchar](max) NULL,
	[CNPJ] [nvarchar](max) NULL,
	[Credit_Rating] [nvarchar](max) NULL,
	[Credit_Rating_2] [nvarchar](max) NULL,
	[Origem] [nvarchar](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [nvarchar](max) NULL,
	[Produto_da_Oportunidade] [nvarchar](max) NULL,
	[Descri��o] [nvarchar](max) NULL,
	[Descri��o_da_conta] [nvarchar](max) NULL,
	[Origem_da_Oportunidade_2] [nvarchar](max) NULL,
	[Origem_Relat�rio] [nvarchar](max) NULL,
	[Origem_da_campanha_principal] [nvarchar](max) NULL,
	[Origem_2] [nvarchar](max) NULL,
	[Origem_Relat�rio_2] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Inserindo dados na tabela manipulada a partir da tabela original
INSERT INTO [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR]
SELECT * FROM [dbo].[Report_SalesForce_Criacao_Automatica]

-- Consulta para obter o espa�o ocupado pelas tabelas
EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica'; 

EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR'; 

-- Consulta para obter o n�mero de p�ginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica';

-- Consulta para obter o n�mero de p�ginas de dados da tabela com uso de NVARCHAR
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR';
