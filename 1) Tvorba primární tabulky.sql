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

DROP TABLE IF EXISTS t_Jan_Blazel_project_SQL_primary_final;

CREATE TABLE IF NOT EXISTS t_Jan_Blazel_project_SQL_primary_final AS 
SELECT 
	cp.category_code,
	cp.value AS cp_value,
	YEAR (cp.date_from) AS cp_year ,
	cpc.code AS cpc_code,
	cpc.name AS cpc_name,
	cpc.price_unit,
	cpr.payroll_year AS payroll_year,
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

DROP TABLE IF EXISTS t_jan_blazel_project_sql_primary_final;

CREATE TABLE IF NOT EXISTS t_Jan_Blazek_project_SQL_primary_final AS 
SELECT 
    cp.category_code AS cp_category,
    AVG(cp.value) AS avg_cp_value,
    YEAR(cp.date_from) AS cp_year,
    cpc.code AS cpc_code,
    cpc.name AS cpc_name,
    cpc.price_unit AS cpc_price_unit,
    cpr.payroll_year AS payroll_year,
    AVG(cpr.value) AS avg_cpr_value, 
    cpr.value_type_code AS cpr_value_type,
    cpr.unit_code AS cpr_unit_code,
    cpr.industry_branch_code AS branch_code,
    cpib.code AS cpib_code,
    cpib.name AS cpib_name
FROM czechia_price cp 
JOIN czechia_price_category cpc 
    ON cp.category_code = cpc.code 
JOIN czechia_payroll cpr 
    ON YEAR(cp.date_from) = cpr.payroll_year 
JOIN czechia_payroll_industry_branch cpib 
    ON cpr.industry_branch_code = cpib.code
GROUP BY 
    cp.category_code,
    cp_year,
    cpc.code,
    cpc.name,
    cpc.price_unit,
    cpr.payroll_year,
    cpr.value_type_code,
    cpr.unit_code,
    cpr.industry_branch_code,
    cpib.code,
    cpib.name;
   
DROP TABLE IF EXISTS t_Jan_Blazek_project_SQL_primary_final;

CREATE TABLE IF NOT EXISTS t_Jan_Blazek_project_SQL_primary_final AS 
SELECT 
	a.cp_category,
	a.avg_cp_value,
	a.cp_year,
	a.cpc_code,
	a.cpc_name,
	a.cpc_price_unit,
	b.payroll_year,
	b.avg_cpr_value,
	b.cpr_value_type,
	b.cpr_unit_code,
	b.branch_code,
	b.cpib_code,
	b.cpib_name
FROM (
	SELECT 
    	cp.category_code AS cp_category,
		AVG(cp.value) AS avg_cp_value,
		YEAR(cp.date_from) AS cp_year,
		cpc.code AS cpc_code,
		cpc.name AS cpc_name,
		cpc.price_unit AS cpc_price_unit
	FROM czechia_price cp
	JOIN czechia_price_category cpc 
		ON cp.category_code = cpc.code
	GROUP BY cp.category_code, YEAR(cp.date_from), cpc.code, cpc.name, cpc.price_unit
) a 
LEFT JOIN (
	SELECT 
		cpr.payroll_year AS payroll_year,
		AVG(cpr.value) AS avg_cpr_value,
		cpr.value_type_code AS cpr_value_type,
		cpr.unit_code AS cpr_unit_code,
		cpr.industry_branch_code AS branch_code,
		cpib.code AS cpib_code,
		cpib.name AS cpib_name
	FROM czechia_payroll cpr
	JOIN czechia_payroll_industry_branch cpib 
		ON cpr.industry_branch_code = cpib.code
	GROUP BY cpr.payroll_year, cpr.value_type_code, cpr.unit_code, cpr.industry_branch_code, cpib.code, cpib.name
) b 
	ON a.cp_year = b.payroll_year;

