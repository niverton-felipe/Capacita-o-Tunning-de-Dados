
--Tabela gen�rica gerada pelo python para armazenar os dados. 
--Objeto � criado para garantir que independente do tamanho do campo da tabela, o valor ser� armazenado sem erro.

CREATE TABLE [dbo].[Report_SalesForce_staging](
	[ID_da_oportunidade] [varchar](max) NULL,
	[Propriet�rio_da_oportunidade] [varchar](max) NULL,
	[Data_da_�ltima_mudan�a_de_fase] [varchar](max) NULL,
	[Data_da_�ltima_modifica��o] [varchar](max) NULL,
	[Cliente_Estrat�gico] [bigint] NULL,
	[Nome_da_conta] [varchar](max) NULL,
	[Nome_da_oportunidade] [varchar](max) NULL,
	[Fase] [varchar](max) NULL,
	[Motivo_da_perda] [varchar](max) NULL,
	[Gestor] [varchar](max) NULL,
	[Gestor_2] [varchar](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [varchar](max) NULL,
	[Dura��o] [bigint] NULL,
	[Data_de_fechamento] [varchar](max) NULL,
	[Data_de_cria��o] [varchar](max) NULL,
	[Pr�xima_etapa] [float] NULL,
	[Origem_do_lead] [varchar](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [varchar](max) NULL,
	[Criado_por] [varchar](max) NULL,
	[Modificado_pela_�ltima_vez_por] [varchar](max) NULL,
	[Valor_Moeda] [varchar](max) NULL,
	[Valor] [varchar](max) NULL,
	[�ltima_atividade] [varchar](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_cria��o] [varchar](max) NULL,
	[Valor_(convertido)_Moeda] [varchar](max) NULL,
	[Valor_(convertido)] [varchar](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Dura��o_da_fase] [bigint] NULL,
	[Propriet�rio_da_conta] [varchar](max) NULL,
	[Tipo_de_conta] [varchar](max) NULL,
	[Autoprodu��o] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [varchar](max) NULL,
	[Origem_da_Oportunidade] [varchar](max) NULL,
	[Nome_da_Consultoria] [varchar](max) NULL,
	[Cota��o_em_andamento] [bigint] NULL,
	[Cota��es] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [varchar](max) NULL,
	[N�_Proposta_Oportunidade] [varchar](max) NULL,
	[CNPJ] [varchar](max) NULL,
	[Credit_Rating] [varchar](max) NULL,
	[Credit_Rating_2] [varchar](max) NULL,
	[Origem] [varchar](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [varchar](max) NULL,
	[Produto_da_Oportunidade] [varchar](max) NULL,
	[Descri��o] [varchar](max) NULL,
	[Descri��o_da_conta] [varchar](max) NULL,
	[Origem_da_Oportunidade_2] [varchar](max) NULL,
	[Origem_Relat�rio] [varchar](max) NULL,
	[Origem_da_campanha_principal] [varchar](max) NULL,
	[Origem_2] [varchar](max) NULL,
	[Origem_Relat�rio_2] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


--Tabela projetada utilizando somente o tamanho necess�rio para cada campo e mantendo uma gordura saud�vel para os campos varchar
CREATE TABLE [bkp].[Report_SalesForce]
(
	[ID_da_oportunidade] [varchar](100) NULL,
	[Propriet�rio_da_oportunidade] [varchar](100) NULL,
	[Data_da_�ltima_mudan�a_de_fase] [date] NULL,
	[Data_da_�ltima_modifica��o] [date] NULL,
	[Cliente_Estrat�gico] [bit] NULL,
	[Nome_da_conta] [varchar](100) NULL,
	[Nome_da_oportunidade] [varchar](100) NULL,
	[Fase] [varchar](100) NULL,
	[Motivo_da_perda] [varchar](100) NULL,
	[Gestor] [varchar](100) NULL,
	[Gestor_2] [varchar](100) NULL,
	[Probabilidade_(%)] [smallint] NULL,
	[Tipo_Agente] [varchar](100) NULL,
	[Dura��o] [smallint] NULL,
	[Data_de_fechamento] [date] NULL,
	[Data_de_cria��o] [date] NULL,
	[Pr�xima_etapa] [varchar](100) NULL,
	[Origem_do_lead] [varchar](100) NULL,
	[Tipo] [varchar](100) NULL,
	[Moeda_da_oportunidade] [varchar](100) NULL,
	[Criado_por] [varchar](100) NULL,
	[Modificado_pela_�ltima_vez_por] [varchar](100) NULL,
	[Valor_Moeda] [varchar](100) NULL,
	[Valor] [decimal](18, 3) NULL,
	[�ltima_atividade] [date] NULL,
	[Tem_produtos] [bit] NULL,
	[Alias_de_cria��o] [varchar](100) NULL,
	[Valor_(convertido)_Moeda] [varchar](100) NULL,
	[Valor_(convertido)] [decimal](18, 3) NULL,
	[Fechado] [bit] NULL,
	[Ganhos] [bit] NULL,
	[Dura��o_da_fase] [smallint] NULL,
	[Propriet�rio_da_conta] [varchar](100) NULL,
	[Tipo_de_conta] [varchar](100) NULL,
	[Autoprodu��o] [bit] NULL,
	[Cross_Selling] [bit] NULL,
	[Tipo_de_Oportunidade] [varchar](100) NULL,
	[Origem_da_Oportunidade] [varchar](100) NULL,
	[Nome_da_Consultoria] [varchar](100) NULL,
	[Cota��o_em_andamento] [bit] NULL,
	[Cota��es] [bit] NULL,
	[Loss_Reason] [varchar](100) NULL,
	[Nome_Consultor] [varchar](100) NULL,
	[N�_Proposta_Oportunidade] [varchar](100) NULL,
	[CNPJ] [varchar](100) NULL,
	[Credit_Rating] [varchar](100) NULL,
	[Credit_Rating_2] [varchar](100) NULL,
	[Origem] [varchar](100) NULL,
	[Demanda_contratada_(KW)] [int] NULL,
	[ID_da_conta] [varchar](100) NULL,
	[Produto_da_Oportunidade] [varchar](100) NULL,
	[Descri��o] [varchar](500) NULL,
	[Descri��o_da_conta] [varchar](500) NULL,
	[Origem_da_Oportunidade_2] [varchar](100) NULL,
	[Origem_Relat�rio] [varchar](100) NULL,
	[Origem_da_campanha_principal] [varchar](100) NULL,
	[Origem_2] [varchar](100) NULL,
	[Origem_Relat�rio_2] [varchar](100) NULL
) ON [PRIMARY]
GO


-- Exibe informa��es sobre o espa�o utilizado pela tabela
EXEC sp_spaceused 'bkp.Report_SalesForce';

EXEC sp_spaceused 'Report_SalesForce_staging'; 


-- Consulta para obter o n�mero de p�ginas de dados da tabela gerada manualmente
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce';


-- Consulta para obter o n�mero de p�ginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_staging';