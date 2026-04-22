-- ============================================================
-- RETAIL SALES ANALYSIS — SQL PROJECT
-- Author: Mubin Fathima Johnkhan
-- Database: SQL Server (SSMS)
-- Description: Advanced SQL analysis on a retail sales dataset
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE & SCHEMA SETUP
-- ============================================================

CREATE DATABASE retail_sales;
GO

USE retail_sales;
GO

-- Customers table
CREATE TABLE customers (
    customer_id     INT PRIMARY KEY IDENTITY(1,1),
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    city            VARCHAR(50),
    state           VARCHAR(50),
    signup_date     DATE
);

-- Products table
CREATE TABLE products (
    product_id      INT PRIMARY KEY IDENTITY(1,1),
    product_name    VARCHAR(100) NOT NULL,
    category        VARCHAR(50),
    unit_price      DECIMAL(10, 2) NOT NULL,
    stock_quantity  INT DEFAULT 0
);

-- Orders table
CREATE TABLE orders (
    order_id        INT PRIMARY KEY IDENTITY(1,1),
    customer_id     INT NOT NULL,
    order_date      DATE NOT NULL,
    status          VARCHAR(20) DEFAULT 'Completed',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE order_items (
    item_id         INT PRIMARY KEY IDENTITY(1,1),
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL,
    unit_price      DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id)    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);
GO


-- ============================================================
-- SECTION 2: SAMPLE DATA
-- ============================================================

INSERT INTO customers (first_name, last_name, email, city, state, signup_date) VALUES
('James',   'Smith',    'james.smith@email.com',    'Brisbane',  'QLD', '2022-01-15'),
('Sarah',   'Johnson',  'sarah.j@email.com',        'Sydney',    'NSW', '2022-03-22'),
('Michael', 'Williams', 'mike.w@email.com',         'Melbourne', 'VIC', '2022-05-10'),
('Emily',   'Brown',    'emily.b@email.com',        'Brisbane',  'QLD', '2022-07-08'),
('David',   'Jones',    'david.j@email.com',        'Perth',     'WA',  '2022-09-14'),
('Jessica', 'Davis',    'jess.d@email.com',         'Adelaide',  'SA',  '2023-01-20'),
('Daniel',  'Miller',   'daniel.m@email.com',       'Brisbane',  'QLD', '2023-03-05'),
('Ashley',  'Wilson',   'ashley.w@email.com',       'Sydney',    'NSW', '2023-06-18'),
('Chris',   'Moore',    'chris.m@email.com',        'Melbourne', 'VIC', '2023-08-25'),
('Amanda',  'Taylor',   'amanda.t@email.com',       'Brisbane',  'QLD', '2023-11-30');

INSERT INTO products (product_name, category, unit_price, stock_quantity) VALUES
('Wireless Headphones',  'Electronics', 149.99, 120),
('Running Shoes',        'Footwear',     89.99, 200),
('Coffee Maker',         'Appliances',  129.99,  80),
('Yoga Mat',             'Sports',       45.99, 150),
('Laptop Stand',         'Electronics',  59.99,  90),
('Water Bottle',         'Sports',       24.99, 300),
('Bluetooth Speaker',    'Electronics',  79.99, 110),
('Office Chair',         'Furniture',   299.99,  40),
('Desk Lamp',            'Furniture',    39.99, 175),
('Protein Powder',       'Health',       69.99, 130);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1,  '2023-01-10', 'Completed'),
(2,  '2023-01-15', 'Completed'),
(3,  '2023-02-05', 'Completed'),
(4,  '2023-02-20', 'Completed'),
(5,  '2023-03-08', 'Completed'),
(1,  '2023-03-22', 'Completed'),
(6,  '2023-04-10', 'Completed'),
(7,  '2023-04-25', 'Completed'),
(2,  '2023-05-15', 'Completed'),
(8,  '2023-06-01', 'Completed'),
(3,  '2023-06-18', 'Completed'),
(9,  '2023-07-07', 'Completed'),
(10, '2023-07-22', 'Completed'),
(4,  '2023-08-10', 'Completed'),
(5,  '2023-09-05', 'Completed'),
(1,  '2023-09-20', 'Completed'),
(6,  '2023-10-12', 'Completed'),
(7,  '2023-11-01', 'Completed'),
(8,  '2023-11-18', 'Completed'),
(10, '2023-12-05', 'Completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,  1,  1, 149.99),
(1,  5,  2,  59.99),
(2,  2,  1,  89.99),
(2,  4,  1,  45.99),
(3,  3,  1, 129.99),
(3,  6,  2,  24.99),
(4,  7,  1,  79.99),
(4,  9,  1,  39.99),
(5,  8,  1, 299.99),
(6,  1,  1, 149.99),
(6,  10, 2,  69.99),
(7,  2,  2,  89.99),
(8,  5,  1,  59.99),
(8,  6,  3,  24.99),
(9,  3,  1, 129.99),
(10, 4,  2,  45.99),
(11, 7,  1,  79.99),
(12, 9,  2,  39.99),
(13, 10, 1,  69.99),
(14, 1,  1, 149.99),
(15, 2,  1,  89.99),
(16, 8,  1, 299.99),
(17, 3,  1, 129.99),
(18, 6,  4,  24.99),
(19, 5,  2,  59.99),
(20, 7,  1,  79.99);
GO


-- ============================================================
-- SECTION 3: ANALYSIS QUERIES
-- ============================================================

-- ------------------------------------------------------------
-- Query 1: Total Revenue by Month
-- Aggregation + Date formatting
-- ------------------------------------------------------------
SELECT
    FORMAT(o.order_date, 'yyyy-MM')         AS order_month,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(oi.quantity * oi.unit_price)        AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY order_month;


-- ------------------------------------------------------------
-- Query 2: Top 5 Best-Selling Products by Revenue
-- Aggregation + JOIN + TOP
-- ------------------------------------------------------------
SELECT TOP 5
    p.product_name,
    p.category,
    SUM(oi.quantity)                        AS total_units_sold,
    SUM(oi.quantity * oi.unit_price)        AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- Query 3: Customer Lifetime Value (CLV)
-- JOIN across 3 tables + aggregation
-- ------------------------------------------------------------
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name        AS customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(oi.quantity * oi.unit_price)        AS lifetime_value
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.state
ORDER BY lifetime_value DESC;


-- ------------------------------------------------------------
-- Query 4: Revenue by State
-- Geographic sales breakdown
-- ------------------------------------------------------------
SELECT
    c.state,
    COUNT(DISTINCT c.customer_id)           AS total_customers,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(oi.quantity * oi.unit_price)        AS total_revenue
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY c.state
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- Query 5: Running Total Revenue (Window Function)
-- Cumulative revenue over time
-- ------------------------------------------------------------
WITH monthly_revenue AS (
    SELECT
        FORMAT(o.order_date, 'yyyy-MM')     AS order_month,
        SUM(oi.quantity * oi.unit_price)    AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY FORMAT(o.order_date, 'yyyy-MM')
)
SELECT
    order_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY order_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                       AS running_total
FROM monthly_revenue
ORDER BY order_month;


-- ------------------------------------------------------------
-- Query 6: Customer Purchase Ranking by State (Window Function)
-- RANK customers by spend within each state
-- ------------------------------------------------------------
WITH customer_spend AS (
    SELECT
        c.customer_id,
        c.first_name + ' ' + c.last_name    AS customer_name,
        c.state,
        SUM(oi.quantity * oi.unit_price)    AS total_spend
    FROM customers c
    JOIN orders o       ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.state
)
SELECT
    customer_name,
    state,
    total_spend,
    RANK() OVER (
        PARTITION BY state
        ORDER BY total_spend DESC
    )                                       AS state_rank
FROM customer_spend
ORDER BY state, state_rank;


-- ------------------------------------------------------------
-- Query 7: Month-over-Month Revenue Growth (Window Function)
-- LAG function to calculate growth percentage
-- ------------------------------------------------------------
WITH monthly_revenue AS (
    SELECT
        FORMAT(o.order_date, 'yyyy-MM')     AS order_month,
        SUM(oi.quantity * oi.unit_price)    AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY FORMAT(o.order_date, 'yyyy-MM')
)
SELECT
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month)    AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY order_month))
        / LAG(revenue) OVER (ORDER BY order_month) * 100, 2
    )                                           AS growth_pct
FROM monthly_revenue
ORDER BY order_month;


-- ------------------------------------------------------------
-- Query 8: Products Never Ordered (Subquery)
-- Identify dead stock
-- ------------------------------------------------------------
SELECT
    product_id,
    product_name,
    category,
    unit_price,
    stock_quantity
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_items
);


-- ------------------------------------------------------------
-- Query 9: High-Value Orders Above Average (Subquery)
-- Orders where total exceeds the average order value
-- ------------------------------------------------------------
SELECT
    o.order_id,
    c.first_name + ' ' + c.last_name        AS customer_name,
    o.order_date,
    SUM(oi.quantity * oi.unit_price)        AS order_total
FROM orders o
JOIN customers c    ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, o.order_date
HAVING SUM(oi.quantity * oi.unit_price) > (
    SELECT AVG(order_total)
    FROM (
        SELECT SUM(quantity * unit_price) AS order_total
        FROM order_items
        GROUP BY order_id
    ) AS avg_orders
)
ORDER BY order_total DESC;


-- ------------------------------------------------------------
-- Query 10: Category Performance Summary (CTE)
-- Revenue, units sold, and average order value by category
-- ------------------------------------------------------------
WITH category_stats AS (
    SELECT
        p.category,
        COUNT(DISTINCT o.order_id)          AS total_orders,
        SUM(oi.quantity)                    AS total_units_sold,
        SUM(oi.quantity * oi.unit_price)    AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o   ON oi.order_id   = o.order_id
    GROUP BY p.category
)
SELECT
    category,
    total_orders,
    total_units_sold,
    total_revenue,
    ROUND(total_revenue / total_orders, 2)  AS avg_order_value
FROM category_stats
ORDER BY total_revenue DESC;


-- ============================================================
-- SECTION 4: STORED PROCEDURE
-- Get full sales summary for a given date range
-- ============================================================

CREATE PROCEDURE GetSalesSummary
    @start_date DATE,
    @end_date   DATE
AS
BEGIN
    SELECT
        FORMAT(o.order_date, 'yyyy-MM')         AS order_month,
        COUNT(DISTINCT o.order_id)              AS total_orders,
        COUNT(DISTINCT o.customer_id)           AS unique_customers,
        SUM(oi.quantity)                        AS total_units_sold,
        SUM(oi.quantity * oi.unit_price)        AS total_revenue,
        ROUND(
            SUM(oi.quantity * oi.unit_price)
            / COUNT(DISTINCT o.order_id), 2
        )                                       AS avg_order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date BETWEEN @start_date AND @end_date
    GROUP BY FORMAT(o.order_date, 'yyyy-MM')
    ORDER BY order_month;
END;
GO

-- Example usage:
-- EXEC GetSalesSummary @start_date = '2023-01-01', @end_date = '2023-12-31';
