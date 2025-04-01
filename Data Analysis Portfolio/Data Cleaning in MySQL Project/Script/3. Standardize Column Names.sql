-- 3. Standardize Column Names
-- Rename columns to have a consistent naming convention
ALTER TABLE dirty_cafe_sales RENAME COLUMN `Transaction ID` TO `Transaction_ID`;
ALTER TABLE dirty_cafe_sales RENAME COLUMN `Price Per Unit` TO `Price_Per_Unit`;
ALTER TABLE dirty_cafe_sales RENAME COLUMN `Total Spent` TO `Total_Spent`;
ALTER TABLE dirty_cafe_sales RENAME COLUMN `Payment Method` TO `Payment_Method`;
ALTER TABLE dirty_cafe_sales RENAME COLUMN `Transaction Date` TO `Transaction_Date`;
