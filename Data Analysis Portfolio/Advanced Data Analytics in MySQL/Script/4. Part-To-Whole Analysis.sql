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
