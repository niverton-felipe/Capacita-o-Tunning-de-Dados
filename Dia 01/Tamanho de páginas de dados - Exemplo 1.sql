
--Tabela genérica gerada pelo python para armazenar os dados. 
--Objeto é criado para garantir que independente do tamanho do campo da tabela, o valor será armazenado sem erro.

CREATE TABLE [dbo].[Report_SalesForce_staging](
	[ID_da_oportunidade] [varchar](max) NULL,
	[Proprietário_da_oportunidade] [varchar](max) NULL,
	[Data_da_última_mudança_de_fase] [varchar](max) NULL,
	[Data_da_última_modificação] [varchar](max) NULL,
	[Cliente_Estratégico] [bigint] NULL,
	[Nome_da_conta] [varchar](max) NULL,
	[Nome_da_oportunidade] [varchar](max) NULL,
	[Fase] [varchar](max) NULL,
	[Motivo_da_perda] [varchar](max) NULL,
	[Gestor] [varchar](max) NULL,
	[Gestor_2] [varchar](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [varchar](max) NULL,
	[Duração] [bigint] NULL,
	[Data_de_fechamento] [varchar](max) NULL,
	[Data_de_criação] [varchar](max) NULL,
	[Próxima_etapa] [float] NULL,
	[Origem_do_lead] [varchar](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [varchar](max) NULL,
	[Criado_por] [varchar](max) NULL,
	[Modificado_pela_última_vez_por] [varchar](max) NULL,
	[Valor_Moeda] [varchar](max) NULL,
	[Valor] [varchar](max) NULL,
	[Última_atividade] [varchar](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_criação] [varchar](max) NULL,
	[Valor_(convertido)_Moeda] [varchar](max) NULL,
	[Valor_(convertido)] [varchar](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Duração_da_fase] [bigint] NULL,
	[Proprietário_da_conta] [varchar](max) NULL,
	[Tipo_de_conta] [varchar](max) NULL,
	[Autoprodução] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [varchar](max) NULL,
	[Origem_da_Oportunidade] [varchar](max) NULL,
	[Nome_da_Consultoria] [varchar](max) NULL,
	[Cotação_em_andamento] [bigint] NULL,
	[Cotações] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [varchar](max) NULL,
	[N°_Proposta_Oportunidade] [varchar](max) NULL,
	[CNPJ] [varchar](max) NULL,
	[Credit_Rating] [varchar](max) NULL,
	[Credit_Rating_2] [varchar](max) NULL,
	[Origem] [varchar](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [varchar](max) NULL,
	[Produto_da_Oportunidade] [varchar](max) NULL,
	[Descrição] [varchar](max) NULL,
	[Descrição_da_conta] [varchar](max) NULL,
	[Origem_da_Oportunidade_2] [varchar](max) NULL,
	[Origem_Relatório] [varchar](max) NULL,
	[Origem_da_campanha_principal] [varchar](max) NULL,
	[Origem_2] [varchar](max) NULL,
	[Origem_Relatório_2] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


--Tabela projetada utilizando somente o tamanho necessário para cada campo e mantendo uma gordura saudável para os campos varchar
CREATE TABLE [bkp].[Report_SalesForce]
(
	[ID_da_oportunidade] [varchar](100) NULL,
	[Proprietário_da_oportunidade] [varchar](100) NULL,
	[Data_da_última_mudança_de_fase] [date] NULL,
	[Data_da_última_modificação] [date] NULL,
	[Cliente_Estratégico] [bit] NULL,
	[Nome_da_conta] [varchar](100) NULL,
	[Nome_da_oportunidade] [varchar](100) NULL,
	[Fase] [varchar](100) NULL,
	[Motivo_da_perda] [varchar](100) NULL,
	[Gestor] [varchar](100) NULL,
	[Gestor_2] [varchar](100) NULL,
	[Probabilidade_(%)] [smallint] NULL,
	[Tipo_Agente] [varchar](100) NULL,
	[Duração] [smallint] NULL,
	[Data_de_fechamento] [date] NULL,
	[Data_de_criação] [date] NULL,
	[Próxima_etapa] [varchar](100) NULL,
	[Origem_do_lead] [varchar](100) NULL,
	[Tipo] [varchar](100) NULL,
	[Moeda_da_oportunidade] [varchar](100) NULL,
	[Criado_por] [varchar](100) NULL,
	[Modificado_pela_última_vez_por] [varchar](100) NULL,
	[Valor_Moeda] [varchar](100) NULL,
	[Valor] [decimal](18, 3) NULL,
	[Última_atividade] [date] NULL,
	[Tem_produtos] [bit] NULL,
	[Alias_de_criação] [varchar](100) NULL,
	[Valor_(convertido)_Moeda] [varchar](100) NULL,
	[Valor_(convertido)] [decimal](18, 3) NULL,
	[Fechado] [bit] NULL,
	[Ganhos] [bit] NULL,
	[Duração_da_fase] [smallint] NULL,
	[Proprietário_da_conta] [varchar](100) NULL,
	[Tipo_de_conta] [varchar](100) NULL,
	[Autoprodução] [bit] NULL,
	[Cross_Selling] [bit] NULL,
	[Tipo_de_Oportunidade] [varchar](100) NULL,
	[Origem_da_Oportunidade] [varchar](100) NULL,
	[Nome_da_Consultoria] [varchar](100) NULL,
	[Cotação_em_andamento] [bit] NULL,
	[Cotações] [bit] NULL,
	[Loss_Reason] [varchar](100) NULL,
	[Nome_Consultor] [varchar](100) NULL,
	[N°_Proposta_Oportunidade] [varchar](100) NULL,
	[CNPJ] [varchar](100) NULL,
	[Credit_Rating] [varchar](100) NULL,
	[Credit_Rating_2] [varchar](100) NULL,
	[Origem] [varchar](100) NULL,
	[Demanda_contratada_(KW)] [int] NULL,
	[ID_da_conta] [varchar](100) NULL,
	[Produto_da_Oportunidade] [varchar](100) NULL,
	[Descrição] [varchar](500) NULL,
	[Descrição_da_conta] [varchar](500) NULL,
	[Origem_da_Oportunidade_2] [varchar](100) NULL,
	[Origem_Relatório] [varchar](100) NULL,
	[Origem_da_campanha_principal] [varchar](100) NULL,
	[Origem_2] [varchar](100) NULL,
	[Origem_Relatório_2] [varchar](100) NULL
) ON [PRIMARY]
GO


-- Exibe informações sobre o espaço utilizado pela tabela
EXEC sp_spaceused 'bkp.Report_SalesForce';

EXEC sp_spaceused 'Report_SalesForce_staging'; 


-- Consulta para obter o número de páginas de dados da tabela gerada manualmente
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce';


-- Consulta para obter o número de páginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_staging';