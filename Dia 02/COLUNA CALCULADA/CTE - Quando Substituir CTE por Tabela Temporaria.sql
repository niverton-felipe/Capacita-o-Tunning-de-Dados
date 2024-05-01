USE [Enel]
GO

/****** Object:  View [dbo].[vba_portfolio_ppa_portal_performance]    Script Date: 19/04/2024 12:07:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


SET STATISTICS IO ON

SELECT
	ID_VBA_Contratos_196,
	ID_VBA_Contratos_196_Persist,
	Codigo_WBC,
	Status,
	Ano,
	Mes,
	Valor_Ressarcimento,
	ID_Parte,
	ID_Contraparte,
	ID_Perfil_CCEE_vendedor,
	ID_Submercado,
	DT_Ini_Vig,
	DT_Fim_Vig,
	Data_Ref,
	Data_Criacao,
	data_fechamento,
	Data_publicacao,
	Valor_Financeiro_Realizado,
	Contrato_Original_Faturado,
	Nr_contrato_vinculado,
	FlexibilidadeMensalMax,
	FlexibilidadeMensalMin,
	Suprimento_inicio,
	Suprimento_termino,
	Quant_Contratada,
	Preco_base,
	ID_Tipo_Contrato,
	ID_Tipo_Agente_Comprador,
	Cenario,
	Movimentacao,
	Ramo_Atividade,
	ID_Portfolio_Comprador, 
	ID_Portfolio_Vendedor,
	Nome_Contrato,
	Perfil_CCEE_Vendedor,
	Submercado,
	Contraparte_Apelido,
	Segmento_Mercado,
	Regra_Preco,
	Form_Agio,
	QuantAtualizada,
	Quant_Sazonalizada,
	epai,
	Contraparte_Estado,
	Contrato_legado,
	Parte_Estado,
	ID_Status,
	Valor_financeiro_atualizado,
	Parte_apelido,
	Portfolio_Comprador,
	Portfolio_Vendedor,
	Tipo_contrato,
	Numero_referencia_contrato,
	Tipo_Agente_Comprador,
	Tipo_Agente_Vendedor,
	Agrupador,
	Data_assinatura,
	Classificador
INTO #TEMP_CONTRATOS
FROM
	VBA_Contratos_196 contratos 
where 
  contratos.DT_Fim_Vig > CONVERT(DATE, GETDATE() -10)

  --13min40seg

  --Quantidade de Páginas Retornadas 2084602
  --Table 'VBA_Contratos_196'. Scan count 1, logical reads 9325513, physical reads 406, read-ahead reads 153367, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
  -- 32 segundos para executar


  --Consulta principal
/*
(2857863 linhas afetadas)
Table 'tabela_horas'. Scan count 10, logical reads 10, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'dUF'. Scan count 2, logical reads 4, physical reads 1, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'VBA_Hierarquia_198'. Scan count 232, logical reads 1296, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 64, logical reads 12132, physical reads 0, read-ahead reads 131071, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table '#TEMP_CONTRATOS_____________________________________________________________________________________________________00000005FA31'. Scan count 10, logical reads 276678, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
*/

select CAST(CONCAT(z.[Ano], FORMAT(z.[Data_Rel],'MM'), z.[ID_Submercado], z.[ID_Fonte]) AS int) As ID_Produto,z.* from 
(
select
  contratos.Status,
  --contratos.Valor_financeiro_atualizado,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_financeiro_atualizado
	   END AS Valor_financeiro_atualizado,
  --contratos.Valor_Ressarcimento,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_Ressarcimento
	   END AS Valor_Ressarcimento,
  --iif(isNull(grupos_intrabook.agrupamento_empresa,'1')='1' AND contratos.ID_Parte <> contratos.ID_Contraparte,0,1) as Intercompany,
  (case
	WHEN iif(contratos.ID_Parte = contratos.ID_Contraparte, 1, 0) = 1 THEN 0
	ELSE iif(isNull(grupos_intrabook.agrupamento_empresa,'1')='1' AND contratos.ID_Parte <> contratos.ID_Contraparte,0,1)
  end) as Intercompany,
  contratos.[ID_Contraparte],
  contratos.[ID_Perfil_CCEE_vendedor] as [ID_Fonte],
  contratos.ID_Submercado,
  contratos.[Ano],
  contratos.[Mes],
  contratos.DT_Ini_Vig,
  contratos.DT_Fim_Vig,
  contratos.Data_Ref,
  contratos.Data_Criacao,
  contratos.data_fechamento,
  contratos.Data_publicacao,
  u.ID_UF,
  IIF(contratos.Valor_Financeiro_Realizado > 0 or contratos.Contrato_Original_Faturado = 1, 1, 0) As Contrato_Faturado,
  contratos.Nr_contrato_vinculado,
  contratos.FlexibilidadeMensalMax,
  contratos.FlexibilidadeMensalMin,
  --contratos.Valor_Financeiro_Realizado,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_Financeiro_Realizado
	   END AS Valor_Financeiro_Realizado,
  contratos.Suprimento_inicio,
  contratos.Suprimento_termino,
  --contratos.Quant_Contratada,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Quant_Contratada
	   END AS Quant_Contratada,
  --contratos.Preco_base,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Preco_base
	   END AS Preco_base,
  IIF (contratos.ID_Tipo_Contrato = 3 and contratos.ID_Tipo_Agente_Comprador = 1 and contratos.ID_Contraparte in (42, 794), contratos.ID_Tipo_Contrato * 1000, contratos.ID_Tipo_Contrato) as ID_Tipo_Contrato,   
  contratos.ID_Parte,
  IIF (contratos.ID_Tipo_Contrato = 3 and contratos.ID_Tipo_Agente_Comprador = 1 and contratos.ID_Contraparte in (42, 794), 'Bilateral - GD', contratos.Tipo_Contrato) as Tipo_Contrato, 
  horasMes.Horas,
  dateadd(day, 0, dateadd(month, contratos.[Mes]-1, dateadd(year, contratos.[ano]-1900, 0))) As [Data_Rel],
  contratos.[Cenario],
  coalesce(grupos.nivel5Nome_empresa, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel5,  --ajuste realizado por Níverton Felipe no dia 21/06/2023 a pedido do Alvaro devido a alteração nos exportadores de Hierarquia que trouxe um novo nível (5).
  coalesce(grupos.empresa_nome, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel4, 
  coalesce(grupos.agrupamento_empresa, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel3,
  coalesce(grupos.link2, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel2,
  coalesce(grupos.grupo, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel1,
  contratos.Movimentacao,
  contratos.Ramo_Atividade, 
  iif([Movimentacao]='Compra', [ID_Portfolio_Comprador], [ID_Portfolio_Vendedor]) as [ID_Portfolio],
  iif([Movimentacao]='Compra', [Portfolio_Comprador], [Portfolio_Vendedor]) as [Portfolio],
  contratos.ID_VBA_Contratos_196 * 10 as ID_VBA_Contratos_196,  -- Termina com 0
  contratos.ID_VBA_Contratos_196_Persist,
  contratos.Nome_Contrato,
  contratos.Codigo_WBC as Codigo_WBC, -- Termina com 0
  contratos.Perfil_CCEE_Vendedor as [Fonte],
  contratos.[Submercado],
  contratos.Contraparte_Apelido As [Contraparte],
  --iif(contratos.[Tipo_contrato]='Bilateral', 'ACL', 'ACR') as [Ambiente],

  IIF (contratos.ID_Tipo_Contrato = 3 
		and contratos.ID_Tipo_Agente_Comprador = 1 
		and contratos.ID_Contraparte in (42, 794), 'ACR', 
	iif(contratos.[Tipo_contrato]='Bilateral', 'ACL', 'ACR')) as [Ambiente],

  contratos.Segmento_Mercado,
  contratos.Regra_Preco,
  contratos.Form_Agio,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE iif(contratos.ID_Tipo_Contrato = 55,  -- Contrato de Cotas Quantidade 1 porque o valor financeiro está na RAG  @TODO: Verificar se desta maneira atende ou se precisa pegar a GF Cotas
			nullif(COALESCE(contratos.QuantAtualizada, contratos.[Quant_Sazonalizada], contratos.quant_contratada),1) ,
			QuantAtualizada) 
	   END as [Quantidade_MWh],
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE iif(contratos.ID_Tipo_Contrato = 55,  -- Contrato de Cotas Quantidade 1 porque o valor financeiro está na RAG  @TODO: Verificar se desta maneira atende ou se precisa pegar a GF Cotas
			nullif(COALESCE(contratos.QuantAtualizada, contratos.[Quant_Sazonalizada], contratos.quant_contratada),1) ,
			QuantAtualizada) / horasMes.horas 
	   END as [Quantidade_MWm],
  iif(contratos.ID_Parte = contratos.ID_Contraparte, 1, 0) as Intrabook,
  contratos.epai,
  contratos.Contraparte_Estado,
  contratos.Contrato_legado
from
  ((#TEMP_CONTRATOS contratos 
        left join VBA_portfolio_grupos grupos on contratos.Id_parte=grupos.nivel5Id_empresa)
        left join tabela_horas horasMes on dateadd(day, 0, dateadd(month, contratos.[Mes]-1, dateadd(year, contratos.[ano]-1900, 0))) = dateadd(day, 0, dateadd(month, horasMes.[Mês]-1, dateadd(year, horasMes.[ano]-1900, 0))))
        left join VBA_portfolio_grupos grupos_intrabook on contratos.Id_contraparte=grupos_intrabook.nivel5Id_empresa
		left join dUF u  on u.UF = contratos.Parte_Estado
where 
  contratos.ID_Tipo_Contrato <> 99  AND
  contratos.Ano >= 2020 and 
  contratos.ID_Status<>1
  and (contratos.Valor_Financeiro_Realizado > 0 or contratos.status <> 'Rescindido' or contratos.Contrato_Original_Faturado = 1)
  --and epai <> 1  -- remove os contratos pais do join
  --remove os contratos gama
  and not ((contratos.[Ano] > 2020 OR (contratos.[Ano] = 2019 AND contratos.[Mes] > 5 ))
  and contratos.[ID_Parte] IN (756, 1205, 1206, 1207, 1208, 1209, 1210, 1218, 1219, 1220, 1221, 1226, 1227, 1229, 730, 728))

union

/* Mesma query que a de cima porém quando for 'venda' vira 'compra' e 'compra' vira 'venda' 
  Isto serve para considerar as duas pontas de Intrabooks */ 

select 
  contratos.Status,
  --contratos.Valor_financeiro_atualizado,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_financeiro_atualizado
	   END AS Valor_financeiro_atualizado,
  --contratos.Valor_Ressarcimento,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_Ressarcimento
	   END AS Valor_Ressarcimento,
  --iif(isNull(grupos_intrabook.agrupamento_empresa,'1')='1' AND contratos.ID_Parte <> contratos.ID_Contraparte,0,1) as Intercompany,
  (case
	WHEN iif(contratos.ID_Parte = contratos.ID_Contraparte, 1, 0) = 1 THEN 0
	ELSE iif(isNull(grupos_intrabook.agrupamento_empresa,'1')='1' AND contratos.ID_Parte <> contratos.ID_Contraparte,0,1)
  end) as Intercompany,
  contratos.[ID_Contraparte],
  contratos.[ID_Perfil_CCEE_Vendedor] as [ID_Fonte],
  contratos.ID_Submercado,
  contratos.[Ano],
  contratos.[Mes],
  contratos.DT_Ini_Vig,
  contratos.DT_Fim_Vig,
  contratos.Data_ref,
  contratos.Data_Criacao,
  contratos.data_fechamento,
  contratos.Data_publicacao,
  u.ID_UF,
  IIF(contratos.Valor_Financeiro_Realizado > 0 or contratos.Contrato_Original_Faturado = 1, 1, 0) As Contrato_Faturado,
  contratos.Nr_contrato_vinculado,
  contratos.FlexibilidadeMensalMax,
  contratos.FlexibilidadeMensalMin,
  --contratos.Valor_Financeiro_Realizado,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Valor_Financeiro_Realizado
	   END AS Valor_Financeiro_Realizado,
  contratos.Suprimento_inicio,
  contratos.Suprimento_termino,
  --contratos.Quant_Contratada,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Quant_Contratada
	   END AS Quant_Contratada,
  --contratos.Preco_base,
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE contratos.Preco_base
	   END AS Preco_base,
  IIF (contratos.ID_Tipo_Contrato = 3 and contratos.ID_Tipo_Agente_Comprador = 1 and contratos.ID_Contraparte in (42, 794), contratos.ID_Tipo_Contrato * 1000, contratos.ID_Tipo_Contrato) as ID_Tipo_Contrato,   
  contratos.ID_Parte,
  IIF (contratos.ID_Tipo_Contrato = 3 and contratos.ID_Tipo_Agente_Comprador = 1 and contratos.ID_Contraparte in (42, 794), 'Bilateral - GD', contratos.Tipo_Contrato) as Tipo_Contrato, 
  horasMes.Horas,
  dateadd(day, 0, dateadd(month, contratos.[Mes]-1, dateadd(year, contratos.[ano]-1900, 0))) As [Data_Rel],
  contratos.[Cenario],
  --contratos.Parte_apelido as Empresa_Nivel5, --grupos.nivel5Nome_empresa as Empresa_Nivel5, --ajuste realizado por Níverton Felipe no dia 21/06/2023 a pedido do Alvaro devido a alteração nos exportadores de Hierarquia que trouxe um novo nível (5).
  --grupos.empresa_nome as Empresa_Nivel4, --grupos.nivel5Nome_empresa as Empresa_Nivel5, --ajuste realizado por Níverton Felipe no dia 21/06/2023 a pedido do Alvaro devido a alteração nos exportadores de Hierarquia que trouxe um novo nível (5).
  --grupos.agrupamento_empresa as Empresa_Nivel3,
  --grupos.link2 as Empresa_Nivel2,
  --grupos.grupo as Empresa_Nivel1,
  coalesce(grupos.nivel5Nome_empresa, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel5,  --ajuste realizado por Níverton Felipe no dia 21/06/2023 a pedido do Alvaro devido a alteração nos exportadores de Hierarquia que trouxe um novo nível (5).
  coalesce(grupos.empresa_nome, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel4, 
  coalesce(grupos.agrupamento_empresa, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel3,
  coalesce(grupos.link2, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel2,
  coalesce(grupos.grupo, concat('#Empresa Fora da Hierarquia: ', contratos.Parte_apelido)) as Empresa_Nivel1,
  iif(contratos.Movimentacao='Compra', 'Venda', 'Compra') as [Movimentacao], -- inverte essa ponta
  contratos.Ramo_Atividade,
  iif([Movimentacao]='Compra', [ID_Portfolio_Vendedor], [ID_Portfolio_Comprador]) as [ID_Portfolio], -- inverte essa ponta
  iif([Movimentacao]='Compra', [Portfolio_Vendedor], [Portfolio_Comprador]) as [Portfolio], -- inverte essa ponta
  contratos.ID_VBA_Contratos_196 * 10 + 1 as ID_VBA_Contratos_196, -- Termina com 1
  contratos.ID_VBA_Contratos_196_Persist,
  contratos.Nome_contrato, 
  contratos.Codigo_WBC + 1 as Codigo_WBC, -- Termina com 1
  contratos.[Perfil_CCEE_Vendedor] as [Fonte],
  contratos.[Submercado], 
  contratos.Contraparte_apelido as [Contraparte], 
  --iif(contratos.[Tipo_contrato]='Bilateral', 'ACL', 'ACR') as [Ambiente],

  IIF (contratos.ID_Tipo_Contrato = 3 
		and contratos.ID_Tipo_Agente_Comprador = 1 
		and contratos.ID_Contraparte in (42, 794), 'ACR', 
	iif(contratos.[Tipo_contrato]='Bilateral', 'ACL', 'ACR')) as [Ambiente],

  contratos.Segmento_Mercado, 
  contratos.Regra_Preco,
  contratos.Form_Agio,

  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE iif(contratos.ID_Tipo_Contrato = 55,  -- Contrato de Cotas Quantidade 1 porque o valor financeiro está na RAG  @TODO: Verificar se desta maneira atende ou se precisa pegar a GF Cotas
			nullif(COALESCE(contratos.QuantAtualizada, contratos.[Quant_Sazonalizada], contratos.quant_contratada),1) ,
			QuantAtualizada) 
	   END as [Quantidade_MWh],
  CASE WHEN (contratos.Ano >= 2022 AND contratos.Mes >= 9 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
		 OR (contratos.Ano > 2022 AND contratos.Codigo_WBC IN (5212420,5213020,5501220,6575120,6575320,6575520,6575720,6575920,6576120,6576320,6576520,6576720,6576920,6577120))
	   THEN 0
	   ELSE iif(contratos.ID_Tipo_Contrato = 55,  -- Contrato de Cotas Quantidade 1 porque o valor financeiro está na RAG  @TODO: Verificar se desta maneira atende ou se precisa pegar a GF Cotas
			nullif(COALESCE(contratos.QuantAtualizada, contratos.[Quant_Sazonalizada], contratos.quant_contratada),1) ,
			QuantAtualizada) / horasMes.horas 
	   END as [Quantidade_MWm],
  iif(contratos.ID_Parte = contratos.ID_Contraparte, 1, 0) as Intrabook,
  contratos.epai,
  contratos.Contraparte_Estado,
  contratos.Contrato_legado
from 
  ((#TEMP_CONTRATOS contratos 
        left join VBA_portfolio_grupos grupos on contratos.Id_parte=grupos.nivel5Id_empresa)
        left join tabela_horas horasMes on dateadd(day, 0, dateadd(month, contratos.[Mes]-1, dateadd(year, contratos.[ano]-1900, 0))) = dateadd(day, 0, dateadd(month, horasMes.[Mês]-1, dateadd(year, horasMes.[ano]-1900, 0)))
        left join VBA_portfolio_grupos grupos_intrabook on contratos.Id_contraparte=grupos_intrabook.nivel5Id_empresa)
		left join dUF u  on u.UF = contratos.Parte_Estado

where 
  contratos.ID_Parte = contratos.ID_Contraparte and 
  -- ID_TIPO_CONTRATO '99' corresponde aos contratos PROINFA e que não devem ser considerados na View de Contratos
  contratos.ID_Tipo_Contrato <> 99  and
  contratos.Ano >= 2020 and 
  contratos.ID_Status<>1 
  and (contratos.Valor_Financeiro_Realizado > 0 or contratos.status <> 'Rescindido' or contratos.Contrato_Original_Faturado = 1)
  --and epai <> 1 -- remove os contratos filhos do join

) z
GO


