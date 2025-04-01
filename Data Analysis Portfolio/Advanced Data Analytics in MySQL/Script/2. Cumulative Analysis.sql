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


