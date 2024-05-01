/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [ID_da_oportunidade]
      ,[Proprietário_da_oportunidade]
      ,[Data_da_última_mudança_de_fase]
      ,[Data_da_última_modificação]
      ,[Cliente_Estratégico]
      ,[Nome_da_conta]
      ,[Nome_da_oportunidade]
      ,[Fase]
      ,[Motivo_da_perda]
      ,[Gestor]
      ,[Gestor_2]
      ,[Probabilidade_(%)]
      ,[Tipo_Agente]
      ,[Duração]
      ,[Data_de_fechamento]
      ,[Data_de_criação]
      ,[Próxima_etapa]
      ,[Origem_do_lead]
      ,[Tipo]
      ,[Moeda_da_oportunidade]
      ,[Criado_por]
      ,[Modificado_pela_última_vez_por]
      ,[Valor_Moeda]
      ,[Valor]
      ,[Última_atividade]
      ,[Tem_produtos]
      ,[Alias_de_criação]
      ,[Valor_(convertido)_Moeda]
      ,[Valor_(convertido)]
      ,[Fechado]
      ,[Ganhos]
      ,[Duração_da_fase]
      ,[Proprietário_da_conta]
      ,[Tipo_de_conta]
      ,[Autoprodução]
      ,[Cross_Selling]
      ,[Tipo_de_Oportunidade]
      ,[Origem_da_Oportunidade]
      ,[Nome_da_Consultoria]
      ,[Cotação_em_andamento]
      ,[Cotações]
      ,[Loss_Reason]
      ,[Nome_Consultor]
      ,[N°_Proposta_Oportunidade]
      ,[CNPJ]
      ,[Credit_Rating]
      ,[Credit_Rating_2]
      ,[Origem]
      ,[Demanda_contratada_(KW)]
      ,[ID_da_conta]
      ,[Produto_da_Oportunidade]
      ,[Descrição]
      ,[Descrição_da_conta]
      ,[Origem_da_Oportunidade_2]
      ,[Origem_Relatório]
      ,[Origem_da_campanha_principal]
      ,[Origem_2]
      ,[Origem_Relatório_2]
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual]


 SELECT COUNT(DISTINCT e.[N°_Proposta_Oportunidade]) AS DistinctColValues,
 COUNT(e.[N°_Proposta_Oportunidade]) AS NumberOfRows,
 (CAST(COUNT(DISTINCT e.[N°_Proposta_Oportunidade]) AS DECIMAL)
 / CAST(COUNT(e.[N°_Proposta_Oportunidade]) AS DECIMAL)) AS Selectivity,
 (1.0 / (COUNT(DISTINCT e.[N°_Proposta_Oportunidade]))) AS Density
FROM [dbo].[Report_SalesForce_Criacao_Manual] AS e;

CREATE NONCLUSTERED INDEX INC_NUMERO_PROPOSTA
ON [dbo].[Report_SalesForce_Criacao_Manual] ([N°_Proposta_Oportunidade])

CREATE NONCLUSTERED INDEX INC_CLIENTE_ESTRATEGICO
ON [dbo].[Report_SalesForce_Criacao_Manual] ([Cliente_Estratégico])


 SELECT COUNT(DISTINCT e.[Cliente_Estratégico]) AS DistinctColValues,
 COUNT(e.[Cliente_Estratégico]) AS NumberOfRows,
 (CAST(COUNT(DISTINCT e.[Cliente_Estratégico]) AS DECIMAL)
 / CAST(COUNT(e.[Cliente_Estratégico]) AS DECIMAL)) AS Selectivity,
 (1.0 / (COUNT(DISTINCT e.[Cliente_Estratégico]))) AS Density
FROM [dbo].[Report_SalesForce_Criacao_Manual] AS e;

SET STATISTICS TIME ON
SET STATISTICS IO ON

--Avaliando quantidade de leituras utilizando o índice do campo Cliente_Estratégico
SELECT
[N°_Proposta_Oportunidade],
[Cliente_Estratégico]
FROM [dbo].[Report_SalesForce_Criacao_Manual]
WHERE [N°_Proposta_Oportunidade] = 'ENELPV06921-22'

--Avaliando quantidade de leituras utilizando o índice do campo Cliente_Estratégico
SELECT
[Cliente_Estratégico],
[N°_Proposta_Oportunidade]
FROM [dbo].[Report_SalesForce_Criacao_Manual]
WHERE [Cliente_Estratégico] = 1

--Avaliando número de páginas de cada índice criado
SELECT i.name,
 i.type_desc,
 ddips.page_count,
 ddips.record_count,
 ddips.index_level
FROM sys.indexes i
 JOIN sys.dm_db_index_physical_stats( DB_ID(N'AdventureWorks2022'),
 OBJECT_ID(N'dbo.Report_SalesForce_Criacao_Manual'),
NULL,
NULL,
'DETAILED'
 ) AS ddips
 ON i.index_id = ddips.index_id
WHERE i.object_id = OBJECT_ID(N'dbo.Report_SalesForce_Criacao_Manual');