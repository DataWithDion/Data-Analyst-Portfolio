-- ========================================
-- 5. Top Performing Customers
-- ========================================

-- 5.1. Find the top 10 customers who have generated the highest profit
SELECT 
    customer_id,
    customer_name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM stores_sales_forecasting
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- 5.2. Find the top 10 customers with the fewest orders placed
SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM stores_sales_forecasting
GROUP BY customer_id, customer_name
ORDER BY total_orders ASC
LIMIT 10;