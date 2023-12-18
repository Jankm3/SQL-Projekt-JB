
CREATE TABLE IF NOT EXISTS t_Jan_Blazel_project_SQL_primary_final AS 
SELECT 
	cp.category_code,
	cp.value AS cp_value,
	YEAR (cp.date_from) AS cp_year ,
	cpc.code AS cpc_code,
	cpc.name AS cpc_name,
	cpc.price_unit,
	cpr.value AS cpr_value, 
	cpr.value_type_code,
	cpr.unit_code,
	cpr.industry_branch_code,
	cpib.code AS cpib_code,
	cpib.name AS cpib_name
FROM czechia_price cp 
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
JOIN czechia_payroll cpr 
	ON YEAR (cp.date_from) = cpr.payroll_year 
JOIN czechia_payroll_industry_branch cpib 
	ON cpr.industry_branch_code = cpib.code; 



















