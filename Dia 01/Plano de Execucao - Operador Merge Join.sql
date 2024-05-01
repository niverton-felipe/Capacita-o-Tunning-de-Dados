SET STATISTICS TIME ON
SET STATISTICS IO ON

DROP TABLE #TEMP_ID_OPORTUNIDADE
  
  SELECT
  DISTINCT
  CONVERT(VARCHAR(100),[ID_da_oportunidade]) [ID_da_oportunidade]
  --ROW_NUMBER() OVER(ORDER BY [ID_da_oportunidade]) RN
  INTO #TEMP_ID_OPORTUNIDADE
  FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Automatica]

  CREATE CLUSTERED INDEX INC_#TEMP_ID_OPORTUNIDADE_ID_OPORTUNIDADE
  ON #TEMP_ID_OPORTUNIDADE([ID_da_oportunidade])


  SELECT * FROM #TEMP_ID_OPORTUNIDADE
  WHERE ID_da_oportunidade = '0064T000005z3AS'


  SELECT
    A.[ID_da_oportunidade]
   ,[Propriet�rio_da_oportunidade]
   ,[Data_da_�ltima_mudan�a_de_fase]
   ,[Data_da_�ltima_modifica��o]
   ,[Cliente_Estrat�gico]
   FROM [AdventureWorks2022].[dbo].[Report_SalesForce_Criacao_Automatica] A
   INNER JOIN #TEMP_ID_OPORTUNIDADE B
   ON A.[ID_da_oportunidade] = B.ID_da_oportunidade
   WHERE Cliente_Estrat�gico = 1