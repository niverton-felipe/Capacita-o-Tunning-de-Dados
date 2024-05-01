;WITH CTE_NUMERO_REFERENCIA_CONTRATO AS (
SELECT
contratos.Numero_referencia_contrato
,Suprimento_inicio
,Suprimento_termino
,CONVERT(DATE,Data_fechamento) Data_fechamento
,(CASE
	WHEN (FlexibilidadeMensalMax = 0 AND FlexibilidadeMensalMin = 0) THEN 'FLAT'
	ELSE CONCAT('+/- ',CONCAT(CAST(FlexibilidadeMensalMin AS INT),'%'))
 END)AS FLEXIBILIDADE_MENSAL
,pgto.Data_Pagamento_Final								    				    AS VENCIMENTO_NF
,CONCAT(pgto.Data_Pagamento_Final,'. ',pgto.Enf_Final)						    AS CONDICAO_PAGAMENTO_OBSERVACAO
,(CASE 
	WHEN PERFIL_CCEE_VENDEDOR = 'Convencional' THEN 'Não Aplicável' 
	ELSE CONCAT('R$',CAST([Valor_TRU] AS FLOAT),'/MWh') 
 END)																		    AS RE_TUSD_TRU
, ROW_NUMBER() OVER (PARTITION BY contratos.numero_referencia_contrato ORDER BY ANO, MES) AS RN
FROM VBA_Contratos_196 contratos
INNER JOIN #TEMP_NOVAS_MINUTAS novos ON contratos.Numero_referencia_contrato = novos.Numero_referencia_contrato
-- Considera apenas as minutas que tiveram vigência. Ajustado por nível para começar a considerar as minutas cujo pai teve primeira vigência igual a @DATA_INI_VIG
LEFT JOIN Docusign.dCondicao_Pagamento pgto ON contratos.Condicao_pagto = pgto.Condicao_pagto
WHERE DT_Fim_Vig = '9999-12-31'
AND Nr_contrato_vinculado IS NULL
AND Id_parte <> Id_contraparte																															 -- Retira Intrabooks
AND (Id_parte NOT IN (select id_empresa from Enel.dbo.VBA_Hierarquia_198) OR Id_contraparte NOT IN (select id_empresa from Enel.dbo.VBA_Hierarquia_198)) -- Retira Intercompanies
AND ID_Tipo_Contrato = 3                                                                                                                                 -- Apenas Contratos Livre_ACL
AND ID_Contraparte NOT in (42, 794)																														 -- retira os contratos Regulados_ACR que tem essas contrapartes e id_tipo_Contrato = 3
AND Contrato_legado IS NULL
AND RIGHT(contratos.Codigo_WBC,2) = '20'
)


SELECT DISTINCT

------------------------------------- DADOS INICIAIS --------------------------------------------------

--'Compradoras e Unidades'													AS TIPO_MINUTA
contratos.Numero_referencia_contrato										AS CODIGO_ENEL
,(CASE 
	WHEN contratos.Nr_contrato_vinculado IS NULL THEN contratos.Codigo_WBC 
	ELSE contratos.Nr_contrato_vinculado
 END)																		AS CODIGO_CONTRATO_WBC
,'Finalizado'   															AS STATUS_WBC

------------------------------------- ENTIDADES --------------------------------------------------------------

,(CASE WHEN Movimentacao = 'Compra' THEN 'Compradora' ELSE 'Vendedora' END)									AS ENTIDADE_TIPO
--,vendedores.VENDEDOR_RESPONSAVEL																			AS VENDEDOR_RESPONSAVEL
,(CASE WHEN Movimentacao = 'Compra' THEN Contraparte_apelido ELSE Parte_apelido END)						AS ENTIDADE_NOME
,(CASE WHEN Movimentacao = 'Compra' THEN contraparte_razao_social ELSE Parte_razao_social END)				AS ENTIDADE_RAZAO_SOCIAL_EMPRESA
,(CASE WHEN Movimentacao = 'Compra' THEN Contraparte_CNPJ ELSE Parte_CNPJ END)								AS ENTIDADE_CNPJ
,(CASE WHEN Movimentacao = 'Compra' THEN Contraparte_Inscricao_Estadual ELSE Parte_Inscricao_Estadual END)  AS ENTIDADE_INSCRICAO_ESTADUAL
,(CASE WHEN Movimentacao = 'Compra' 
	THEN REPLACE(CONCAT(Contraparte_Endereco,', Nº ',Contraparte_numero,', ',Contraparte_Complemento,', ',Contraparte_Bairro,', ',Contraparte_Cidade,', ',Contraparte_Estado,', CEP:',Contraparte_CEP),', ,',',') 
	ELSE REPLACE(CONCAT(Parte_Endereco,', Nº ',Parte_numero,', ',Parte_Complemento,', ',Parte_Bairro,', ',Parte_Cidade,', ',Parte_Estado,', CEP:',Parte_CEP),', ,',',')  END)
																											AS ENTIDADE_ENDERECO
,[Tipo_Agente_Vendedor]

,MONTH(Reajuste_Data)			 AS MÊS_REAJUSTE
,Reajuste_Periodicidade			 AS PERIODICIDADE_REAJUSTE
--,RIGHT(FORMAT(Reajuste_Data_primeiro_reajuste, 'D', 'pt-BR'), 
--LEN(FORMAT(Reajuste_Data_primeiro_reajuste, 'D', 'pt-BR')) - (CHARINDEX(',', FORMAT(Reajuste_Data_primeiro_reajuste, 'D', 'pt-BR')) + 1)
--)								 AS DATA_PRIMEIRO_REAJUSTE
,Reajuste_Data_primeiro_reajuste AS DATA_PRIMEIRO_REAJUSTE
,bg.RATING						 AS RATING
,'Teste'						 AS ICMS

INTO #BASE_RAIZ
FROM Enel.dbo.VBA_Contratos_196 contratos WITH (NOLOCK)

INNER JOIN #TEMP_NOVAS_MINUTAS novos ON contratos.Numero_referencia_contrato = novos.Numero_referencia_contrato 
-- Considera apenas as minutas que tiveram vigência. Ajustado por nível para começar a considerar as minutas cujo pai teve primeira vigência igual a @DATA_INI_VIG

INNER JOIN (
	select Ano, Mês, horas	from Enel.dbo.tabela_horas horasMes WITH (NOLOCK)
	where dt_fim_vigencia = '9999-12-31'
)h ON h.Ano = contratos.Ano AND h.Mês = contratos.Mes

LEFT JOIN (SELECT DISTINCT Nr_contrato_vinculado FROM [Enel].[dbo].[VBA_Contratos_196] WHERE Nr_contrato_vinculado IS NOT NULL AND dt_fim_vig = '9999-12-31') v ON v.Nr_contrato_vinculado = contratos.Codigo_WBC

LEFT JOIN (
	  SELECT DISTINCT [Codigo_Empresa],[Banco],[Agencia],[Numero_da_conta],[Tipo_de_conta],[Titular]
	  FROM [Enel].[dbo].[VBA_EMP_DADOS_BANCARIOS]
	  WHERE DT_Fim_Vig = '9999-12-31'
) db ON db.[Codigo_Empresa] = contratos.Id_parte

LEFT JOIN #BASE_VALOR_GLOBAL vg ON vg.Codigo_WBC = contratos.Codigo_WBC
LEFT JOIN #BASE_VALOR_GLOBAL vg2 ON vg2.Codigo_WBC = contratos.Nr_contrato_vinculado

INNER JOIN #BASE_VALOR_GLOBAL_MES vgm ON contratos.Numero_referencia_contrato = vgm.Numero_referencia_contrato
											AND contratos.Ano = vgm.Ano
											AND contratos.Mes = vgm.Mes

LEFT JOIN #BASE_CALCULO_RATEIO cr ON cr.Codigo_WBC = contratos.Codigo_WBC

LEFT JOIN #BASE_CONTRATO ctt1 ON ctt1.Codigo_Empresa = contratos.Id_contraparte
LEFT JOIN #BASE_CONTRATO ctt2 ON ctt2.Codigo_Empresa = contratos.Id_parte

LEFT JOIN #BASE_GARANTIA bg ON bg.Codigo_WBC = (CASE WHEN contratos.Nr_contrato_vinculado IS NULL THEN contratos.Codigo_WBC ELSE contratos.Nr_contrato_vinculado END)	

LEFT JOIN (
	SELECT DISTINCT Codigo_wbc
	FROM [Enel].[dbo].[VBA_contratos_196_classificador] clas
	WHERE Agrupador = 'Contratos'
	AND Classificador IN ('Varejista sem encargos','Varejista com desc garantido','Varejista com encargos','Autoprodução','Isenção de Garantia')
) clas ON clas.[Codigo_wbc] = contratos.codigo_wbc

LEFT JOIN #TEMP_CLASS_TIPO_MINUTA TM ON TM.Codigo_WBC = contratos.Codigo_WBC

INNER JOIN CTE_NUMERO_REFERENCIA_CONTRATO NRC ON NRC.Numero_referencia_contrato = contratos.Numero_referencia_contrato

WHERE 
contratos.dt_fim_vig = '9999-12-31'																													     -- Apenas Vigencia Aberta
AND Id_parte <> Id_contraparte																															 -- Retira Intrabooks
AND (Id_parte NOT IN (select id_empresa from Enel.dbo.VBA_Hierarquia_198) OR Id_contraparte NOT IN (select id_empresa from Enel.dbo.VBA_Hierarquia_198)) -- Retira Intercompanies
AND ID_Tipo_Contrato = 3                                                                                                                                 -- Apenas Contratos Livre_ACL
AND ID_Contraparte NOT in (42, 794)																														 -- retira os contratos Regulados_ACR que tem essas contrapartes e id_tipo_Contrato = 3
AND Contrato_legado IS NULL
AND RIGHT(contratos.Codigo_WBC,2) = '20' 																												 --Apenas ambiente Enel Trading
AND ID_Status in (2,8)    																																 -- Somente Contratos Publicados
AND Nome_contrato NOT LIKE 'ADITIVO%'																													 --Retirar Aditivo
AND clas.Codigo_wbc IS NULL          --retira contratos com classificador  sem encargos', com desc garantido', com encargos','Autoprodução','Isenção de Garantia
AND contratos.Data_fechamento >= CONVERT(DATETIME2,@DATA_CORTE_SUPRIMENTO)
ORDER BY contratos.Ano, contratos.Mes