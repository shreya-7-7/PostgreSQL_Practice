-- ===========================================
-- CREATE CUSTOMERS TABLE
-- Stores customer information.
-- Each customer has a unique customer ID.
-- ===========================================

CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL,
    cust_email VARCHAR(100)
);


-- ===========================================
-- INSERT CUSTOMER DATA
-- Adds sample customers into the table.
-- ===========================================

INSERT INTO customers (cust_name)
VALUES
    ('Rohan'),
    ('Sham'),
    ('Paul'),
    ('Alex');


-- ===========================================
-- UPDATE CUSTOMER EMAILS
-- Adds email addresses for existing customers.
-- ===========================================

UPDATE customers
SET cust_email = CASE
    WHEN cust_name = 'Rohan' THEN 'rohan@gmail.com'
    WHEN cust_name = 'Sham' THEN 'sham@gmail.com'
    WHEN cust_name = 'Paul' THEN 'paul@gmail.com'
    WHEN cust_name = 'Alex' THEN 'alex@gmail.com'
END;


-- ===========================================
-- DISPLAY ALL CUSTOMERS
-- Retrieves all customer records.
-- ===========================================

SELECT *
FROM customers;


-- ===========================================
-- CREATE ORDERS TABLE
-- Stores order information.
-- Each order belongs to one customer.
-- ===========================================

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    price NUMERIC NOT NULL,
    cust_id INTEGER NOT NULL,

    -- Foreign Key: Links each order to a customer
    FOREIGN KEY (cust_id)
    REFERENCES customers(cust_id)
);


-- ===========================================
-- INSERT ORDER DATA
-- Adds sample orders placed by customers.
-- ===========================================

INSERT INTO orders (order_date, cust_id, price)
VALUES
    ('2024-01-01', 2, 250.00),
    ('2024-01-15', 2, 300.00),
    ('2024-02-01', 3, 350.00),
    ('2024-03-01', 4, 450.00),
    ('2024-03-04', 3, 550.00);


-- ===========================================
-- DISPLAY ALL ORDERS
-- Retrieves all order records.
-- ===========================================

SELECT *
FROM orders;


-- ===========================================
-- CROSS JOIN
-- Combines every customer with every order.
-- Returns the Cartesian product of both tables.
-- Example:
-- 4 customers × 5 orders = 20 rows
-- ===========================================

SELECT *
FROM customers
CROSS JOIN orders;


-- ===========================================
-- INNER JOIN
-- Displays each customer's name along with
-- the total number of orders placed.
-- Only customers with matching orders appear.
-- ===========================================

SELECT
    c.cust_name,
    COUNT(o.order_id) AS total_orders

FROM customers c

INNER JOIN orders o
ON c.cust_id = o.cust_id

GROUP BY c.cust_name;


-- ===========================================
-- INNER JOIN
-- Displays each customer's total spending.
-- Calculates the sum of all order prices.
-- ===========================================

SELECT
    c.cust_name,
    SUM(o.price) AS total_amount

FROM customers c

INNER JOIN orders o
ON c.cust_id = o.cust_id

GROUP BY c.cust_name;


-- ===========================================
-- LEFT JOIN
-- Displays all customers.
-- Customers without orders will still appear.
-- Order columns will contain NULL values.
-- ===========================================

SELECT *

FROM customers c

LEFT JOIN orders o
ON c.cust_id = o.cust_id;


-- ===========================================
-- RIGHT JOIN
-- Displays all customers and matching orders.
-- Since customers is the RIGHT table,
-- every customer will appear at least once.
-- ===========================================

SELECT *

FROM orders o

RIGHT JOIN customers c
ON c.cust_id = o.cust_id;


-- ===========================================
-- DISPLAY ORDERS SORTED BY PRICE
-- Shows orders from highest to lowest price.
-- ===========================================

SELECT *
FROM orders
ORDER BY price DESC;


-- ===========================================
-- DISPLAY CUSTOMERS WHO SPENT
-- MORE THAN ₹500
-- ===========================================

SELECT
    c.cust_name,
    SUM(o.price) AS total_spent

FROM customers c

JOIN orders o
ON c.cust_id = o.cust_id

GROUP BY c.cust_name

HAVING SUM(o.price) > 500;