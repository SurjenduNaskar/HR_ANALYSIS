create database HR;
use HR;
select * from hr_1;
select * from hr_2;
Alter table hr_2 change Column `ï»¿Employee ID`Employee_ID int;
#################     Average Attrition rate for all Departments   ###############
SELECT 
    AVG(attrition_rate) AS average_attrition_rate
FROM (
    SELECT 
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS attrition_rate
    FROM HR_1
    GROUP BY Department
) AS dept_attrition;

##################  Average Hourly rate of Male Research Scientist  ###############
SELECT 
    AVG(HourlyRate) AS avg_hourly_rate_male_research_scientist
FROM 
    HR_1
WHERE 
    Gender = 'Male'
    AND JobRole = 'Research Scientist';

#################     Attrition rate Vs Monthly income stats    ###############
SELECT 
    Attrition,
    COUNT(*) AS total_employees,
    AVG(MonthlyIncome) AS avg_monthly_income,
    MIN(MonthlyIncome) AS min_monthly_income,
    MAX(MonthlyIncome) AS max_monthly_income
FROM (
    SELECT 
        a.Attrition,
        b.MonthlyIncome
    FROM HR_1 a
    JOIN HR_2 b
        ON a.EmployeeNumber = b.`Employee_ID`
) AS joined_data
GROUP BY Attrition;


################  Average working years for each Department  ##############
SELECT 
    Department,
    AVG(TotalWorkingYears) AS avg_working_years
FROM (
    SELECT 
        a.Department,
        b.TotalWorkingYears
    FROM HR_1 a
    JOIN HR_2 b
        ON a.EmployeeNumber = b.`Employee_ID`
) AS joined_data
GROUP BY Department;



################ Job Role Vs Work life balance   ####################
SELECT 
    JobRole,
    AVG(WorkLifeBalance) AS avg_work_life_balance
FROM (
    SELECT 
        a.JobRole,
        b.WorkLifeBalance
    FROM HR_1 a
    JOIN HR_2 b
        ON a.EmployeeNumber = b.`Employee_ID`
) AS joined_data
GROUP BY JobRole;


#############  Attrition rate Vs Year since last promotion relation   ################
SELECT 
    YearsSinceLastPromotion,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM (
    SELECT 
        a.Attrition,
        b.YearsSinceLastPromotion
    FROM HR_1 a
    JOIN HR_2 b
        ON a.EmployeeNumber = b.`Employee_ID`
) AS joined_data
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;
