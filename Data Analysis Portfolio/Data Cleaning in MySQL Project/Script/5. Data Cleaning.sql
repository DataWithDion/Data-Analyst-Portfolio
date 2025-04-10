-- 5. Data Cleaning
-- 5.1. Replace 'ERROR', 'UNKNOWN' and empty values with NULL in the 'Transaction_Date' column
UPDATE dirty_cafe_sales
SET Transaction_Date = NULL
WHERE Transaction_Date IN ('ERROR', 'UNKNOWN', '');

-- 5.2. Alter the Data Type of 'Transaction_Date' to DATE for consistency
ALTER TABLE dirty_cafe_sales
MODIFY COLUMN Transaction_Date DATE;

-- 5.3. Using CTE-based forward filling logic
WITH CTE_Rank AS(
SELECT 
transaction_id,
Transaction_date,
COUNT(transaction_date) OVER (ORDER BY transaction_ID) AS count_dates
FROM dirty_cafe_sales
)
SELECT 
transaction_id,
Transaction_date,
FIRST_VALUE(transaction_date) OVER(PARTITION BY count_dates ORDER BY transaction_id) AS Transaction_new_date
FROM CTE_Rank;

-- 5.4. Replace 'ERROR', 'UNKNOWN', and empty values with NULL in 'Total_Spent'
UPDATE dirty_cafe_sales
SET Total_Spent = NULL
WHERE Total_Spent IN ('ERROR', 'UNKNOWN', '');

-- 5.4. Calculate the average of 'Total_Spent' where values are not NULL
SELECT ROUND(AVG(Total_Spent), 2) AS avg_total_spent
FROM dirty_cafe_sales
WHERE Total_Spent IS NOT NULL;

-- 5.5. Store the calculated average in a variable
SET @avg_total_spent = (SELECT ROUND(AVG(Total_Spent), 2)
                        FROM dirty_cafe_sales
                        WHERE Total_Spent IS NOT NULL);

-- 5.6. Update the NULL values in 'Total_Spent' with the calculated average
UPDATE dirty_cafe_sales
SET Total_Spent = @avg_total_spent
WHERE Total_Spent IS NULL;

-- 5.7. Alter the Data Type of 'Total_Spent' to DOUBLE for consistency
ALTER TABLE dirty_cafe_sales
MODIFY COLUMN Total_Spent DOUBLE;

-- 5.8. Replace 'ERROR', 'UNKNOWN', and empty values with NULL in the 'Item' column
UPDATE dirty_cafe_sales
SET Item = NULL
WHERE Item IN ('ERROR', 'UNKNOWN', '');

-- 5.9. Replace 'ERROR', 'UNKNOWN', and empty values with NULL in the 'Payment_Method' column
UPDATE dirty_cafe_sales
SET Payment_Method = NULL
WHERE Payment_Method IN ('ERROR', 'UNKNOWN', '');

-- 5.10. Replace 'ERROR', 'UNKNOWN', and empty values with NULL in the 'Location' column
UPDATE dirty_cafe_sales
SET Location = NULL
WHERE Location IN ('ERROR', 'UNKNOWN', '');