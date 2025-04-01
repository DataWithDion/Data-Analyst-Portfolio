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
