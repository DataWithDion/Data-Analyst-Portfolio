-- ========================================
-- 3. Sales and Customer Analysis
-- ========================================

-- 3.1. Find total customers by states
SELECT 
    state,
    COUNT(customer_id) AS total_customers
FROM stores_sales_forecasting
GROUP BY state
ORDER BY total_customers DESC;

-- 3.2. Find total products by categories (Sub-category)
SELECT
    Sub_category,
    COUNT(product_id) AS total_products
FROM stores_sales_forecasting
GROUP BY sub_category
ORDER BY total_products DESC;

-- 3.3. What is the total profit for each category?
SELECT 
    Sub_category,
    ROUND(SUM(Profit), 2) AS total_profit
FROM stores_sales_forecasting
GROUP BY Sub_category
ORDER BY total_profit DESC;

-- 3.4. What is the total profit generated by each customer?
SELECT 
    Customer_id,
    Customer_name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM stores_sales_forecasting
GROUP BY Customer_id, Customer_name
ORDER BY total_profit DESC;

-- 3.5. What is the distribution of sold items across states?
SELECT 
    State,
    SUM(quantity) AS total_sold_items
FROM stores_sales_forecasting
GROUP BY State
ORDER BY total_sold_items DESC;