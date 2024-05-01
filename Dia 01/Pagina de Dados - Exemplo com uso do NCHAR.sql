--------------------------- ENTENDENDO O EFEITO DO USO DO NVARCHAR ------------------------
/*
  No tipo de dados NVARCHAR cada caractere ocupa 2 bytes, porém, este espaço não é ocupado de maneira fixo. Ou seja, 
  um campo definido como NVARCHAR(100) só ocupará 100 bytes caso o valor passado tenha 100 caracteres. 
  Este mesmo campo definido com o tipo NCHAR(100) ocuparia 200 bytes independente do tamanho do texto.
  Vamos acompanhar de maneira prática como isso acaba interferindo no consumo de espaço da tabela e consequentemente 
  no tempo de leitura das queries.
*/

--Criação da tabela substituindo os campos VARCHAR por NCHAR

CREATE TABLE [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NCHAR](
	[ID_da_oportunidade] [nchar](max) NULL,
	[Proprietário_da_oportunidade] [nchar](max) NULL,
	[Data_da_última_mudança_de_fase] [nchar](max) NULL,
	[Data_da_última_modificação] [nchar](max) NULL,
	[Cliente_Estratégico] [bigint] NULL,
	[Nome_da_conta] [nchar](max) NULL,
	[Nome_da_oportunidade] [nchar](max) NULL,
	[Fase] [nchar](max) NULL,
	[Motivo_da_perda] [nchar](max) NULL,
	[Gestor] [nchar](max) NULL,
	[Gestor_2] [nchar](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [nchar](max) NULL,
	[Duração] [bigint] NULL,
	[Data_de_fechamento] [nchar](max) NULL,
	[Data_de_criação] [nchar](max) NULL,
	[Próxima_etapa] [float] NULL,
	[Origem_do_lead] [nchar](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [nchar](max) NULL,
	[Criado_por] [nchar](max) NULL,
	[Modificado_pela_última_vez_por] [nchar](max) NULL,
	[Valor_Moeda] [nchar](max) NULL,
	[Valor] [nchar](max) NULL,
	[Última_atividade] [nchar](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_criação] [nchar](max) NULL,
	[Valor_(convertido)_Moeda] [nchar](max) NULL,
	[Valor_(convertido)] [nchar](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Duração_da_fase] [bigint] NULL,
	[Proprietário_da_conta] [nchar](max) NULL,
	[Tipo_de_conta] [nchar](max) NULL,
	[Autoprodução] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [nchar](max) NULL,
	[Origem_da_Oportunidade] [nchar](max) NULL,
	[Nome_da_Consultoria] [nchar](max) NULL,
	[Cotação_em_andamento] [bigint] NULL,
	[Cotações] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [nchar](max) NULL,
	[N°_Proposta_Oportunidade] [nchar](max) NULL,
	[CNPJ] [nchar](max) NULL,
	[Credit_Rating] [nchar](max) NULL,
	[Credit_Rating_2] [nchar](max) NULL,
	[Origem] [nchar](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [nchar](max) NULL,
	[Produto_da_Oportunidade] [nchar](max) NULL,
	[Descrição] [nchar](max) NULL,
	[Descrição_da_conta] [nchar](max) NULL,
	[Origem_da_Oportunidade_2] [nchar](max) NULL,
	[Origem_Relatório] [nchar](max) NULL,
	[Origem_da_campanha_principal] [nchar](max) NULL,
	[Origem_2] [nchar](max) NULL,
	[Origem_Relatório_2] [nchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Inserindo dados na tabela manipulada a partir da tabela original
INSERT INTO [dbo].[Report_SalesForce_Criacao_Automatica_Uso_NCHAR]
SELECT * FROM [dbo].[Report_SalesForce_Criacao_Automatica]

-- Consulta para obter o espaço ocupado pelas tabelas
EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica'; 

EXEC sp_spaceused '[Report_SalesForce_Criacao_Automatica_Uso_NCHAR]'; 

-- Consulta para obter o número de páginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica';

-- Consulta para obter o número de páginas de dados da tabela com uso de NCHAR
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = '[Report_SalesForce_Criacao_Automatica_Uso_NCHAR]';
