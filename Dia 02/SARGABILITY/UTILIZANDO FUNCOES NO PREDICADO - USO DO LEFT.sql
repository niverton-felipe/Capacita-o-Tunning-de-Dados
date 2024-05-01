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
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]

CREATE NONCLUSTERED INDEX INC_REPORT_SF_NOME
ON [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
([Proprietário_da_oportunidade])

SET STATISTICS IO ON

SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE Proprietário_da_oportunidade = 'André Souza'

SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE LEFT(Proprietário_da_oportunidade,5) = 'André'

SELECT 
[Proprietário_da_oportunidade]
FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Manual_Indexada]
WHERE [Proprietário_da_oportunidade] >= 'André' 
AND [Proprietário_da_oportunidade] < 'André!'