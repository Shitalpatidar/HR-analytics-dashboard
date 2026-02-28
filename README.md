 HR Analytics Dashboard using SQL

 1. Project Overview

The **HR Analytics Dashboard using SQL** project focuses on analyzing 1,400+ employee records to identify attrition patterns and salary trends.

## Objective
The main objective was to help the company understand:

- Which departments have high attrition
- Which salary groups are more likely to leave
- Which job roles earn higher salaries
- Overall workforce distribution and salary insights

This project enables management to make **data-driven decisions** to reduce employee turnover and optimize salary structure.

---

##  2. Dataset Description

The dataset contains **1,400+ employee records** with the following fields:

- EmployeeID  
- Age  
- Gender  
- Department  
- JobRole  
- Salary  
- Attrition (Yes/No)  
- YearsAtCompany  
- Education  
- MaritalStatus  

The data represents HR records of employees working across multiple departments.

---

##  3. Data Cleaning Process (Using MySQL)

Complete data preprocessing was performed:

 Removed duplicate records using `ROW_NUMBER()`  
 Handled missing values  
 Standardized categorical columns (Gender, Department, etc.)  
 Checked inconsistent salary entries  
 Converted data types where required  



##  4. SQL Analysis Performed
Created new useful columns:
Age Group (Young, Mid-Age, Senior)
Salary Bracket (Low, Medium, High)
- Attrition Analysis by Department
- Salary Trend Analysis
- Highest Paid Employees
- Attrition by Salary Group
- Gender-wise workforce distribution



##  5. Key Insights

- Sales department had highest attrition rate
- Employees in lower salary bracket were more likely to leave
- Mid-age employees had stable retention
- Certain job roles had significantly higher salary structure
- Few departments showed imbalance between salary and attrition



##  6. Tools & Technologies Used

- MySQL
- SQL (Joins, Aggregations, Window Functions)
- Excel (Initial data inspection)

---

##  7. Conclusion

This project demonstrates strong practical skills in:

- SQL data cleaning
- Data analysis
- Business problem solving
- HR data interpretation

It simulates real-world HR analytics used in organizations to improve retention strategies and workforce planning.
