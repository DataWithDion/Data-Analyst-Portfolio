-- ========================================
-- 2. Business Metrics Report
-- ========================================

-- 2.1. Generate a report with key business metrics
SELECT 'Total Sales' as measure_name, ROUND(SUM(sales), 2) AS measure_value 
FROM stores_sales_forecasting
UNION ALL
SELECT 'Total Quantity' as measure_name, SUM(quantity) AS measure_value 
FROM stores_sales_forecasting
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_id) 
FROM stores_sales_forecasting
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) 
FROM stores_sales_forecasting
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_id) 
FROM stores_sales_forecasting;
