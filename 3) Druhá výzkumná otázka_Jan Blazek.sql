SELECT 
min (payroll_year),
max (payroll_year),
min(cp_year),
max (cp_year)
FROM t_jan_blazek_project_sql_primary_final tjb;

WITH average_pay AS (
	SELECT 
		AVG (avg_cpr_value) AS avg_cpr_value,
		payroll_year
	FROM t_jan_blazek_project_sql_primary_final tjb
	WHERE payroll_year IN ('2006', '2018')
		AND cpr_value_type = '5958'
	GROUP BY payroll_year
),
prices_of_selected_goods AS (
	SELECT 
		cpc_name,
		cpc_code,
		AVG (avg_cp_value) AS avg_cp_value,
		payroll_year 
	FROM t_jan_blazek_project_sql_primary_final tjb 
	WHERE cpc_code IN ('114201', '111301')
		AND payroll_year IN ('2006', '2018')
	GROUP BY cpc_name, payroll_year
)
SELECT 
	posg.cpc_name,
	ap.payroll_year,
	ROUND((ap.avg_cpr_value / posg.avg_cp_value), 2) AS quantity_of_products
FROM average_pay ap 
JOIN prices_of_selected_goods posg 
	ON ap.payroll_year = posg.payroll_year 
GROUP BY ap.payroll_year, posg.cpc_name;
