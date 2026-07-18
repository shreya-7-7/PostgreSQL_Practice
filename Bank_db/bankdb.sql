-- ===========================================
-- CREATE EMPLOYEES TABLE
-- Creates a table to store employee details
-- ===========================================

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dept VARCHAR(50),
    salary DECIMAL(10,2) DEFAULT 30000.00,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- ===========================================
-- INSERT EMPLOYEE DATA
-- Adds sample employee records
-- ===========================================

INSERT INTO employees
(fname, lname, email, dept, salary, hire_date)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@gmail.com', 'IT', 65000, '2023-01-15'),
('Shreya', 'Gupta', 'shreya.gupta@gmail.com', 'HR', 50000, '2023-02-20'),
('Aman', 'Verma', 'aman.verma@gmail.com', 'Finance', 72000, '2022-11-10'),
('Priya', 'Singh', 'priya.singh@gmail.com', 'Marketing', 48000, '2023-05-18'),
('Rohan', 'Mehta', 'rohan.mehta@gmail.com', 'IT', 55000, '2024-01-05'),
('Neha', 'Patel', 'neha.patel@gmail.com', 'Sales', 45000, '2023-08-12'),
('Arjun', 'Kumar', 'arjun.kumar@gmail.com', 'Finance', 80000, '2022-09-01'),
('Sneha', 'Joshi', 'sneha.joshi@gmail.com', 'HR', 52000, '2024-02-10');

-- ===========================================
-- DISPLAY ALL EMPLOYEES
-- Retrieves all employee records
-- ===========================================

SELECT *
FROM employees;

-- ===========================================
-- DISPLAY EMPLOYEES FROM IT DEPARTMENT
-- Retrieves employees working in the IT department
-- ===========================================

SELECT *
FROM employees
WHERE dept = 'IT';

-- ===========================================
-- DISPLAY EMPLOYEES WITH SALARY ABOVE 60000
-- Retrieves employees earning more than 60,000
-- ===========================================

SELECT *
FROM employees
WHERE salary > 60000;

-- ===========================================
-- DISPLAY EMPLOYEES ORDERED BY SALARY
-- Shows employees from highest to lowest salary
-- ===========================================

SELECT *
FROM employees
ORDER BY salary DESC;

-- ===========================================
-- COUNT TOTAL EMPLOYEES
-- Counts the number of employees
-- ===========================================

SELECT COUNT(*) AS total_employees
FROM employees;

-- ===========================================
-- DISPLAY AVERAGE SALARY
-- Calculates the average employee salary
-- ===========================================

SELECT AVG(salary) AS average_salary
FROM employees;

-- ===========================================
-- DISPLAY HIGHEST AND LOWEST SALARY
-- Finds the maximum and minimum salary
-- ===========================================

SELECT
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees;

-- ===========================================
-- DISPLAY TOTAL SALARY BY DEPARTMENT
-- Calculates total salary paid in each department
-- ===========================================

SELECT
    dept,
    SUM(salary) AS total_salary
FROM employees
GROUP BY dept;

-- ===========================================
-- DISPLAY DEPARTMENTS HAVING MORE THAN ONE EMPLOYEE
-- Filters grouped results using HAVING
-- ===========================================

SELECT
    dept,
    COUNT(*) AS total_employees
FROM employees
GROUP BY dept
HAVING COUNT(*) > 1;