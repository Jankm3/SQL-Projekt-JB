SELECT 
	t1.cp_year,
	((t1.avg_cp_value - t2.avg_cp_value) / t2.avg_cp_value) * 100 AS food_growth,
	((t1.avg_cpr_value - t2.avg_cpr_value) / t2.avg_cpr_value) * 100 AS payroll_growth
FROM 
	t_jan_blazek_project_sql_primary_final t1
JOIN 
	t_jan_blazek_project_sql_primary_final t2 
	ON t1.cp_year = t2.cp_year + 1
WHERE 
	((t1.avg_cp_value - t2.avg_cp_value) / t2.avg_cp_value) * 100 > ((t1.avg_cpr_value - t2.avg_cpr_value) / t2.avg_cpr_value) * 100 + 0.10;

   
WITH Aggregated_yearly AS (
	SELECT 
		cp_year,
		avg_cp_value,
		avg_cpr_value
	FROM 
		t_jan_blazek_project_sql_primary_final
	GROUP BY 
		cp_year
)
SELECT 
	ay1.cp_year,
	ROUND(((ay1.avg_cp_value - ay2.avg_cp_value) / ay2.avg_cp_value) * 100, 2) AS food_growth,
	ROUND(((ay1.avg_cpr_value - ay2.avg_cpr_value) / ay2.avg_cpr_value) * 100, 2) AS payroll_growth
FROM 
	Aggregated_yearly ay1
JOIN 
	Aggregated_yearly ay2 
	ON ay1.cp_year = ay2.cp_year + 1
WHERE 
	ROUND(((ay1.avg_cp_value - ay2.avg_cp_value) / ay2.avg_cp_value) * 100, 2) > ROUND(((ay1.avg_cpr_value - ay2.avg_cpr_value) / ay2.avg_cpr_value) * 100, 2) + 0.10;

  
   
   