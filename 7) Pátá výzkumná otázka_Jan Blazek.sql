SELECT
	e_year,
	e_GDP,
	avg_cp_value,
	avg_cpr_value,
	CASE
		WHEN e_GDP > LAG(e_GDP) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS GDP_increased,
	CASE
		WHEN avg_cp_value > LAG(avg_cp_value) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS prices_increased,
	CASE
		WHEN avg_cpr_value > LAG(avg_cpr_value) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS payroll_increased
FROM t_jan_blazel_project_sql_secondary_final
WHERE e_GDP IS NOT NULL 
	AND avg_cp_value IS NOT NULL 
	AND avg_cpr_value IS NOT NULL 
ORDER BY e_year;


SELECT
	e_year,
	e_GDP,
	avg_cp_value,
	avg_cpr_value,
	CASE
		WHEN e_GDP > LAG(e_GDP) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS GDP_increased,
	CASE
		WHEN avg_cp_value > LAG(avg_cp_value) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS prices_increased,
	CASE
		WHEN avg_cpr_value > LAG(avg_cpr_value) OVER (ORDER BY e_year) THEN 'Yes'
		ELSE 'No'
	END AS payroll_increased,
	ROUND((e_GDP - LAG(e_GDP) OVER (ORDER BY e_year)) / LAG(e_GDP) OVER (ORDER BY e_year) * 100, 2) AS GDP_percentage_growth,
	ROUND((avg_cp_value - LAG(avg_cp_value) OVER (ORDER BY e_year)) / LAG(avg_cp_value) OVER (ORDER BY e_year) * 100, 2) AS prices_percentage_growth,
	ROUND((avg_cpr_value - LAG(avg_cpr_value) OVER (ORDER BY e_year)) / LAG(avg_cpr_value) OVER (ORDER BY e_year) * 100, 2) AS payroll_percentage_growth
FROM t_jan_blazel_project_sql_secondary_final
WHERE e_GDP IS NOT NULL 
	AND avg_cp_value IS NOT NULL 
	AND avg_cpr_value IS NOT NULL 
ORDER BY e_year;

