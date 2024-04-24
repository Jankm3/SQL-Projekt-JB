WITH average_payroll AS (
SELECT
	cpib_name,
	payroll_year,
	avg_cpr_value
FROM
	t_jan_blazek_project_sql_primary_final tjb
WHERE cpr_value_type = '5958'
GROUP BY
	cpib_name, payroll_year
ORDER BY
	cpib_name, payroll_year
	)
SELECT
	cpib_name,
	MIN(payroll_year) AS start_year,
	MAX(payroll_year) AS end_year,
	MAX(avg_cpr_value) AS max_payroll,
	MIN(avg_cpr_value) AS  min_payroll,
	ROUND (MAX(avg_cpr_value) - MIN(avg_cpr_value)) AS average_salary_growth
FROM average_payroll 
GROUP BY
	cpib_name
ORDER BY
	average_salary_growth DESC; 
   
SELECT
	cpib_name,
	payroll_year,
	ROUND (avg_cpr_value),
	ROUND (LAG(avg_cpr_value) OVER (PARTITION BY cpib_name ORDER BY payroll_year)) AS prev_avg_cpr_value,
	CASE
		WHEN avg_cpr_value < LAG(avg_cpr_value) OVER (PARTITION BY cpib_name ORDER BY payroll_year) THEN 'Ano'
		ELSE 'Ne'
	END AS has_decreased
FROM
	t_jan_blazek_project_sql_primary_final
WHERE
	cpr_value_type = '5958'
ORDER BY 
	has_decreased;
