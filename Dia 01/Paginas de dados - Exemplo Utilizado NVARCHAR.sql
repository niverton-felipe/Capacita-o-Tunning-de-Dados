--------------------------- ENTENDENDO O EFEITO DO USO DO NVARCHAR ------------------------
/*
  Como discutimos durante a capacitação, cada caracter do VARCHAR armazena 1 byte de dados enquanto
  no NVARCHAR o mesmo caracter ocupada 2 bytes. Por este motivo, caso não  seja necessário com internacionalizações
  ou símbolos específicos que só estejam presentes no tipo NVARCHAR, é interessante substituí-lo pelo VARCHAR.
  Para exemplificar, a diferença prática entre os tipos, nós criaremos a mesma tabela que já utilizamos antes e mudaremos todos os campos 
  VARCHAR para NVARCHAR.
*/

--Criação da tabela substituindo os campos VARCHAR por NVARCHAR

CREATE TABLE [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR](
	[ID_da_oportunidade] [nvarchar](max) NULL,
	[Proprietário_da_oportunidade] [nvarchar](max) NULL,
	[Data_da_última_mudança_de_fase] [nvarchar](max) NULL,
	[Data_da_última_modificação] [nvarchar](max) NULL,
	[Cliente_Estratégico] [bigint] NULL,
	[Nome_da_conta] [nvarchar](max) NULL,
	[Nome_da_oportunidade] [nvarchar](max) NULL,
	[Fase] [nvarchar](max) NULL,
	[Motivo_da_perda] [nvarchar](max) NULL,
	[Gestor] [nvarchar](max) NULL,
	[Gestor_2] [nvarchar](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [nvarchar](max) NULL,
	[Duração] [bigint] NULL,
	[Data_de_fechamento] [nvarchar](max) NULL,
	[Data_de_criação] [nvarchar](max) NULL,
	[Próxima_etapa] [float] NULL,
	[Origem_do_lead] [nvarchar](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [nvarchar](max) NULL,
	[Criado_por] [nvarchar](max) NULL,
	[Modificado_pela_última_vez_por] [nvarchar](max) NULL,
	[Valor_Moeda] [nvarchar](max) NULL,
	[Valor] [nvarchar](max) NULL,
	[Última_atividade] [nvarchar](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_criação] [nvarchar](max) NULL,
	[Valor_(convertido)_Moeda] [nvarchar](max) NULL,
	[Valor_(convertido)] [nvarchar](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Duração_da_fase] [bigint] NULL,
	[Proprietário_da_conta] [nvarchar](max) NULL,
	[Tipo_de_conta] [nvarchar](max) NULL,
	[Autoprodução] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [nvarchar](max) NULL,
	[Origem_da_Oportunidade] [nvarchar](max) NULL,
	[Nome_da_Consultoria] [nvarchar](max) NULL,
	[Cotação_em_andamento] [bigint] NULL,
	[Cotações] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [nvarchar](max) NULL,
	[N°_Proposta_Oportunidade] [nvarchar](max) NULL,
	[CNPJ] [nvarchar](max) NULL,
	[Credit_Rating] [nvarchar](max) NULL,
	[Credit_Rating_2] [nvarchar](max) NULL,
	[Origem] [nvarchar](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [nvarchar](max) NULL,
	[Produto_da_Oportunidade] [nvarchar](max) NULL,
	[Descrição] [nvarchar](max) NULL,
	[Descrição_da_conta] [nvarchar](max) NULL,
	[Origem_da_Oportunidade_2] [nvarchar](max) NULL,
	[Origem_Relatório] [nvarchar](max) NULL,
	[Origem_da_campanha_principal] [nvarchar](max) NULL,
	[Origem_2] [nvarchar](max) NULL,
	[Origem_Relatório_2] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Inserindo dados na tabela manipulada a partir da tabela original
INSERT INTO [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR]
SELECT * FROM [dbo].[Report_SalesForce_Criacao_Automatica]

-- Consulta para obter o espaço ocupado pelas tabelas
EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica'; 

EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR'; 

-- Consulta para obter o número de páginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica';

-- Consulta para obter o número de páginas de dados da tabela com uso de NVARCHAR
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica_Uso_NVARCHAR';
