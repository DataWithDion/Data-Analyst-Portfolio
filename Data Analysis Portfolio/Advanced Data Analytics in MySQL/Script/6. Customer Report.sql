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