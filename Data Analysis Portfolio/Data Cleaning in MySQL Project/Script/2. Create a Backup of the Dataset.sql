-- 2. Create a Backup of the Dataset
-- This ensures that we can always revert to the original data in case of errors
CREATE TABLE dirty_cafe_sales_backup AS 
SELECT * FROM dirty_cafe_sales;
