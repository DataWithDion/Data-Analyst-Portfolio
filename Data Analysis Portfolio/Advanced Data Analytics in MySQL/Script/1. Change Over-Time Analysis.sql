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