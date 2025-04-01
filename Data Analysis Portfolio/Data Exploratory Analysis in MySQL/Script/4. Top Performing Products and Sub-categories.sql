-- ========================================
-- 4. Top Performing Products and Sub-categories
-- ========================================

-- 4.1. Which 5 products generate the highest revenue (by quantity sold)?
SELECT 
    Product_name,
    SUM(quantity) AS total_sold_items
FROM stores_sales_forecasting
GROUP BY Product_name
ORDER BY total_sold_items DESC
LIMIT 5;

-- 4.2. What are the 5 worst-performing products in terms of sales?
SELECT 
    Product_name,
    SUM(quantity) AS total_sold_items
FROM stores_sales_forecasting
GROUP BY Product_name
ORDER BY total_sold_items ASC
LIMIT 5;

-- 4.3. Which subcategories generate the highest revenue (by quantity sold)?
SELECT 
    Sub_category,
    SUM(quantity) AS total_sold_items
FROM stores_sales_forecasting
GROUP BY Sub_category
ORDER BY total_sold_items DESC
LIMIT 5;

-- 4.4. What are the  worst-performing sub-categories in terms of sales?
SELECT 
    Sub_category,
    SUM(quantity) AS total_sold_items
FROM stores_sales_forecasting
GROUP BY Sub_category
ORDER BY total_sold_items ASC;