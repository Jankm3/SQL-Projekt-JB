
SELECT 
min (payroll_year),
max (payroll_year),
min(cp_year),
max (cp_year)
FROM t_jan_blazel_project_sql_primary_final tjbpspf ;

CREATE VIEW average_pay AS 
SELECT 
	avg (cpr_value) AS average_pay,
	payroll_year
FROM t_jan_blazel_project_sql_primary_final tjbpspf 
WHERE payroll_year IN ('2006', '2018')
	AND value_type_code = '5958'
GROUP BY payroll_year;
	
CREATE VIEW prices_of_selected_goods AS 	
SELECT 
	cpc_name,
	cpc_code,
	cp_value,
	payroll_year 
FROM t_jan_blazel_project_sql_primary_final tjbpspf 
WHERE cpc_code IN ('114201', '111301')
	AND payroll_year IN ('2006', '2018')
GROUP BY cpc_name, payroll_year  ;


SELECT 
posg.cpc_name,
ap.payroll_year,
round ((average_pay / cp_value), 2) AS quantity_of_products
FROM average_pay ap 
JOIN prices_of_selected_goods posg 
	ON ap.payroll_year = posg.payroll_year 
	GROUP BY ap.payroll_year, cpc_name ;