SET STATISTICS IO ON


ALTER TABLE  [AdventureWorksDW2022].[dbo].[FactCallCenter]
ADD Date_Modificada DATE

UPDATE [AdventureWorksDW2022].[dbo].[FactCallCenter]
SET Date_Modificada = CONVERT(DATE, [Date])

CREATE NONCLUSTERED INDEX INC_FACT_CALL_CENTER
ON [AdventureWorksDW2022].[dbo].[FactCallCenter] (Date_Modificada)


SELECT
DATE_MODIFICADA
FROM [AdventureWorksDW2022].[dbo].[FactCallCenter]
WHERE DATE_MODIFICADA = '2014-05-01'

SELECT
DATE_MODIFICADA
FROM [AdventureWorksDW2022].[dbo].[FactCallCenter]
WHERE YEAR(DATE_MODIFICADA) = 2014


SELECT
DATE_MODIFICADA
FROM [AdventureWorksDW2022].[dbo].[FactCallCenter]
WHERE DATE_MODIFICADA BETWEEN '2014-01-01' AND '2014-12-31'

SELECT
DATE_MODIFICADA
FROM [AdventureWorksDW2022].[dbo].[FactCallCenter]
WHERE DATE_MODIFICADA BETWEEN CONVERT(DATE,'2014-01-01') AND CONVERT(DATE,'2014-12-31')