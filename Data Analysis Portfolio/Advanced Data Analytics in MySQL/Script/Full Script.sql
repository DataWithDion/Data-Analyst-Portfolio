-- Advanced Analytics

-- ========================================
-- 1. Change Over-Time Analysis
-- ========================================

-- 1.1. Monthly Sales Analysis: Total Sales, Customers, and Quantity Sold by Month and Year
SELECT 
    YEAR(Order_date) AS order_year,
    MONTH(Order_date) AS order_month,
    ROUND(SUM(Sales), 2) AS total_sales,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM stores_sales_forecasting
GROUP BY YEAR(Order_date), MONTH(Order_date)
ORDER BY YEAR(Order_date), MONTH(Order_date) ASC;

-- ========================================
-- 2. Cumulative Analysis
-- ========================================

-- 2.1. Running Total Sales and Moving Average Profit by Month and Year
SELECT 
    order_year,
    total_sales,
    ROUND(SUM(total_sales) OVER(PARTITION BY order_year ORDER BY order_year, order_month ASC), 2) AS total_running_sales,
    ROUND(AVG(avg_profit) OVER(PARTITION BY order_year ORDER BY order_year, order_month ASC), 2) AS moving_average_profit
FROM (
    SELECT 
        YEAR(Order_date) AS order_year,
        MONTH(Order_date) AS order_month,
        ROUND(SUM(sales), 2) AS total_sales,
        AVG(profit) AS avg_profit
    FROM stores_sales_forecasting
    GROUP BY YEAR(Order_date), MONTH(Order_date)
) AS b;

-- 2.2. Cumulative Analysis with Month Included (Running Total and Moving Average)
SELECT 
    order_year,
    order_month,
    total_sales,
    ROUND(SUM(total_sales) OVER(PARTITION BY order_year ORDER BY order_year, order_month ASC), 2) AS total_running_sales,
    ROUND(AVG(avg_profit) OVER(PARTITION BY order_year ORDER BY order_year, order_month ASC), 2) AS moving_average_profit
FROM (
    SELECT 
        YEAR(Order_date) AS order_year,
        MONTH(Order_date) AS order_month,
        ROUND(SUM(sales), 2) AS total_sales,
        AVG(profit) AS avg_profit
    FROM stores_sales_forecasting
    GROUP BY YEAR(Order_date), MONTH(Order_date)
) AS b;

-- ========================================
-- 3. Performance Analysis
-- ========================================

-- 3.1. Yearly Product Sales Performance (Current vs Average and Previous Year)
WITH yearly_sales AS (
    SELECT 
        YEAR(order_date) AS order_year,
        product_name,
        ROUND(SUM(sales), 2) AS current_sales
    FROM stores_sales_forecasting
    GROUP BY YEAR(order_date), product_name
)
SELECT 
    order_year,
    product_name,
    current_sales,
    ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2) AS avg_current_sales,
    ROUND(current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2), 2) AS difference_in_avg,
    CASE 
        WHEN ROUND(current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2), 2) > 0 THEN 'Above Avg'
        WHEN ROUND(current_sales - ROUND(AVG(current_sales) OVER(PARTITION BY product_name), 2), 2) < 0 THEN 'Below Avg'
        ELSE 'AVG'
    END AS change_in_avg,
    LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,
    ROUND(current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year), 2) AS diff_previous_year,
    CASE 
        WHEN ROUND(current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year), 2) > 0 THEN 'Increase'
        WHEN ROUND(current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year), 2) < 0 THEN 'Decrease'
        ELSE 'No change'
    END AS previous_year_change
FROM yearly_sales
ORDER BY product_name, order_year;

-- ========================================
-- 4. Part-To-Whole Analysis
-- ========================================

-- 4.1. Sub-category Contribution to Total Sales
WITH sub_category_sales AS (
    SELECT
        Sub_category,
        ROUND(SUM(sales), 2) AS total_sales
    FROM stores_sales_forecasting
    GROUP BY Sub_category
)
SELECT 
    Sub_category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    CONCAT(ROUND((total_sales / SUM(total_sales) OVER ()) * 100, 2), '%') AS percentage_of_total
FROM sub_category_sales
ORDER BY total_sales DESC;

-- 4.2. State Contribution to Total Sales
WITH state_sales AS (
    SELECT
        State,
        ROUND(SUM(sales), 2) AS total_sales
    FROM stores_sales_forecasting
    GROUP BY state
)
SELECT 
    state,
    total_sales,
    ROUND(SUM(total_sales) OVER (), 2) AS overall_state_sales,
    CONCAT(ROUND((total_sales / SUM(total_sales) OVER ()) * 100, 2), '%') AS percentage_of_total
FROM state_sales
ORDER BY total_sales DESC;

-- ========================================
-- 5. Data Segmentation
-- ========================================

-- 5.1. Segment Products by Profit Ranges and Count Products in Each Segment
WITH product_segmentation AS (
    SELECT 
        Product_id,
        Product_name,
        profit,
        CASE 
            WHEN profit < 100 THEN 'Below 100'
            WHEN profit BETWEEN 100 AND 500 THEN '100 - 500'
            ELSE 'Above 500'
        END AS profit_range
    FROM stores_sales_forecasting
)
SELECT 
    profit_range,
    COUNT(Product_id) AS total_products
FROM product_segmentation
GROUP BY profit_range
ORDER BY total_products DESC;


-- ========================================
-- CUSTOMER REPORT VIEW
-- ========================================
-- Purpose:
-- This report presents key customer metrics, focusing on 
-- transaction details, order behavior, and key performance indicators (KPIs).
-- 
-- HIGHLIGHTS:
-- 1. Extract essential customer fields (ID, name, transaction details)
-- 2. Aggregate customer-level metrics:
--    - Total orders
--    - Total sales 
--    - Total quantity purchased 
--    - Total unique products bought
-- 3. Compute key KPIs:
--    - Average Order Value (AOV)
-- ========================================

CREATE VIEW store_sales.report_customers AS 

WITH base_query AS (
    -- ==============================================
    -- Base Query: Retrieve core transaction details
    -- ==============================================
    SELECT 
        Order_ID,
        Product_ID,
        order_date,
        Sales,
        Quantity,
        Customer_ID,
        Customer_Name
    FROM stores_sales_forecasting
)

-- ==============================================
-- Aggregation: Compute customer-level metrics
-- ==============================================
SELECT 
    customer_id,
    Customer_Name,
    COUNT(DISTINCT order_id) AS total_orders,         -- Total unique orders per customer
    ROUND(SUM(Sales), 2) AS total_sales,             -- Total sales amount
    SUM(quantity) AS total_quantity,                 -- Total items purchased
    COUNT(DISTINCT product_id) AS total_products,    -- Total distinct products bought
    MAX(order_date) AS last_order_date,              -- Most recent purchase date
    
    -- Compute Average Order Value (AOV): Total Sales ÷ Total Orders
    ROUND(SUM(Sales) / COUNT(DISTINCT order_id),2) AS avg_order_value

FROM base_query
GROUP BY customer_id, Customer_Name;