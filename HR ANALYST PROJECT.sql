CREATE DATABASE hr_project;
select * from employee_messy;

-- we create another table using same table and we will work on tat table
CREATE TABLE employee_data
LIKE employee_messy;

INSERT INTO employee_data
SELECT *
FROM employee_messy;

-- undarstand the data
SELECT * FROM employee_data;
DESC employee_data;

-- 1.DATA CLEANING
-- Remove NULL & Blank Records
SET sql_safe_updates = 0;
DELETE FROM employee_data
WHERE Department IS NULL;

UPDATE employee_data
SET MaritalStatus = 'single'
WHERE MaritalStatus = '';

UPDATE employee_data
SET Department = 'unknown'
WHERE Department = '';

DELETE FROM employee_data
WHERE EducationField IS NULL OR EducationField = '';

DELETE FROM employee_data
WHERE Gender IS NULL OR Gender = '';

DELETE FROM employee_data
WHERE JobRole IS NULL OR JobRole = '';

-- Fix Invalid Age
UPDATE employee_data
SET Age = NULL
WHERE Age < 18 OR Age > 100;

-- Fix Negative Salary
UPDATE employee_data
SET MonthlyIncome = 6509
WHERE MonthlyIncome < 0;

-- 2. Standardize Text (Uppercase)
UPDATE employee_data
SET Department = UPPER(Department),
    EducationField = UPPER(EducationField),
    Gender = UPPER(Gender),
    JobRole = UPPER(JobRole),
    MaritalStatus = UPPER(MaritalStatus);
-- 3. Remove Duplicate Employees
-- Step 1: Add ID Column ID FOR PRIMARY KEY

ALTER TABLE employee_data
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

-- Step 2: Identify Duplicates
SELECT *,
ROW_NUMBER() OVER (PARTITION BY EmployeID ORDER BY EmployeID) AS row_num
FROM employee_data;

-- Step 3: select Duplicates
SELECT e1. *
FROM employee_data e1
JOIN employee_data e2
ON e1.EmployeID = e2.EmployeID
AND e1.id > e2.id;
-- step: 4 delele duplicates
DELETE e1
FROM employee_data e1
JOIN employee_data e2
ON e1.EmployeID = e2.EmployeID
AND e1.id > e2.id;


-- 3. Feature Engineering
-- Create Age Group COLUMN
ALTER TABLE employee_data
ADD age_group VARCHAR(30);

UPDATE employee_data
SET age_group =
CASE
    WHEN Age < 30 THEN 'YOUNG'
    WHEN Age BETWEEN 30 AND 45 THEN 'MIDDLE'
    ELSE 'SENIOR'
END;

SELECT * FROM employee_data;

-- Create Salary Bracket COLUMN
ALTER TABLE employee_data
ADD salary_bracket VARCHAR(30);

UPDATE employee_data
SET salary_bracket =
CASE
    WHEN MonthlyIncome < 5000 THEN 'LOW'
    WHEN MonthlyIncome BETWEEN 5000 AND 15000 THEN 'MEDIUM'
    ELSE 'HIGH'
END;
-- CREATE Gender Encoding COLUMN
ALTER TABLE employee_data
ADD Gender_code INT;

UPDATE employee_data
SET Gender_code =
CASE
    WHEN Gender = 'Male' THEN 1
    WHEN Gender = 'Female' THEN 0
END;

-- 4. Data Analysis Queries

-- 1. Highest Salary by Department
SELECT Department,
       MAX(MonthlyIncome) AS HighestIncome
FROM employee_data
GROUP BY Department
ORDER BY HighestIncome DESC;

-- 2. Total Employees by Department
SELECT Department,
       COUNT(*) AS TotalEmployee
FROM employee_data
GROUP BY Department;

-- 3. Average Salary by Job Role
SELECT JobRole,
       AVG(MonthlyIncome) AS AvgSalary
FROM employee_data
GROUP BY JobRole
ORDER BY AvgSalary DESC;

-- 4. Gender Distribution
SELECT Gender,
       COUNT(*) AS Total
FROM employee_data
GROUP BY Gender;

-- 5. Top 5 Highest Paid Employees
SELECT EmployeID,
       Department,
       JobRole,
       MonthlyIncome,
       Gender
FROM employee_data
ORDER BY MonthlyIncome DESC
LIMIT 5;

-- 6. Attrition Analysis
SELECT Attrition,
       COUNT(*) AS TotalEmployee
FROM employee_data
GROUP BY Attrition;

-- 7. Attrition by Department
SELECT Attrition,
       Department,
       COUNT(*) AS TotalEmployee
FROM employee_data
GROUP BY Attrition, Department
ORDER BY Department;

-- 8. Attrition by Age Group
SELECT Attrition,
       Age_group,
       COUNT(*) AS TotalEmployee
FROM employee_data
GROUP BY Attrition, Age_group
ORDER BY Age_group;

-- 9. Attrition by Salary Bracket
SELECT Salary_bracket,
       Attrition,
       COUNT(*) AS TotalEmployee
FROM employee_data
GROUP BY Salary_bracket, Attrition;

-- 10. Average Salary by Age Group
SELECT Age_group,
       AVG(MonthlyIncome) AS AvgSalary
FROM employee_data
GROUP BY Age_group
ORDER BY AvgSalary DESC;

-- 11. 