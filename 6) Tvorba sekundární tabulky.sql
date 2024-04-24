CREATE TABLE IF NOT EXISTS t_jan_blazek_project_SQL_secondary_final AS
SELECT
    e.country,
    e.YEAR AS e_year,
    e.GDP AS e_GDP,
    cp.value AS avg_cp_value,
    YEAR(cp.date_from) AS cp_year,
    cpr.value AS avg_cpr_value,
    cpr.value_type_code,
    cpr.payroll_year AS payroll_year
FROM economies e
LEFT JOIN czechia_price cp 
    ON e.year = YEAR(cp.date_from) 
LEFT JOIN czechia_payroll cpr 
    ON e.year = cpr.payroll_year
    AND cpr.value_type_code = '5958'
WHERE e.country = 'Czech Republic';

DROP TABLE IF EXISTS t_jan_blazek_project_SQL_secondary_final;

CREATE TABLE IF NOT EXISTS t_Jan_Blazel_project_SQL_secondary_final AS 
SELECT
	a.country,
	a.e_year,
	a.e_GDP,
	b.avg_cp_value,
	b.cp_year,
	c.avg_cpr_value,
	c.payroll_year
FROM (
	SELECT
		e.country,
		e.YEAR AS e_year,
		ROUND (AVG(e.GDP)) AS e_GDP
	FROM economies e
	WHERE e.country = 'Czech Republic'
	GROUP BY e.country, e.YEAR
) a
LEFT JOIN (
	SELECT
		YEAR(cp.date_from) AS cp_year,
		ROUND (AVG(cp.value)) AS avg_cp_value
	FROM czechia_price cp
	GROUP BY YEAR(cp.date_from)
) b 
	ON a.e_year = b.cp_year
LEFT JOIN (
	SELECT
		cpr.payroll_year,
		ROUND (AVG(cpr.value)) AS avg_cpr_value
	FROM czechia_payroll cpr
	WHERE cpr.value_type_code = '5958'
	GROUP BY cpr.payroll_year
) c 
	ON a.e_year = c.payroll_year;
