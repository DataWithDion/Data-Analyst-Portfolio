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
