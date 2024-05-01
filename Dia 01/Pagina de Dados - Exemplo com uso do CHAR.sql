--------------------------- ENTENDENDO O EFEITO DO USO DO CHAR ------------------------
/*
  No tipo de dados VARCHAR cada caractere ocupa 1 byte, porém, este espaço não é ocupado de maneira fixo. Ou seja, 
  um campo definido como VARCHAR(100) só ocupará 100 bytes caso o valor passado tenha 100 caracteres. 
  Este mesmo campo definido com o tipo CHAR(100) ocuparia 100 bytes independente do tamanho do texto.
  Vamos acompanhar de maneira prática como isso acaba interferindo no consumo de espaço da tabela e consequentemente 
  no tempo de leitura das queries.
*/

--Criação da tabela substituindo os campos VARCHAR por CHAR

CREATE TABLE [dbo].[Report_SalesForce_Criacao_Automatica_Uso_CHAR](
	[ID_da_oportunidade] [char](max) NULL,
	[Proprietário_da_oportunidade] [char](max) NULL,
	[Data_da_última_mudança_de_fase] [char](max) NULL,
	[Data_da_última_modificação] [char](max) NULL,
	[Cliente_Estratégico] [bigint] NULL,
	[Nome_da_conta] [char](max) NULL,
	[Nome_da_oportunidade] [char](max) NULL,
	[Fase] [char](max) NULL,
	[Motivo_da_perda] [char](max) NULL,
	[Gestor] [char](max) NULL,
	[Gestor_2] [char](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [char](max) NULL,
	[Duração] [bigint] NULL,
	[Data_de_fechamento] [char](max) NULL,
	[Data_de_criação] [char](max) NULL,
	[Próxima_etapa] [float] NULL,
	[Origem_do_lead] [char](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [char](max) NULL,
	[Criado_por] [char](max) NULL,
	[Modificado_pela_última_vez_por] [char](max) NULL,
	[Valor_Moeda] [char](max) NULL,
	[Valor] [char](max) NULL,
	[Última_atividade] [char](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_criação] [char](max) NULL,
	[Valor_(convertido)_Moeda] [char](max) NULL,
	[Valor_(convertido)] [char](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Duração_da_fase] [bigint] NULL,
	[Proprietário_da_conta] [char](max) NULL,
	[Tipo_de_conta] [char](max) NULL,
	[Autoprodução] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [char](max) NULL,
	[Origem_da_Oportunidade] [char](max) NULL,
	[Nome_da_Consultoria] [char](max) NULL,
	[Cotação_em_andamento] [bigint] NULL,
	[Cotações] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [char](max) NULL,
	[N°_Proposta_Oportunidade] [char](max) NULL,
	[CNPJ] [char](max) NULL,
	[Credit_Rating] [char](max) NULL,
	[Credit_Rating_2] [char](max) NULL,
	[Origem] [char](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [char](max) NULL,
	[Produto_da_Oportunidade] [char](max) NULL,
	[Descrição] [char](max) NULL,
	[Descrição_da_conta] [char](max) NULL,
	[Origem_da_Oportunidade_2] [char](max) NULL,
	[Origem_Relatório] [char](max) NULL,
	[Origem_da_campanha_principal] [char](max) NULL,
	[Origem_2] [char](max) NULL,
	[Origem_Relatório_2] [char](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Inserindo dados na tabela manipulada a partir da tabela original
INSERT INTO [dbo].[Report_SalesForce_Criacao_Automatica_Uso_CHAR]
SELECT * FROM [dbo].[Report_SalesForce_Criacao_Automatica]

-- Consulta para obter o espaço ocupado pelas tabelas
EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica'; 

EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica_Uso_CHAR'; 

-- Consulta para obter o número de páginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica';

-- Consulta para obter o número de páginas de dados da tabela com uso de CHAR
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica_Uso_CHAR';
