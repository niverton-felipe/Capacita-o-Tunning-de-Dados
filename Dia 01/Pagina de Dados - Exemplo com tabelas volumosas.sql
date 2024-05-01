/* E se os dados crescerem consideravelmente */

EXEC sp_spaceused 'Report_SalesForce_Criacao_Manual_Maior_Volume'; 

EXEC sp_spaceused 'Report_SalesForce_Criacao_Automatica_Maior_Volume'; 

-- Consulta para obter o número de páginas de dados da tabela gerada pelo python
SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Manual_Maior_Volume';


SELECT 
    SUM(ps.used_page_count) AS Total_Paginas_Dados
FROM 
    sys.dm_db_partition_stats ps
INNER JOIN 
    sys.tables t ON ps.object_id = t.object_id
WHERE 
    t.name = 'Report_SalesForce_Criacao_Automatica_Maior_Volume';