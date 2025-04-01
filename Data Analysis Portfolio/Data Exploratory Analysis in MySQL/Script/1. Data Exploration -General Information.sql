-- ========================================
-- 1. Data Exploration: General Information
-- ========================================

-- 1.1. Explore all distinct states of the customers
SELECT DISTINCT State 
FROM stores_sales_forecasting;

-- 1.2. Explore all categories and sub-categories in the dataset
SELECT DISTINCT Category, Sub_Category, Product_Name 
FROM stores_sales_forecasting
ORDER BY Category, Sub_Category, Product_Name;

-- 1.3. Find the date of the first and last order
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM stores_sales_forecasting;

-- 1.4. Find the Total Sales
SELECT SUM(sales) AS total_sales 
FROM stores_sales_forecasting;

-- 1.5. Find how many items are sold
SELECT COUNT(sales) AS sales_count 
FROM stores_sales_forecasting;

-- 1.6. Find the total number of orders
SELECT 
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT order_id) AS distinct_total_orders
FROM stores_sales_forecasting;

-- 1.7. Find the total number of products
SELECT 
    COUNT(product_name) AS count_product_name,
    COUNT(product_id) AS count_product_id,
    COUNT(DISTINCT product_id) AS count_distinct_id
FROM stores_sales_forecasting;

-- 1.8. Find the total number of customers
SELECT 
    COUNT(customer_id) AS count_customer_id,
    COUNT(customer_name) AS count_customer_name
FROM stores_sales_forecasting;

-- 1.9. Find the total number of customers who have placed an order
SELECT COUNT(DISTINCT customer_id) 
FROM stores_sales_forecasting;
