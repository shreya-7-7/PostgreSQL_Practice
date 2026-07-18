-- ===========================================
-- CUSTOMERS TABLE
-- Stores customer information.
-- Each customer is assigned a unique customer ID.
-- ===========================================

CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL
);

-- ===========================================
-- INSERT CUSTOMER DATA
-- Adds sample customers
-- ===========================================

INSERT INTO customers (cust_name)
VALUES
    ('Raju'),
    ('Sham'),
    ('Paul'),
    ('Alex');


-- ===========================================
-- ORDERS TABLE
-- Stores order details placed by customers.
-- Each order belongs to one customer.
-- ===========================================

CREATE TABLE orders (
    ord_id SERIAL PRIMARY KEY,
    ord_date DATE NOT NULL,
    cust_id INTEGER NOT NULL,

    -- Foreign Key: Links each order to a customer
    FOREIGN KEY (cust_id)
    REFERENCES customers(cust_id)
);

-- ===========================================
-- INSERT ORDER DATA
-- Adds sample customer orders
-- ===========================================

INSERT INTO orders (ord_date, cust_id)
VALUES
    ('2024-01-01', 1),   -- Raju
    ('2024-02-01', 2),   -- Sham
    ('2024-03-01', 3),   -- Paul
    ('2024-04-04', 2);   -- Sham's second order


-- ===========================================
-- PRODUCTS TABLE
-- Stores product information and prices.
-- ===========================================

CREATE TABLE products (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    price NUMERIC NOT NULL
);

-- ===========================================
-- INSERT PRODUCT DATA
-- Adds products available in the online store
-- ===========================================

INSERT INTO products (p_name, price)
VALUES
    ('Laptop', 55000.00),
    ('Mouse', 500.00),
    ('Keyboard', 800.00),
    ('Cable', 250.00);


-- ===========================================
-- ORDER_ITEMS TABLE
-- Stores the products included in each order.
-- One order can contain multiple products.
-- ===========================================

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    ord_id INTEGER NOT NULL,
    p_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,

    -- Foreign Key: Links order_items to orders
    FOREIGN KEY (ord_id)
    REFERENCES orders(ord_id),

    -- Foreign Key: Links order_items to products
    FOREIGN KEY (p_id)
    REFERENCES products(p_id)
);

-- ===========================================
-- INSERT ORDER ITEM DATA
-- Assigns products to each order
-- ===========================================

INSERT INTO order_items (ord_id, p_id, quantity)
VALUES
    (1, 1, 1),  -- Raju ordered 1 Laptop
    (1, 4, 2),  -- Raju ordered 2 Cables

    (2, 1, 1),  -- Sham ordered 1 Laptop

    (3, 2, 1),  -- Paul ordered 1 Mouse
    (3, 4, 5),  -- Paul ordered 5 Cables

    (4, 3, 1);  -- Sham ordered 1 Keyboard


-- ===========================================
-- DISPLAY ALL CUSTOMERS
-- Retrieves all customer records
-- ===========================================

SELECT * FROM customers;


-- ===========================================
-- DISPLAY ALL ORDERS
-- Retrieves all order records
-- ===========================================

SELECT * FROM orders;


-- ===========================================
-- DISPLAY ALL PRODUCTS
-- Retrieves all product records
-- ===========================================

SELECT * FROM products;


-- ===========================================
-- DISPLAY ALL ORDER ITEMS
-- Retrieves all order item records
-- ===========================================

SELECT * FROM order_items;


-- ===========================================
-- CUSTOMER PURCHASE DETAILS
-- Displays customer name, order date,
-- product purchased, quantity,
-- price and total amount.
-- ===========================================

SELECT
    c.cust_name,
    o.ord_date,
    p.p_name,
    p.price,
    oi.quantity,

    -- Calculate total price
    (oi.quantity * p.price) AS total_price

FROM order_items oi

JOIN products p
ON oi.p_id = p.p_id

JOIN orders o
ON oi.ord_id = o.ord_id

JOIN customers c
ON o.cust_id = c.cust_id;