--------------------------- ENTENDENDO O EFEITO DO USO DO CHAR ------------------------
/*
  No tipo de dados VARCHAR cada caractere ocupa 1 byte, por�m, este espa�o n�o � ocupado de maneira fixo. Ou seja, 
  um campo definido como VARCHAR(100) s� ocupar� 100 bytes caso o valor passado tenha 100 caracteres. 
  Este mesmo campo definido com o tipo CHAR(100) ocuparia 100 bytes independente do tamanho do texto.
  Vamos acompanhar de maneira pr�tica como isso acaba interferindo no consumo de espa�o da tabela e consequentemente 
  no tempo de leitura das queries.
*/

--Cria��o da tabela substituindo os campos VARCHAR por CHAR

CREATE TABLE [dbo].[Report_SalesForce_Criacao_Automatica_Uso_CHAR](
	[ID_da_oportunidade] [char](max) NULL,
	[Propriet�rio_da_oportunidade] [char](max) NULL,
	[Data_da_�ltima_mudan�a_de_fase] [char](max) NULL,
	[Data_da_�ltima_modifica��o] [char](max) NULL,
	[Cliente_Estrat�gico] [bigint] NULL,
	[Nome_da_conta] [char](max) NULL,
	[Nome_da_oportunidade] [char](max) NULL,
	[Fase] [char](max) NULL,
	[Motivo_da_perda] [char](max) NULL,
	[Gestor] [char](max) NULL,
	[Gestor_2] [char](max) NULL,
	[Probabilidade_(%)] [bigint] NULL,
	[Tipo_Agente] [char](max) NULL,
	[Dura��o] [bigint] NULL,
	[Data_de_fechamento] [char](max) NULL,
	[Data_de_cria��o] [char](max) NULL,
	[Pr�xima_etapa] [float] NULL,
	[Origem_do_lead] [char](max) NULL,
	[Tipo] [float] NULL,
	[Moeda_da_oportunidade] [char](max) NULL,
	[Criado_por] [char](max) NULL,
	[Modificado_pela_�ltima_vez_por] [char](max) NULL,
	[Valor_Moeda] [char](max) NULL,
	[Valor] [char](max) NULL,
	[�ltima_atividade] [char](max) NULL,
	[Tem_produtos] [bigint] NULL,
	[Alias_de_cria��o] [char](max) NULL,
	[Valor_(convertido)_Moeda] [char](max) NULL,
	[Valor_(convertido)] [char](max) NULL,
	[Fechado] [bigint] NULL,
	[Ganhos] [bigint] NULL,
	[Dura��o_da_fase] [bigint] NULL,
	[Propriet�rio_da_conta] [char](max) NULL,
	[Tipo_de_conta] [char](max) NULL,
	[Autoprodu��o] [bigint] NULL,
	[Cross_Selling] [bigint] NULL,
	[Tipo_de_Oportunidade] [char](max) NULL,
	[Origem_da_Oportunidade] [char](max) NULL,
	[Nome_da_Consultoria] [char](max) NULL,
	[Cota��o_em_andamento] [bigint] NULL,
	[Cota��es] [bigint] NULL,
	[Loss_Reason] [float] NULL,
	[Nome_Consultor] [char](max) NULL,
	[N�_Proposta_Oportunidade] [char](max) NULL,
	[CNPJ] [char](max) NULL,
	[Credit_Rating] [char](max) NULL,
	[Credit_Rating_2] [char](max) NULL,
	[Origem] [char](max) NULL,
	[Demanda_contratada_(KW)] [float] NULL,
	[ID_da_conta] [char](max) NULL,
	[Produto_da_Oportunidade] [char](max) NULL,
	[Descri��o] [char](max) NULL,
	[Descri��o_da_conta] [char](max) NULL,
	[Origem_da_Oportunidade_2] [char](max) NULL,
	[Origem_Relat�rio] [char](max) NULL,
	[Origem_da_campanha_principal] [char](max) NULL,
	[Origem_2] [char](max) NULL,
	[Origem_Relat�rio_2] [char](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Inserindo dados na tabela manipulada a partir da tabela original
INSERT INTO [dbo].[Report_SalesForce_Criacao_Automatica_Uso_CHAR]
SELECT * FROM [dbo].[Report_SalesForce_Criacao_Automatica]

-- Consulta para obter o espa�o ocupado pelas tabelas
EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica'; 

EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica_Uso_CHAR'; 

-- Consulta para obter o n�mero de p�ginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica';

-- Consulta para obter o n�mero de p�ginas de dados da tabela com uso de CHAR
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica_Uso_CHAR';
