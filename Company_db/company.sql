-- Create the employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    designation VARCHAR(50),
    dept VARCHAR(30),
    salary NUMERIC(10,2)

);

-- ============================================
-- USE CASE - 1
-- Find employees whose salary is greater than
-- the average salary of their own department
-- ============================================

-- Create a Common Table Expression (CTE) to calculate
-- the average salary for each department
WITH avg_sal AS (

    SELECT
        dept,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept
)

-- Join the employees table with the CTE
-- to compare each employee's salary with
-- their department's average salary
SELECT
    e.emp_id,
    e.fname,
    e.salary,
    a.avg_salary
FROM employees e
JOIN avg_sal a
    ON e.dept = a.dept

-- Display only those employees whose salary
-- is greater than their department's average salary
WHERE e.salary > a.avg_salary;


/* Uncomment to view the average salary
   calculated for each department

SELECT *
FROM avg_sal;

*/



-- ============================================
-- USE CASE - 2
-- Find the highest-paid employee(s)
-- in each department
-- ============================================

-- Create a CTE to calculate the maximum salary
-- for every department
WITH max_sal AS (

    SELECT
        dept,
        MAX(salary) AS max_salary
    FROM employees
    GROUP BY dept
)

-- Join the employees table with the CTE
-- to compare each employee's salary with
-- the highest salary in their department
SELECT
    e.emp_id,
    e.fname,
    e.dept,
    e.salary
FROM employees e
JOIN max_sal m
    ON e.dept = m.dept

-- Display only the employee(s) whose salary
-- matches the maximum salary of their department
WHERE e.salary = m.max_salary;


-- ============================================
-- STORED PROCEDURE
-- Update an employee's salary
-- ============================================

CREATE OR REPLACE PROCEDURE update_emp_salary(
    p_employee_id INT,
    p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees
    SET salary = p_new_salary
    WHERE emp_id = p_employee_id;
END;
$$;

-- Create a trigger named before_update_salary
CREATE TRIGGER before_update_salary

-- Execute the trigger before an UPDATE operation
BEFORE UPDATE
ON employees

-- Fire the trigger for every row being updated
FOR EACH ROW

-- Call the trigger function check_salary()
EXECUTE FUNCTION check_salary();

CALL update_emp_salary(2, -52000);

SELECT * FROM employees;
