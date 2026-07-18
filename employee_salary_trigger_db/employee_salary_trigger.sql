-- ===========================================
-- PROJECT DATABASE
-- Demonstrates Triggers in PostgreSQL
-- Automatically prevents negative salaries.
-- ===========================================


-- ===========================================
-- CREATE EMPLOYEES TABLE
-- Stores employee details
-- ===========================================

CREATE TABLE employees
(
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary NUMERIC(10,2) NOT NULL
);


-- ===========================================
-- INSERT SAMPLE DATA
-- ===========================================

INSERT INTO employees
(emp_name, department, salary)
VALUES
('Rahul','IT',65000),
('Shreya','HR',50000),
('Aman','Finance',72000),
('Priya','Marketing',48000),
('Rohan','IT',55000);


-- ===========================================
-- DISPLAY EMPLOYEE DETAILS
-- ===========================================

SELECT *
FROM employees;


-- ===========================================
-- CREATE TRIGGER FUNCTION
-- Prevents negative salary values.
-- If salary is negative,
-- it automatically changes it to 0.
-- ===========================================

CREATE OR REPLACE FUNCTION check_salary()

RETURNS TRIGGER

AS
$$

BEGIN

    IF NEW.salary < 0 THEN

        NEW.salary := 0;

    END IF;

    RETURN NEW;

END;

$$

LANGUAGE plpgsql;


-- ===========================================
-- CREATE TRIGGER
-- Executes before INSERT or UPDATE
-- ===========================================

CREATE TRIGGER salary_trigger

BEFORE INSERT OR UPDATE

ON employees

FOR EACH ROW

EXECUTE FUNCTION check_salary();


-- ===========================================
-- INSERT VALID DATA
-- ===========================================

INSERT INTO employees
(emp_name, department, salary)

VALUES

('Neha','Sales',45000);


-- ===========================================
-- INSERT INVALID DATA
-- Salary becomes 0 automatically.
-- ===========================================

INSERT INTO employees
(emp_name, department, salary)

VALUES

('Karan','Finance',-50000);


-- ===========================================
-- UPDATE WITH NEGATIVE SALARY
-- Trigger changes salary to 0.
-- ===========================================

UPDATE employees

SET salary = -25000

WHERE emp_name='Rahul';


-- ===========================================
-- DISPLAY FINAL DATA
-- ===========================================

SELECT *

FROM employees;