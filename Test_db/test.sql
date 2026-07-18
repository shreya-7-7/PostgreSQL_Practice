-- ===========================================
-- CREATE SALES TABLE
-- Stores sales information including
-- salesperson, region, product and amount.
-- ===========================================

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    salesperson VARCHAR(50),
    region VARCHAR(20),
    product VARCHAR(30),
    amount DECIMAL(10,2)
);


-- ===========================================
-- INSERT SAMPLE SALES DATA
-- Adds sample sales records into the table.
-- ===========================================

INSERT INTO sales (salesperson, region, product, amount)
VALUES
    ('Rahul', 'North', 'Laptop', 55000),
    ('Rahul', 'North', 'Mouse', 1500),
    ('Priya', 'South', 'Laptop', 60000),
    ('Priya', 'South', 'Mouse', 2000),
    ('Aman', 'North', 'Laptop', 50000),
    ('Aman', 'South', 'Keyboard', 3000);


-- ===========================================
-- DISPLAY ALL SALES RECORDS
-- Retrieves all rows from the sales table.
-- ===========================================

SELECT *
FROM sales;


-- ===========================================
-- TOTAL SALES FOR EACH PRODUCT
-- Groups records by product and calculates
-- the total sales amount.
-- ===========================================

SELECT
    product,
    SUM(amount) AS total_sales
FROM sales
GROUP BY product;


-- ===========================================
-- HAVING CLAUSE
-- Displays only those products whose total
-- sales amount is greater than 1000.
-- HAVING filters grouped data.
-- ===========================================

SELECT
    product,
    SUM(amount) AS total_sales
FROM sales
GROUP BY product
HAVING SUM(amount) > 1000;


-- ===========================================
-- ROLLUP CLAUSE
-- Displays total sales for each product
-- along with a grand total.
-- COALESCE replaces NULL with 'Grand Total'.
-- ===========================================

SELECT
    COALESCE(product, 'Grand Total') AS product,
    SUM(amount) AS total_sales
FROM sales
GROUP BY ROLLUP(product)
ORDER BY total_sales;


-- ===========================================
-- TOTAL SALES BY REGION
-- Displays the total sales amount
-- for each region.
-- ===========================================

SELECT
    region,
    SUM(amount) AS total_sales
FROM sales
GROUP BY region;


-- ===========================================
-- AVERAGE SALES OF EACH PRODUCT
-- Calculates the average sales amount
-- for every product.
-- ===========================================

SELECT
    product,
    AVG(amount) AS average_sales
FROM sales
GROUP BY product;


-- ===========================================
-- HIGHEST SALE FOR EACH PRODUCT
-- Displays the maximum sale amount
-- recorded for every product.
-- ===========================================

SELECT
    product,
    MAX(amount) AS highest_sale
FROM sales
GROUP BY product;


-- ===========================================
-- LOWEST SALE FOR EACH PRODUCT
-- Displays the minimum sale amount
-- recorded for every product.
-- ===========================================

SELECT
    product,
    MIN(amount) AS lowest_sale
FROM sales
GROUP BY product;