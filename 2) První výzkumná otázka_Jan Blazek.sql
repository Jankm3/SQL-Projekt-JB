WITH prumerne_mzdy_dle_odvetvi AS (
SELECT
    cpib_name,
    payroll_year,
    cpr_value
FROM
	t_jan_blazel_project_sql_primary_final tjbpspf 
WHERE value_type_code = '5958'
GROUP BY
    cpib_name, payroll_year
ORDER BY
    cpib_name, payroll_year
    )
 SELECT
  cpib_name,
  MIN(payroll_year) AS start_year,
  MAX(payroll_year) AS end_year,
  MAX(cpr_value) AS max_pay,
  MIN(cpr_value), 
  MAX(cpr_value) - MIN(cpr_value) AS average_salary_growth
  FROM prumerne_mzdy_dle_odvetvi 
  GROUP BY
    cpib_name
ORDER BY
    average_salary_growth, max_pay DESC; 