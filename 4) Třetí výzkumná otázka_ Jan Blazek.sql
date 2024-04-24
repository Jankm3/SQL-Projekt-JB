SELECT 
	tjb1.cpc_name,
	tjb1.cp_year,
	tjb2.cp_year + 1 as year_prev, 
	ROUND ((tjb1.avg_cp_value - tjb2.avg_cp_value) / tjb2.avg_cp_value * 100) AS percentage_growth 
FROM t_jan_blazek_project_sql_primary_final tjb1
JOIN t_jan_blazek_project_sql_primary_final tjb2 
	ON tjb1.cpc_name = tjb2.cpc_name 
	AND tjb1.cp_year = tjb2.cp_year + 1
	AND tjb1.cp_year <= 2018
GROUP BY tjb1.cpc_name
ORDER BY percentage_growth ASC 
LIMIT 1;
 
   